import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/feedback/data/repo/fedback_repo.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit(this.fedbackRepo) : super(const FeedbackState());
  final FedbackRepo fedbackRepo;
  sendFeedBackMessage(Map<String, dynamic> data) async {
    emit(state.copyWith(feedbackRequestState: RequestState.loading));
    final result = await fedbackRepo.sendFeedBackMessage(data);
    result.fold((ifLeft) {
      emit(state.copyWith(
          feedbackRequestState: RequestState.erorr,
          feedBackMessage: ifLeft.erorrMessage));
    }, (ifRight) {
      emit(state.copyWith(
          feedBackMessage: ifRight, feedbackRequestState: RequestState.sucess));
    });
  }
}
