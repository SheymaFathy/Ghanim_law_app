import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/data/model/my_order_model/my_order_model.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/data/repo/my_order_repo.dart';

part 'my_order_state.dart';

class MyOrderCubit extends Cubit<MyOrderState> {
  MyOrderCubit(this.myOrderRepo) : super(const MyOrderState());
  final MyOrderRepo myOrderRepo;
  void fetchOrdersData() async {
    if (state.erorrStatusCode != null) {
      emit(state.copyWith(
        myOrdersState: RequestState.loading,
      ));
    }
    final response = await myOrderRepo.fetchOrdersData();
    response.fold((ifLeft) {
      emit(state.copyWith(
          myOrdersState: RequestState.erorr,
          erorrStatusCode: ifLeft.statusCode ?? 0,
          erorrMessage: ifLeft.erorrMessage));
    }, (ifRight) {
      print(ifRight);
      emit(state.copyWith(
          myOrdersState: RequestState.sucess, myOrderModel: ifRight));
    });
  }
}
