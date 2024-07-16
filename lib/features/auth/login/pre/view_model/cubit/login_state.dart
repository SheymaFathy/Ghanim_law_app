part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({this.isObscure = true});
  final bool isObscure;

  LoginState copyWith({bool? isObscure}) {
    return LoginState(isObscure: isObscure ?? this.isObscure);
  }

  @override
  List<Object> get props => [isObscure];
}
