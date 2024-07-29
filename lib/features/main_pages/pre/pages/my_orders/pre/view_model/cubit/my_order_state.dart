// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'my_order_cubit.dart';

class MyOrderState extends Equatable {
  const MyOrderState(
      {this.myOrdersState = RequestState.loading,
      this.myOrderModel,
      this.erorrMessage = '',
      this.erorrStatusCode});
  final RequestState myOrdersState;
  final MyOrderModel? myOrderModel;
  final String erorrMessage;
  final int? erorrStatusCode;

  MyOrderState copyWith({
    RequestState? myOrdersState,
    MyOrderModel? myOrderModel,
    String? erorrMessage,
    int? erorrStatusCode,
  }) {
    return MyOrderState(
        myOrdersState: myOrdersState ?? this.myOrdersState,
        myOrderModel: myOrderModel ?? this.myOrderModel,
        erorrMessage: erorrMessage ?? this.erorrMessage,
        erorrStatusCode: erorrStatusCode ?? this.erorrStatusCode);
  }

  @override
  List<Object?> get props =>
      [myOrdersState, myOrderModel, erorrMessage, erorrStatusCode];
}
