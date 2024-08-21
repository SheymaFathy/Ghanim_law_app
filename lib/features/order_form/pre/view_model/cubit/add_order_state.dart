part of 'add_order_cubit.dart';

class AddOrderState {
  final List<XFile>? imageFiles;
  final List<PlatformFile>? pickedFiles;
  final bool isRecording;
  final XFile? records;
  final AddOrderResultModel? addOrderResultModel;
  final AuthRequestState addOrderState;
  final String erorrMessage;
  final bool validateFileExtensions;
  final bool validateFormValues;
  final AuthRequestState imageCompreeState;
  const AddOrderState(
      {this.imageFiles,
      this.pickedFiles,
      this.isRecording = false,
      this.records,
      this.addOrderResultModel,
      this.erorrMessage = '',
      this.validateFileExtensions = true,
      this.validateFormValues = true,
      this.imageCompreeState = AuthRequestState.normal,
      this.addOrderState = AuthRequestState.normal});

  AddOrderState copyWith(
      {List<XFile>? imageFiles,
      List<PlatformFile>? pickedFiles,
      Duration? currentPosition,
      Duration? totalDuration,
      XFile? records,
      bool? isRecording,
      bool? isPlaying,
      RequestState? playAudioState,
      AudioPlayer? audioPlayer,
      AddOrderResultModel? addOrderResultModel,
      AuthRequestState? addOrderState,
      String? erorrMessage,
      bool? validateFileExtensions,
      bool? validateFormValues,
      AuthRequestState? imageCompreeState}) {
    return AddOrderState(
        imageFiles: imageFiles ?? this.imageFiles,
        pickedFiles: pickedFiles ?? this.pickedFiles,
        isRecording: isRecording ?? this.isRecording,
        records: records ?? this.records,
        addOrderResultModel: addOrderResultModel ?? this.addOrderResultModel,
        addOrderState: addOrderState ?? AuthRequestState.normal,
        erorrMessage: erorrMessage ?? this.erorrMessage,
        validateFileExtensions: validateFileExtensions ?? true,
        validateFormValues: validateFormValues ?? true,
        imageCompreeState: imageCompreeState ?? AuthRequestState.normal);
  }
}
