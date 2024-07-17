part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.forgotPasswordState = AuthRequestState.normal,
    this.forgotPasswordFirstModel,
    this.forgotPasswordMessage = '',
    this.forgotPasswordGetCodeState = AuthRequestState.normal,
    this.forgotPasswordGetCodeModel,
    this.forgotPasswordGetCodeMessage = '',
  });
  final AuthRequestState forgotPasswordState;
  final ForgotPasswordFirstModel? forgotPasswordFirstModel;
  final String forgotPasswordMessage;
  final AuthRequestState forgotPasswordGetCodeState;
  final ForgotPasswordFirstModel? forgotPasswordGetCodeModel;
  final String forgotPasswordGetCodeMessage;

  ForgotPasswordState copyWith({
    AuthRequestState? forgotPasswordState,
    ForgotPasswordFirstModel? forgotPasswordFirstModel,
    String? forgotPasswordMessage,
    AuthRequestState? forgotPasswordGetCodeState,
    ForgotPasswordFirstModel? forgotPasswordGetCodeModel,
    String? forgotPasswordGetCodeMessage,
  }) {
    return ForgotPasswordState(
      forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
      forgotPasswordFirstModel:
          forgotPasswordFirstModel ?? this.forgotPasswordFirstModel,
      forgotPasswordMessage:
          forgotPasswordMessage ?? this.forgotPasswordMessage,
      forgotPasswordGetCodeState:
          forgotPasswordGetCodeState ?? this.forgotPasswordGetCodeState,
      forgotPasswordGetCodeModel:
          forgotPasswordGetCodeModel ?? this.forgotPasswordGetCodeModel,
      forgotPasswordGetCodeMessage:
          forgotPasswordGetCodeMessage ?? this.forgotPasswordGetCodeMessage,
    );
  }

  @override
  List<Object?> get props => [
        forgotPasswordState,
        forgotPasswordFirstModel,
        forgotPasswordMessage,
        forgotPasswordGetCodeState,
        forgotPasswordGetCodeModel,
        forgotPasswordGetCodeMessage,
      ];
}
