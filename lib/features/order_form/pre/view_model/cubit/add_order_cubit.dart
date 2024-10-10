// ignore_for_file: avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:ghanim_law_app/features/order_form/data/model/add_order_model.dart';
import 'package:ghanim_law_app/features/order_form/data/model/add_order_result_model/add_order_result_model.dart';
import 'package:ghanim_law_app/features/order_form/data/repo/add_order_repo.dart';
import 'package:ghanim_law_app/features/payment/pre/view_model/cubit/payment_my_fatorah_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myfatoorah_flutter/MFModels.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../../../../../core/constants/app_router.dart';
import '../../../../../core/enum/enum.dart';
import '../../../../../core/get_it/service_locator.dart';
import '../../../../payment/data/model/invoice_model.dart';

part 'add_order_state.dart';

class AddOrderCubit extends HydratedCubit<AddOrderState> {
  AddOrderCubit(this.addOrderRepo) : super(const AddOrderState());
  final AddOrderRepo addOrderRepo;

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  MFGetPaymentStatusResponse? paymentResponse;
  String? previousOrderType;

  final ImagePicker picker = ImagePicker();
  List<XFile>? imageFiles = [];
  List<PlatformFile>? pickedFiles = [];
  XFile? recordsList;

  bool isRecording = false;
  String? fileRecordPath;
  final AudioRecorder recorder = AudioRecorder();

  // Clear Form
  void clearFields() {
    detailsController.clear();
    imageFiles?.clear();
    recordsList = null;
    pickedFiles?.clear();
    emitUpdatedState();
  }

  bool validateForm() => formKey.currentState!.validate();

  // Add Order Validation
  Future<void> validateAndAddOrder(
      BuildContext context, String orderType, String price) async {
    print(getIt<PaymentMyFatorahCubit>().serviceName);
    if (getIt<PaymentMyFatorahCubit>().serviceName == null) {
      resetPaymentStates();
      if (areOrderFieldsEmpty()) {
        emit(state.copyWith(validateFormValues: false));
      } else {
        navigateToPayment(context, orderType, price);
      }
    } else {
      handleExistingOrder(context, orderType, price);
    }
  }

  void resetPaymentStates() {
    getIt<PaymentMyFatorahCubit>().resetStates();
    getIt<PaymentMyFatorahCubit>().clear();
  }

  bool areOrderFieldsEmpty() {
    return (pickedFiles?.isEmpty ?? true) &&
        (imageFiles?.isEmpty ?? true) &&
        recordsList == null &&
        detailsController.text.isEmpty;
  }

  void navigateToPayment(BuildContext context, String orderType, String price) {
    GoRouter.of(context).push(
      AppRouter.kMyFatoora,
      extra: PaymentMyFatorahModel(
        serviceName: orderType,
        phone: phoneController.text,
        name: nameController.text,
        email: emailController.text,
        price: price,
      ),
    );
  }

  void handleExistingOrder(
      BuildContext context, String orderType, String price) {
    if (getIt<PaymentMyFatorahCubit>().serviceName == orderType) {
      navigateToPayment(context, orderType, price);
    } else {
      showOrderError(context);
    }
    Navigator.of(context).pop();
  }

  void showOrderError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'لا يمكنك تقديم طلب جديد حتى يتم الانتهاء من الطلب الحالي أو إصلاح الخطأ.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Fetch and Upload Order
  Future<void> fetchUploadOrder(String orderType) async {
    emit(state.copyWith(
        addOrderState: AuthRequestState.loading, validateFormValues: true));

    final response = await addOrderRepo.fetchAddOrder(
      AddOrderModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        description: detailsController.text,
        image: imageFiles,
        typeOrder: orderType,
        voice: recordsList,
        docs: pickedFiles,
      ),
    );

