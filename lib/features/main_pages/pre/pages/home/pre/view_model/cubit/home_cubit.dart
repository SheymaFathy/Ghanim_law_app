import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/data/model/home_model/home_model.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepoRepo) : super(const HomeState());
  final HomeRepoRepo homeRepoRepo;
  getHomeData() async {
    final result = await homeRepoRepo.fetchHomeData();
    result.fold((ifLeft) {
      emit(state.copyWith(
          homeDataState: RequestState.erorr,
          errorMessage: ifLeft.erorrMessage));
    }, (ifRight) {
      print(ifRight.myfatoorah!.mode);
      print(ifRight.myfatoorah!.accessToken);
      emit(state.copyWith(
          homeDataState: RequestState.sucess, homeModel: ifRight));
    });
  }
}
