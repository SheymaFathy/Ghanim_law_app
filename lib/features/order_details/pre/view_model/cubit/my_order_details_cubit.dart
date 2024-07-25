import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/features/order_details/data/model/my_order_details_model/my_order_details_model.dart';
import 'package:ghanim_law_app/features/order_details/data/repo/my_order_details_repo.dart';

part 'my_order_details_state.dart';

class MyOrderDetailsCubit extends Cubit<MyOrderDetailsState> {
  MyOrderDetailsCubit(this.myOrderDetailsRepo)
      : super(const MyOrderDetailsState());
  final MyOrderDetailsRepo myOrderDetailsRepo;
  fetchOrderDetailsById(int id) async {
    emit(state.copyWith(
      myorderDetailsState: RequestState.loading,
    ));
    final response = await myOrderDetailsRepo.fetchOrderDetailsById(id);
    response.fold((ifLeft) {
      emit(state.copyWith(
          myorderDetailsState: RequestState.erorr,
          erorrMessage: ifLeft.erorrMessage));
    }, (ifRight) {
      emit(state.copyWith(
          myorderDetailsState: RequestState.sucess,
          myOrderDetailsModel: ifRight));
    });
  }
}
