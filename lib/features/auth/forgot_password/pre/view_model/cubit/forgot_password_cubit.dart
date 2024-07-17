import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/data/repo/forgot_pssword_repo.dart';

import '../../../data/model/forgot_password_first_model/forgot_password_first_model.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.forgotPsswordRepo)
      : super(const ForgotPasswordState());
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  final ForgotPsswordRepo forgotPsswordRepo;
  static String userNameEnter = '';
  static String tokenRePassword = '';
  bool _formValidate() => formKey.currentState!.validate();
  forgotPasswordCheckEmail(String userName) async {
    if (_formValidate()) {
      userNameEnter = '';
      emit(state.copyWith(
        forgotPasswordState: AuthRequestState.loading,
      ));
      final result = await forgotPsswordRepo.fetchForgotPassword(userName);
      result.fold((ifLeft) {
        emit(state.copyWith(
          forgotPasswordState: AuthRequestState.erorr,
          forgotPasswordMessage: ifLeft.erorrMessage,
        ));
      }, (ifRight) {
        userNameEnter = userName;
        emit(state.copyWith(
          forgotPasswordState: AuthRequestState.sucess,
          forgotPasswordFirstModel: ifRight,
        ));
      });
    }
  }

  getResetPassowdCode(String code) async {
    emit(state.copyWith(
      forgotPasswordGetCodeState: AuthRequestState.loading,
    ));

    final result =
        await forgotPsswordRepo.fetchGetRestPasswordCode(userNameEnter, code);
    result.fold((ifLeft) {
      emit(state.copyWith(
        forgotPasswordGetCodeState: AuthRequestState.erorr,
        forgotPasswordGetCodeMessage: ifLeft.erorrMessage,
      ));
    }, (ifRight) {
      emit(state.copyWith(
        forgotPasswordGetCodeState: AuthRequestState.sucess,
        forgotPasswordGetCodeModel: ifRight,
      ));
    });
  }

  fetchRestPassword(String password) async {
    if (_formValidate()) {
      emit(state.copyWith(
        forgotPasswordResetState: AuthRequestState.loading,
      ));
      final result =
          await forgotPsswordRepo.fetchResetPassword(password, tokenRePassword);
      result.fold((ifLeft) {
        emit(state.copyWith(
          forgotPasswordResetState: AuthRequestState.erorr,
          forgotPasswordResetMessage: ifLeft.erorrMessage,
        ));
      }, (ifRight) {
        emit(state.copyWith(
          forgotPasswordResetState: AuthRequestState.sucess,
          forgotPasswordResetModel: ifRight,
        ));
      });
    }
  }
}
