part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.forgotPasswordState = AuthRequestState.normal,
    this.forgotPasswordFirstModel,
    this.forgotPasswordMessage = '',
    this.forgotPasswordGetCodeState = AuthRequestState.normal,
    this.forgotPasswordGetCodeModel,
    this.forgotPasswordGetCodeMessage = '',
    this.forgotPasswordResetState = AuthRequestState.normal,
    this.forgotPasswordResetModel,
    this.forgotPasswordResetMessage = '',
  });
  final AuthRequestState forgotPasswordState;
  final ForgotPasswordFirstModel? forgotPasswordFirstModel;
  final String forgotPasswordMessage;
  final AuthRequestState forgotPasswordGetCodeState;
  final ForgotPasswordFirstModel? forgotPasswordGetCodeModel;
  final String forgotPasswordGetCodeMessage;
  final AuthRequestState forgotPasswordResetState;
  final ForgotPasswordFirstModel? forgotPasswordResetModel;
  final String forgotPasswordResetMessage;

  ForgotPasswordState copyWith(
      {AuthRequestState? forgotPasswordState,
      ForgotPasswordFirstModel? forgotPasswordFirstModel,
      String? forgotPasswordMessage,
      AuthRequestState? forgotPasswordGetCodeState,
      ForgotPasswordFirstModel? forgotPasswordGetCodeModel,
      String? forgotPasswordGetCodeMessage,
      AuthRequestState? forgotPasswordResetState,
      ForgotPasswordFirstModel? forgotPasswordResetModel,
      String? forgotPasswordResetMessage}) {
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
      forgotPasswordResetState:
          forgotPasswordResetState ?? this.forgotPasswordResetState,
      forgotPasswordResetModel:
          forgotPasswordResetModel ?? this.forgotPasswordResetModel,
      forgotPasswordResetMessage:
          forgotPasswordResetMessage ?? this.forgotPasswordResetMessage,
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
        forgotPasswordResetState,
        forgotPasswordResetModel,
        forgotPasswordResetMessage
      ];
}
