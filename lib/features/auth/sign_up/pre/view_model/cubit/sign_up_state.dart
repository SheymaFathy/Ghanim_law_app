part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({this.isObscure = true});
  final bool isObscure;

  SignUpState copyWith({bool? isObscure}) {
    return SignUpState(isObscure: isObscure ?? this.isObscure);
  }

  @override
  List<Object> get props => [isObscure];
}
