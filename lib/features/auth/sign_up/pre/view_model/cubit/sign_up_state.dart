part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState(
      {this.isObscure = true,
      this.signUpNewAccoutState = AuthRequestState.normal,
      this.signUpNewAccoutErorrMessage = '',
      this.signUpNewAccoutModel});
  final bool isObscure;
  final AuthRequestState signUpNewAccoutState;
  final String signUpNewAccoutErorrMessage;
  final SignUpModel? signUpNewAccoutModel;
  SignUpState copyWith(
      {bool? isObscure,
      AuthRequestState? signUpNewAccoutState,
      String? signUpNewAccoutErorrMessage,
      SignUpModel? signUpNewAccoutModel}) {
    return SignUpState(
      isObscure: isObscure ?? this.isObscure,
      signUpNewAccoutState: signUpNewAccoutState ?? this.signUpNewAccoutState,
      signUpNewAccoutErorrMessage:
          signUpNewAccoutErorrMessage ?? this.signUpNewAccoutErorrMessage,
      signUpNewAccoutModel: signUpNewAccoutModel ?? this.signUpNewAccoutModel,
    );
  }

  @override
  List<Object?> get props => [
        isObscure,
        signUpNewAccoutState,
        signUpNewAccoutErorrMessage,
        signUpNewAccoutModel,
      ];
}
