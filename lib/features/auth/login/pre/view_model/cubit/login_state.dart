part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.isObscure = true,
      this.loginState = AuthRequestState.normal,
      this.loginErorrMessage = "",
      this.loginModel});
  final bool isObscure;
  final AuthRequestState loginState;
  final String loginErorrMessage;
  final LoginModel? loginModel;

  LoginState copyWith(
      {bool? isObscure,
      AuthRequestState? loginState,
      String? loginErorrMessage,
      LoginModel? loginModel}) {
    return LoginState(
      isObscure: isObscure ?? this.isObscure,
      loginState: loginState ?? this.loginState,
      loginErorrMessage: loginErorrMessage ?? this.loginErorrMessage,
      loginModel: loginModel ?? this.loginModel,
    );
  }

  @override
  List<Object?> get props =>
      [isObscure, loginState, loginErorrMessage, loginModel];
}
