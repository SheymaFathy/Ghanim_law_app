import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/data/model/profile_model.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/data/repo/profile_repo.dart';

import '../../../data/model/set/set_profile_data_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(const ProfileState());
  final ProfileRepo profileRepo;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  initUpdatePrfileData(ProfileModel profile) {
    final profileData = profile.data;
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty) {
      nameController.text = profileData!.name!;
      phoneController.text = profileData.phone!;
      emailController.text = profileData.email!;
    }
  }

  bool validateFormKey() => formKey.currentState!.validate();
  updateProfile() async {
    if (validateFormKey()) {
      emit(state.copyWith(profileUpdateRequestState: AuthRequestState.loading));
      final result = await profileRepo.updateProfile(SetProfileDataModel(
          method: 'PUT',
          name: nameController.text,
          phone: phoneController.text,
          email: emailController.text));
      result.fold((ifLeft) {
        emit(state.copyWith(
            profileUpdateRequestState: AuthRequestState.erorr,
            profileUpdatErorreMessage: ifLeft.erorrMessage));
      }, (ifRight) {
        checkValuesFormFiled(
          ifRight,
        );
        emit(state.copyWith(
            profileUpdateRequestState: AuthRequestState.sucess,
            profileUpdateModel: ifRight,
            profileModel: ifRight));
      });
    }
  }

  checkValuesFormFiled(ProfileModel profile) {
    if (nameController.text != profile.data!.name ||
        phoneController.text != profile.data!.phone ||
        emailController.text != profile.data!.email) {
      emit(state.copyWith(
          checkValuesFormFiled: true,
          profileUpdateRequestState: AuthRequestState.normal));
    } else {
      emit(state.copyWith(
          checkValuesFormFiled: false,
          profileUpdateRequestState: AuthRequestState.normal));
    }
  }

  fetchProfileData() async {
    emit(state.copyWith(
      profileRequestState: RequestState.loading,
    ));
    final result = await profileRepo.fetchProfileData();
    result.fold((ifLeft) {
      emit(state.copyWith(
          profileRequestState: RequestState.erorr,
          profileErorrMessage: ifLeft.erorrMessage,
          profileErorrStatusCode: ifLeft.statusCode ?? 0));
    }, (ifRight) {
      emit(state.copyWith(
          profileRequestState: RequestState.sucess, profileModel: ifRight));
    });
  }
}
