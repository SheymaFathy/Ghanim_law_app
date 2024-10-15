part of 'add_order_cubit.dart';

class AddOrderState {
  final List<XFile>? imageFiles;
  final List<PlatformFile>? pickedFiles;
  final bool isRecording;
  final XFile? records;
  final AddOrderResultModel? addOrderResultModel;
  final AuthRequestState addOrderState;
  final String erorrMessage;
  final bool validateFileExtensions;
  final bool validateFormValues;
  final AuthRequestState imageCompreeState;
  final String response;
  final List<MFPaymentMethod> paymentMethods;
  final String erorrPaymentMessage;
  final MFGetPaymentStatusResponse? paymentStatusResponse;
  final RequestState paymentStatusState;
  final PaymentState paymentSendState;
  final MFGetPaymentStatusResponse? executePaymentResponse;
  final bool isPaymentSuccess;
  final RequestState requestIdPaymentState;
  final MFSendPaymentResponse? paymentResponseOrderId;
  const AddOrderState(
      {this.imageFiles,
      this.pickedFiles,
      this.isRecording = false,
      this.records,
      this.addOrderResultModel,
      this.erorrMessage = '',
      this.validateFileExtensions = true,
      this.validateFormValues = true,
      this.imageCompreeState = AuthRequestState.normal,
      this.addOrderState = AuthRequestState.normal,
      this.erorrPaymentMessage = '',
      this.executePaymentResponse,
      this.isPaymentSuccess = false,
      this.paymentResponseOrderId,
      this.paymentMethods = const [],
      this.paymentStatusResponse,
      this.paymentStatusState = RequestState.loading,
      this.paymentSendState = PaymentState.init,
      this.requestIdPaymentState = RequestState.loading,
      this.response = ''});

  AddOrderState copyWith({
    List<XFile>? imageFiles,
    List<PlatformFile>? pickedFiles,
    Duration? currentPosition,
    Duration? totalDuration,
    XFile? records,
    bool? isRecording,
    bool? isPlaying,
    RequestState? playAudioState,
    AudioPlayer? audioPlayer,
    AddOrderResultModel? addOrderResultModel,
    AuthRequestState? addOrderState,
    String? erorrMessage,
    bool? validateFileExtensions,
    bool? validateFormValues,
    AuthRequestState? imageCompreeState,
    String? responsePayment,
    List<MFPaymentMethod>? paymentMethods,
    String? erorrPaymentMessage,
    MFGetPaymentStatusResponse? paymentStatusResponse,
    RequestState? paymentStatusState,
    PaymentState? paymentSendState,
    MFGetPaymentStatusResponse? executePaymentResponse,
    bool? isPaymentSuccess,
    RequestState? requestIdPaymentState,
    MFSendPaymentResponse? paymentResponseOrderId,
  }) {
    return AddOrderState(
      imageFiles: imageFiles ?? this.imageFiles,
      pickedFiles: pickedFiles ?? this.pickedFiles,
      isRecording: isRecording ?? this.isRecording,
      records: records ?? this.records,
      addOrderResultModel: addOrderResultModel ?? this.addOrderResultModel,
      addOrderState: addOrderState ?? AuthRequestState.normal,
      erorrMessage: erorrMessage ?? this.erorrMessage,
      validateFileExtensions: validateFileExtensions ?? true,
      validateFormValues: validateFormValues ?? true,
      imageCompreeState: imageCompreeState ?? AuthRequestState.normal,
      erorrPaymentMessage: erorrPaymentMessage ?? this.erorrPaymentMessage,
      executePaymentResponse:
          executePaymentResponse ?? this.executePaymentResponse,
      isPaymentSuccess: isPaymentSuccess ?? this.isPaymentSuccess,
      paymentResponseOrderId:
          paymentResponseOrderId ?? this.paymentResponseOrderId,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      paymentStatusResponse:
          paymentStatusResponse ?? this.paymentStatusResponse,
      paymentStatusState: paymentStatusState ?? this.paymentStatusState,
      paymentSendState: paymentSendState ?? this.paymentSendState,
      requestIdPaymentState:
          requestIdPaymentState ?? this.requestIdPaymentState,
    );
  }

  // @override
  // // TODO: implement props
  // List<Object?> get props => [
  //       imageFiles,
  //       pickedFiles,
  //       isRecording,
  //       records,
  //       addOrderResultModel,
  //       addOrderState,
  //       erorrMessage,
  //       validateFileExtensions,
  //       validateFormValues,
  //       imageCompreeState,
  //       erorrPaymentMessage,
  //       executePaymentResponse,
  //       isPaymentSuccess,
  //       paymentResponseOrderId,
  //       paymentMethods,
  //       paymentStatusResponse,
  //       paymentStatusState,
  //       paymentSendState,
  //       requestIdPaymentState,
  //       response,
  //     ];
}

enum PaymentState {
  init,
  methodsPaymentLoading,
  methodsPaymentSuccess,
  statusPaymentLoading,
  statusPaymentSuccess,
  executePaymentLoading,
  executePaymentSuccess,
  sendOrderIdLoading,
  sendOrderIdSuccess,
  sendOrderIdError,

  paymentErorr
}
