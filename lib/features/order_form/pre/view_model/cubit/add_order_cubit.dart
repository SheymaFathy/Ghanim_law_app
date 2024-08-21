import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:ghanim_law_app/features/order_form/data/model/add_order_model.dart';
import 'package:ghanim_law_app/features/order_form/data/model/add_order_result_model/add_order_result_model.dart';
import 'package:ghanim_law_app/features/order_form/data/repo/add_order_repo.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myfatoorah_flutter/MFModels.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../../../../../core/constants/app_router.dart';
import '../../../../../core/enum/enum.dart';
import '../../../../payment/data/model/invoice_model.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit(this.addOrderRepo) : super(const AddOrderState());
  final AddOrderRepo addOrderRepo;
  // gloabal Method
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  String countryCode = '+93';
  GlobalKey<FormState> formKey = GlobalKey();
  MFGetPaymentStatusResponse? paymetnResponse;
  clearFiled() {
    if (detailsController.text.isNotEmpty) {
      detailsController.clear();
    }
    if (imageFiles != null) {
      imageFiles!.clear();
    }
    if (recordsList != null) {
      recordsList = null;
    }
    if (pickedFiles != null) {
      pickedFiles!.clear();
    }

    emit(state.copyWith(
        imageFiles: imageFiles,
        records: recordsList,
        pickedFiles: pickedFiles));
  }

  bool validateFormKey() => formKey.currentState!.validate();
  validatorAddOrder(
      BuildContext context, String orderType, String price) async {
    if ((pickedFiles!.isEmpty && imageFiles!.isEmpty && recordsList == null) &&
        detailsController.text.isEmpty) {
      emit(state.copyWith(validateFormValues: false));
    } else {
      GoRouter.of(context)
          .push(AppRouter.kMyFatoora,
              extra: PaymentMyFatorahModel(
                  serviceName: orderType,
                  countryCode: countryCode,
                  phone: phoneController.text,
                  name: nameController.text,
                  email: emailController.text,
                  price: price))
          .then((onValue) {});
    }
    Navigator.of(context).pop();
  }

  Future<XFile> compressImage(XFile file) async {
    emit(state.copyWith(imageCompreeState: AuthRequestState.loading));
    final result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      '${file.path}/temp_${file.name}',
      quality: 80,
    );
    emit(state.copyWith(imageCompreeState: AuthRequestState.sucess));
    return result!;
  }

  fetchUploadOrder(String orderType) async {
    emit(state.copyWith(
        addOrderState: AuthRequestState.loading, validateFormValues: true));

    final response = await addOrderRepo.fetchAddOrder(AddOrderModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        description: detailsController.text,
        image: imageFiles,
        typeOrder: orderType,
        voice: recordsList,
        docs: pickedFiles));
    response.fold((ifLeft) {
      emit(state.copyWith(
          addOrderState: AuthRequestState.erorr,
          erorrMessage: ifLeft.erorrMessage));
    }, (ifRight) {
      emit(state.copyWith(
          addOrderState: AuthRequestState.sucess,
          addOrderResultModel: ifRight));
    });
    paymetnResponse = null;
  }

  void deleteFiles(int index, String fileType) {
    if (fileType == 'image') {
      imageFiles!.removeAt(index);
      emit(state.copyWith(imageFiles: imageFiles));
    } else if (fileType == 'audio') {
      recordsList = null;
      emit(state.copyWith(records: recordsList));
    } else {
      pickedFiles!.removeAt(index);
      emit(state.copyWith(pickedFiles: pickedFiles));
    }
  }

// gloabal Method
  // Images Controllers
  final ImagePicker picker = ImagePicker();
  List<XFile>? imageFiles = [];
  Future<void> pickImagesFromGallery() async {
    try {
      final List<XFile> selectedImages = await picker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        imageFiles = (imageFiles ?? [])..addAll(selectedImages);
        emit(state.copyWith(imageFiles: imageFiles));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking images: $e");
      }
    }
  }

  Future<void> takePictureWithCamera() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imageFiles = (imageFiles ?? [])..add(image);
        emit(state.copyWith(imageFiles: imageFiles));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error taking picture: $e");
      }
    }
  }
  // Images Controllers

  // Files Controllers
  List<PlatformFile>? pickedFiles = [];
  void openFiles(List<PlatformFile> files) {
    pickedFiles = (pickedFiles ?? [])..addAll(files);
    emit(state.copyWith(pickedFiles: pickedFiles));
  }

  void attachFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null &&
        (result.files[0].extension == 'pdf' ||
            result.files[0].extension == 'doc' ||
            result.files[0].extension == 'docx')) {
      openFiles(result.files);
    } else {
      if (result != null) {
        emit(state.copyWith(validateFileExtensions: false));
      }
    }
  }
// Files Controllers

// Records Controllers

  final AudioRecorder recorder = AudioRecorder();
  XFile? recordsList;
  bool isRecording = false;
  String? fileRecordPath;

  Future<void> startRecording() async {
    final bool isPermissionGranted = await recorder.hasPermission();
    if (!isPermissionGranted) {
      return;
    } else {
      final directory = await getApplicationDocumentsDirectory();
      String fileName =
          "recording_${DateTime.now().millisecondsSinceEpoch}.wav";
      fileRecordPath = "${directory.path}/$fileName";
      const config = RecordConfig(
        encoder: AudioEncoder.wav,
        sampleRate: 44100,
        bitRate: 128000,
      );
      await recorder.start(config, path: fileRecordPath!);

      isRecording = true;
      emit(state.copyWith(isRecording: isRecording));
    }
  }

  Future<void> stopRecording() async {
    await recorder.stop().then((onValue) {
      saveRecordInList(onValue!);
    });
    isRecording = false;
    emit(state.copyWith(isRecording: isRecording));
  }

  Future<void> saveRecordInList(String path) async {
    recordsList = XFile(path);
    emit(state.copyWith(records: recordsList));
  }

// Records Controllers
}
