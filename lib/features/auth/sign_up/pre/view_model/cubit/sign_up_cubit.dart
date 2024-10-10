import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/features/auth/sign_up/data/model/get/sign_up_model.dart';
import 'package:ghanim_law_app/features/auth/sign_up/data/model/set/set_sign_up_model.dart';
import 'package:ghanim_law_app/features/auth/sign_up/data/repository/sign_up_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signUpRepo) : super(const SignUpState());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String countryCode = "";
  GlobalKey<FormState> formKey = GlobalKey();
  final SignUpRepo signUpRepo;
  toggleObscure() {
    emit(state.copyWith(
        isObscure: !state.isObscure,
        signUpNewAccoutState: AuthRequestState.normal));
  }

  bool _formValidate() => formKey.currentState!.validate();
  clearFiled() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
  }

  void fetchSignUp(SetSignUpModel data) async {
    if (_formValidate()) {
      emit(state.copyWith(signUpNewAccoutState: AuthRequestState.loading));
      final result = await signUpRepo.fetchSignUp(data);

      result.fold((ifLeft) {
        emit(state.copyWith(
            signUpNewAccoutErorrMessage: ifLeft.erorrMessage,
            signUpNewAccoutState: AuthRequestState.erorr));
      }, (ifRight) {
        emit(state.copyWith(
            signUpNewAccoutModel: ifRight,
            signUpNewAccoutState: AuthRequestState.sucess));
      });
    }
  }
}
