import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/data/model/profile_model.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(const ProfileState());
  final ProfileRepo profileRepo;

  fetchProfileData() async {
    final result = await profileRepo.fetchProfileData();
    result.fold((ifLeft) {
      emit(state.copyWith(
          profileRequestState: RequestState.erorr,
          erorrMessage: ifLeft.erorrMessage));
    }, (ifRight) {
      emit(state.copyWith(
          profileRequestState: RequestState.sucess, profileModel: ifRight));
    });
  }
}
