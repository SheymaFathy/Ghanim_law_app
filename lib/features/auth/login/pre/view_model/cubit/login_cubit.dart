import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ghanim_law_app/features/auth/login/data/model/login_model.dart';
import 'package:ghanim_law_app/features/auth/login/data/repository/login_repo.dart';

import '../../../../../../core/enum/enum.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(const LoginState());
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  final LoginRepo loginRepo;
  toggleObscure() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  bool _formValidate() => formKey.currentState!.validate();

  void fetchLogin(String email, String password) async {
    if (_formValidate()) {
      emit(state.copyWith(loginState: AuthRequestState.loading));
      final result = await loginRepo.fetchLogin(email, password);
      result.fold((ifLeft) {
        emit(state.copyWith(
            loginState: AuthRequestState.erorr,
            loginErorrMessage: ifLeft.erorrMessage));
      }, (ifRight) {
        emit(state.copyWith(
            loginState: AuthRequestState.sucess, loginModel: ifRight));
      });
    }
  }
}
