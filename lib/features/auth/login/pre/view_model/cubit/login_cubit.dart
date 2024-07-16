import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ghanim_law_app/features/auth/login/data/repository/login_repo.dart';

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

  void fetchLogin({String? email, password}) {
    if (_formValidate()) {}
  }
}
