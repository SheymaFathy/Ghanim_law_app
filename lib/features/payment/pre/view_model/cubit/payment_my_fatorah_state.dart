// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_my_fatorah_cubit.dart';

class PaymentMyFatorahState extends Equatable {
  final String response;
  final List<MFPaymentMethod> paymentMethods;
  final String erorrMessage;
  final MFGetPaymentStatusResponse? paymentStatusResponse;
  final RequestState paymentStatusState;
  final PaymentState paymentSendState;
  final MFGetPaymentStatusResponse? executePaymentResponse;

//////////////
  const PaymentMyFatorahState({
    this.response = '',

    /////////////////////
    this.paymentStatusState = RequestState.loading,
    this.paymentStatusResponse,
    this.executePaymentResponse,
    this.paymentMethods = const [],
    this.paymentSendState = PaymentState.init,
    this.erorrMessage = '',
  });

  PaymentMyFatorahState copyWith({
    String? response,
    List<MFPaymentMethod>? paymentMethods,
    PaymentState? paymentSendState,
    String? erorrMessage,
    MFGetPaymentStatusResponse? paymentStatusResponse,
    RequestState? paymentStatusState,
    MFGetPaymentStatusResponse? executePaymentResponse,
  }) {
    return PaymentMyFatorahState(
      response: response ?? this.response,
      erorrMessage: erorrMessage ?? this.erorrMessage,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      paymentSendState: paymentSendState ?? this.paymentSendState,
      paymentStatusResponse:
          paymentStatusResponse ?? this.paymentStatusResponse,
      paymentStatusState: paymentStatusState ?? this.paymentStatusState,
      executePaymentResponse:
          executePaymentResponse ?? this.executePaymentResponse,
    );
  }

  @override
  List<Object?> get props => [
        response,
        paymentMethods,
        erorrMessage,
        paymentStatusResponse,
        paymentStatusState,
        paymentSendState,
        executePaymentResponse,
      ];
}

enum PaymentState {
  init,
  methodsPaymentLoading,
  methodsPaymentSuccess,
  requestPaymentLoading,
  requestPaymentSuccess,
  statusPaymentLoading,
  statusPaymentSuccess,
  executePaymentLoading,
  executePaymentSuccess,
  paymentErorr
}
