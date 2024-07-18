part of 'feedback_cubit.dart';

class FeedbackState extends Equatable {
  final String feedBackMessage;
  final RequestState feedbackRequestState;
  const FeedbackState({
    this.feedBackMessage = '',
    this.feedbackRequestState = RequestState.loading,
  });
  FeedbackState copyWith({
    String? feedBackMessage,
    RequestState? feedbackRequestState,
  }) {
    return FeedbackState(
      feedBackMessage: feedBackMessage ?? this.feedBackMessage,
      feedbackRequestState: feedbackRequestState ?? this.feedbackRequestState,
    );
  }

  @override
  List<Object> get props => [feedBackMessage, feedbackRequestState];
}
