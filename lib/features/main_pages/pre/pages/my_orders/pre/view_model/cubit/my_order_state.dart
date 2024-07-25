// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'my_order_cubit.dart';

class MyOrderState extends Equatable {
  const MyOrderState({
    this.myOrdersState = RequestState.loading,
    this.myOrderModel,
    this.erorrMessage = '',
  });
  final RequestState myOrdersState;
  final MyOrderModel? myOrderModel;
  final String erorrMessage;

  MyOrderState copyWith({
    RequestState? myOrdersState,
    MyOrderModel? myOrderModel,
    String? erorrMessage,
  }) {
    return MyOrderState(
      myOrdersState: myOrdersState ?? this.myOrdersState,
      myOrderModel: myOrderModel ?? this.myOrderModel,
      erorrMessage: erorrMessage ?? this.erorrMessage,
    );
  }

  @override
  List<Object?> get props => [myOrdersState, myOrderModel, erorrMessage];
}