    response.fold(
      (error) => emit(state.copyWith(
          addOrderState: AuthRequestState.erorr,
          erorrMessage: error.erorrMessage)),
      (result) async {
        emit(state.copyWith(
            addOrderState: AuthRequestState.sucess,
            addOrderResultModel: result));
        resetPayment();
      },
    );
  }

  Future<void> resetPayment() async {
    getIt<PaymentMyFatorahCubit>().serviceName = null;
    await getIt<PaymentMyFatorahCubit>().resetStates();
    getIt<PaymentMyFatorahCubit>().clear();
  }

  // Image Operations
  Future<void> pickAndCompressImages() async {
    try {
      final selectedImages = await picker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        for (var image in selectedImages) {
          final compressedImage = await compressImage(image);
          if (compressedImage != null) {
            imageFiles!.add(compressedImage);
          }
        }
        emitUpdatedState();
      }
    } catch (e) {
      emit(state.copyWith(
          imageCompreeState: AuthRequestState.erorr,
          erorrMessage: "Error compressing image"));
    }
  }

  Future<XFile?> compressImage(XFile file) async {
    try {
      emit(state.copyWith(imageCompreeState: AuthRequestState.loading));

      final result = await FlutterImageCompress.compressAndGetFile(file.path,
          '${file.path.substring(0, file.path.lastIndexOf('/'))}/comp_${file.name}',
          quality: 70, format: CompressFormat.jpeg);
      emit(state.copyWith(imageCompreeState: AuthRequestState.sucess));
      return result;
    } catch (e) {
      emit(state.copyWith(
          imageCompreeState: AuthRequestState.erorr,
          erorrMessage: "Error compressing image"));
      return null;
    }
  }

  Future<void> captureAndCompressImage() async {
    try {
      final image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        final compressedImage = await compressImage(image);
        if (compressedImage != null) {
          imageFiles!.add(compressedImage);
          emitUpdatedState();
        }
      }
    } catch (e) {
      debugPrint("Error capturing or compressing image: $e");
    }
  }

  // File Operations
  void attachFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null &&
        ['pdf', 'doc', 'docx'].contains(result.files[0].extension)) {
      pickedFiles?.addAll(result.files);
      emitUpdatedState();
    }
  }

  // Audio Operations
  Future<void> startRecording() async {
    if (await recorder.hasPermission()) {
      fileRecordPath =
          "${(await getApplicationDocumentsDirectory()).path}/record_${DateTime.now().millisecondsSinceEpoch}.wav";
      await recorder.start(
          const RecordConfig(
              encoder: AudioEncoder.wav, sampleRate: 44100, bitRate: 128000),
          path: fileRecordPath!);
      isRecording = true;
      emit(state.copyWith(isRecording: true));
    }
  }

  Future<void> stopRecording() async {
    final path = await recorder.stop();
    if (path != null) {
      recordsList = XFile(path);
      emit(state.copyWith(records: recordsList, isRecording: false));
    }
  }

  void deleteFile(int index, String fileType) {
    if (fileType == 'image') {
      if (imageFiles!.isEmpty && state.imageFiles != null) {
        imageFiles = state.imageFiles;
        imageFiles?.removeAt(index);
      } else {
        imageFiles?.removeAt(index);
      }
      emitUpdatedState();
    } else if (fileType == 'audio') {
      if (recordsList == null && state.records != null) {
        recordsList = state.records;
        recordsList = null;
      } else {
        recordsList = null;
      }
      emitUpdatedState();
    } else {
      if (pickedFiles!.isEmpty && state.pickedFiles != null) {
        pickedFiles = state.pickedFiles;
        pickedFiles?.removeAt(index);
      } else {
        pickedFiles?.removeAt(index);
      }
      emitUpdatedState();
    }
  }

  void emitUpdatedState() {
    emit(state.copyWith(
        imageFiles: imageFiles,
        pickedFiles: pickedFiles,
        records: recordsList));
  }

  @override
  AddOrderState? fromJson(Map<String, dynamic> json) {
    try {
      return AddOrderState(
        imageFiles: (json['imageFiles'] as List<dynamic>?)
            ?.map((item) => XFile(item))
            .toList(),
        pickedFiles: (json['pickedFiles'] as List<dynamic>?)
            ?.map((item) => platformFileFromMap(item as Map<String, dynamic>))
            .toList(),
        isRecording: json['isRecording'] as bool,
        records: json['records'] != null ? XFile(json['records']) : null,
        addOrderState: AuthRequestState.values[json['addOrderState'] as int],
        erorrMessage:
            json['errorMessage'] != null ? json['errorMessage'] as String : "",
        validateFileExtensions: json['validateFileExtensions'] as bool,
        validateFormValues: json['validateFormValues'] as bool,
        imageCompreeState:
            AuthRequestState.values[json['imageCompressState'] as int],
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AddOrderState state) {
    return {
      'imageFiles': state.imageFiles?.map((e) => e.path).toList(),
      'pickedFiles':
          state.pickedFiles?.map((e) => platformFileToMap(e)).toList(),
      'isRecording': state.isRecording,
      'records': state.records?.path,
      'addOrderState': state.addOrderState.index,
      'errorMessage': state.erorrMessage,
      'validateFileExtensions': state.validateFileExtensions,
      'validateFormValues': state.validateFormValues,
      'imageCompressState': state.imageCompreeState.index,
    };
  }

  PlatformFile platformFileFromMap(Map<String, dynamic> map) {
    return PlatformFile(
      path: map['path'] as String?,
      name: map['name'] as String,
      size: map['size'] as int,
      bytes: map['bytes'] as Uint8List?,
      readStream: map['readStream'] as Stream<List<int>>?,
    );
  }

  Map<String, dynamic> platformFileToMap(PlatformFile file) {
    return {
      'path': file.path,
      'name': file.name,
      'size': file.size,
      'bytes': file.bytes,
      'readStream': file.readStream,
    };
  }
}
