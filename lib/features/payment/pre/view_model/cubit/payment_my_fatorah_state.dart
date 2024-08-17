// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_my_fatorah_cubit.dart';

class PaymentMyFatorahState extends Equatable {
  final String response;
  final int isSelectedPayment;
  final List<MFPaymentMethod> paymentMethods;
  final PaymentState paymentState;
  final String erorrMessage;
  const PaymentMyFatorahState(
      {this.response = '',
      this.isSelectedPayment = -1,
      this.paymentState = PaymentState.init,
      this.paymentMethods = const [],
      this.erorrMessage = ''});

  PaymentMyFatorahState copyWith(
      {String? response,
      int? isSelectedPayment,
      List<MFPaymentMethod>? paymentMethods,
      PaymentState? paymentState,
      String? erorrMessage}) {
    return PaymentMyFatorahState(
        response: response ?? this.response,
        paymentState: paymentState ?? this.paymentState,
        isSelectedPayment: isSelectedPayment ?? this.isSelectedPayment,
        erorrMessage: erorrMessage ?? this.erorrMessage,
        paymentMethods: paymentMethods ?? this.paymentMethods);
  }

  @override
  List<Object> get props =>
      [response, isSelectedPayment, paymentMethods, paymentState, erorrMessage];
}

enum PaymentState {
  init,
  requestloading,
  requestSuccess,
  requestErorr,
  excuteloading,
  excuteSuccess,
  excuteErorr,
}
