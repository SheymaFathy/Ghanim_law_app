import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/order_form/data/model/add_order_model.dart';
import 'package:ghanim_law_app/features/order_form/data/model/add_order_result_model/add_order_result_model.dart';
import 'package:ghanim_law_app/features/order_form/data/repo/add_order_repo.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../../../../../core/constants/app_router.dart';
import '../../../../../core/enum/enum.dart';
import '../../../../../core/get_it/service_locator.dart';
import '../../../../main_pages/pre/pages/home/pre/view_model/cubit/home_cubit.dart';
import '../../../../main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';
import '../../../../payment/data/model/invoice_model.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit(this.addOrderRepo) : super(const AddOrderState());
  final AddOrderRepo addOrderRepo;
// Payment My Fatorah
  PhoneNumber phoneNumber = PhoneNumber(isoCode: "QA");
  final ImagePicker picker = ImagePicker();
  List<XFile>? imageFiles = [];
  List<PlatformFile>? pickedFiles = [];
  XFile? recordsList;

  static int? paymentMethodId;

  togglePhoneNumber(PhoneNumber phoneNumberSelecte) {
    phoneNumber = phoneNumberSelecte;
    emit(state.copyWith(phoneNumber: phoneNumberSelecte));
  }

  Future<void> init(PaymentMyFatorahModel paymentMyFatorahModel) async {
    emit(state.copyWith(paymentSendState: PaymentState.init));
    if (Config.testAPIKey.isEmpty) {
      emit(state.copyWith(
          responsePayment:
              "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token"));
      return;
    }

    await MFSDK.init(
        getIt<HomeCubit>().state.homeModel!.myfatoorah!.accessToken!.toString(),
        getIt<HomeCubit>().state.homeModel!.myfatoorah!.country ?? "Qatar",
        getIt<HomeCubit>().state.homeModel!.myfatoorah!.mode!.toUpperCase());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initiatePayment(paymentMyFatorahModel);
    });
  }

  String convertToHexWithoutAlpha(int colorValue) {
    String hexString =
        colorValue.toRadixString(16).padLeft(8, '0').toUpperCase();

    return hexString.substring(2); // Returns the RGB part of the hex string
  }

  void setUpActionBar(BuildContext context) {
    MFSDK.setUpActionBar(
        toolBarTitleColor: "#Ffffff",
        toolBarTitle: "Checkout".tr(context),
        isShowToolBar: true);
  }

  Future<void> initiatePayment(
      PaymentMyFatorahModel paymentMyFatorahModel) async {
    emit(state.copyWith(paymentSendState: PaymentState.methodsPaymentLoading));
    var request = MFInitiatePaymentRequest(
        invoiceAmount: num.parse(paymentMyFatorahModel.price),
        currencyIso: MFCurrencyISO.QATAR_QAR);

    await MFSDK.initiatePayment(request, MFLanguage.ARABIC).then((value) {
      emit(state.copyWith(
          paymentMethods: value.paymentMethods!,
          paymentSendState: PaymentState.methodsPaymentSuccess));
      log('Initiate Payment Response: ${jsonEncode(value.toJson())}');
    }).catchError((error) {
      log('Initiate Payment Error: ${error.toString()}');
      emit(state.copyWith(
          erorrMessage: error.message,
          paymentSendState: PaymentState.paymentErorr));
    });
  }

  void log(String message) {
    debugPrint(message);
  }

  Future sendPayment(
      PaymentMyFatorahModel paymentMyFatorahModel, context) async {
    emit(state.copyWith(requestIdPaymentState: RequestState.loading));
    await PhoneNumber.getRegionInfoFromPhoneNumber(paymentMyFatorahModel.phone!)
        .then((onValue) async {
      final lenthNumber = onValue.dialCode!.length;

      var request = MFSendPaymentRequest(
          customerReference: paymentMyFatorahModel.orderID,
          displayCurrencyIso: MFCurrencyISO.QATAR_QAR,
          invoiceValue: int.parse(paymentMyFatorahModel.price),
          customerName: paymentMyFatorahModel.name,
          customerEmail: paymentMyFatorahModel.email,
          customerMobile: onValue.phoneNumber!.substring(1 + lenthNumber),
          mobileCountryCode: "+${onValue.dialCode}",
          invoiceItems: [
            MFInvoiceItem(
              quantity: 1,
              unitPrice: double.parse(paymentMyFatorahModel.price),
              itemName: paymentMyFatorahModel.serviceName,
            )
          ],
          notificationOption: MFNotificationOption.EMAIL);

      await MFSDK.sendPayment(request, MFLanguage.ARABIC).then((value) {
        log("Send Payment Response: ${jsonEncode(value.toJson())}");
        emit(state.copyWith(
            requestIdPaymentState: RequestState.sucess,
            paymentResponseOrderId: value));
      }).catchError((error) {
        //  error as MFException;

        log('Send Payment Error: ${error.toString()}');
        emit(state.copyWith(
            requestIdPaymentState: RequestState.erorr,
            erorrMessage: error.message));
      });
    }).catchError((onError) {
      GoRouter.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("This PhoneNumber is not valid".tr(context)),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  Future<void> executeRegularPayment(
    PaymentMyFatorahModel paymentMyFatorahModel,
    BuildContext context,
  ) async {
    emit(state.copyWith(paymentSendState: PaymentState.executePaymentLoading));

    setUpActionBar(context);
    PhoneNumber.getRegionInfoFromPhoneNumber(paymentMyFatorahModel.phone!)
        .then((onValue) async {
      final lenthNumber = onValue.dialCode!.length;
      var request = MFExecutePaymentRequest(
        customerReference: paymentMyFatorahModel.orderID,
        displayCurrencyIso: MFCurrencyISO.QATAR_QAR,
        customerEmail: paymentMyFatorahModel.email,
        customerName: paymentMyFatorahModel.name,
        paymentMethodId: paymentMethodId,
        customerMobile: onValue.phoneNumber!.substring(1 + lenthNumber),
        mobileCountryCode: "+${onValue.dialCode}",
        invoiceValue: double.parse(paymentMyFatorahModel.price),
        invoiceItems: [
          MFInvoiceItem(
            quantity: 1,
            unitPrice: double.parse(paymentMyFatorahModel.price),
            itemName: paymentMyFatorahModel.serviceName,
          )
        ],
      );

      await MFSDK
          .executePayment(request, MFLanguage.ARABIC, (invoiceId) {})
          .then((value) async {
        emit(state.copyWith(
            paymentSendState: PaymentState.executePaymentSuccess,
            executePaymentResponse: value));
        log("Execute Payment Response: ${jsonEncode(value.toJson())}");
        await fetchPainOrder(
            paymentMyFatorahModel.orderID!, value.invoiceId!.toString());
      }).catchError((error) {
        emit(state.copyWith(
            paymentSendState: PaymentState.paymentErorr,
            erorrMessage: error.message));
        log('Execute Payment Error: $error');
      });
    }).catchError((onError) {
      GoRouter.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("This PhoneNumber is not valid".tr(context)),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  fetchPainOrder(String orderId, String invoiceId) async {
    emit(state.copyWith(paymentSendState: PaymentState.sendOrderIdLoading));
    final result = await addOrderRepo.fetchPaidOrder(
        orderID: orderId, invoiceId: invoiceId);

    result.fold((ifLeft) {
      emit(state.copyWith(paymentSendState: PaymentState.sendOrderIdError));
    }, (ifRight) {
      emit(state.copyWith(paymentSendState: PaymentState.sendOrderIdSuccess));
    });
    print(state.paymentSendState);
  }

  void setMethodId(int id) {
    print(paymentMethodId);
    paymentMethodId = id;
  }

  Future<void> getPaymentStatus(
      PaymentMyFatorahModel paymentMyFatorahModel, context) async {
    emit(state.copyWith(paymentSendState: PaymentState.statusPaymentLoading));
    await sendPayment(paymentMyFatorahModel, context);
    MFGetPaymentStatusRequest request = MFGetPaymentStatusRequest(
        key: state.paymentResponseOrderId!.invoiceId!.toString(),
        keyType: MFKeyType.INVOICEID);

    await MFSDK.getPaymentStatus(request, MFLanguage.ARABIC).then((value) {
      print("ResPoser results:${value.toJson()} ");
      emit(state.copyWith(
          paymentSendState: PaymentState.statusPaymentSuccess,
          paymentStatusResponse: value));
    }).catchError((error) {
      emit(state.copyWith(
          paymentSendState: PaymentState.paymentErorr,
          erorrMessage: error.message));
    });
  }

  resetStates() {
    detailsController.text = '';
    recordsList = null;
    imageFiles?.clear();
    pickedFiles?.clear();
    detailsController.clear();

    // emit(state.copyWith(
    //   imageFiles: [],
    //   records: null,
    //   pickedFiles: [],
    // ));
  }

  // Payment MAyFatorah
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  String? countryCode = 'QA';
  final GlobalKey<FormState> formKey = GlobalKey();

  MFGetPaymentStatusResponse? paymentResponse;
  String? previousOrderType;

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
    if (areOrderFieldsEmpty()) {
      emit(state.copyWith(validateFormValues: false));
    } else {
      fetchUploadOrder(orderType, price, context);
    }
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
    navigateToPayment(context, orderType, price);
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
  Future<void> fetchUploadOrder(String orderType, String price, context) async {
    PhoneNumber.getRegionInfoFromPhoneNumber(state.phoneNumber == null
            ? phoneNumber.phoneNumber.toString()
            : state.phoneNumber!.phoneNumber!.toString())
        .then((onValue) async {
      emit(state.copyWith(
          addOrderState: AuthRequestState.loading, validateFormValues: true));

      final response = await addOrderRepo.fetchAddOrder(
        AddOrderModel(
          name: nameController.text,
          email: emailController.text,
          phone: "${onValue.phoneNumber}",
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
    }).catchError((onError) {
      onError as PlatformException;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("This PhoneNumber is not valid".tr(context)),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  Future<void> resetPayment() async {
    resetStates();
    // getIt<PaymentMyFatorahCubit>().clear();
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
}

class Config {
  static const String testAPIKey =
      "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";
}
