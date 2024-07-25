// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_order_details_cubit.dart';

class MyOrderDetailsState extends Equatable {
  const MyOrderDetailsState({
    this.myorderDetailsState = RequestState.loading,
    this.erorrMessage = '',
    this.myOrderDetailsModel,
  });
  final RequestState myorderDetailsState;
  final String erorrMessage;
  final MyOrderDetailsModel? myOrderDetailsModel;
  @override
  List<Object?> get props => [
        myorderDetailsState,
        erorrMessage,
        myOrderDetailsModel,
      ];

  MyOrderDetailsState copyWith({
    RequestState? myorderDetailsState,
    String? erorrMessage,
    MyOrderDetailsModel? myOrderDetailsModel,
  }) {
    return MyOrderDetailsState(
      myorderDetailsState: myorderDetailsState ?? this.myorderDetailsState,
      erorrMessage: erorrMessage ?? this.erorrMessage,
      myOrderDetailsModel: myOrderDetailsModel ?? this.myOrderDetailsModel,
    );
  }
}
