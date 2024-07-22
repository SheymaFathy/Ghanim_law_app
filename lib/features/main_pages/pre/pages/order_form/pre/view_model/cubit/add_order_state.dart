part of 'add_order_cubit.dart';

class AddOrderState {
  final List<XFile>? imageFiles;
  final List<PlatformFile>? pickedFiles;
  final bool isRecording;

  final List<String>? records;

  const AddOrderState({
    this.imageFiles,
    this.pickedFiles,
    this.isRecording = false,
    this.records,
  });

  AddOrderState copyWith(
      {List<XFile>? imageFiles,
      List<PlatformFile>? pickedFiles,
      Duration? currentPosition,
      Duration? totalDuration,
      List<String>? records,
      bool? isRecording,
      bool? isPlaying,
      RequestState? playAudioState,
      AudioPlayer? audioPlayer}) {
    return AddOrderState(
      imageFiles: imageFiles ?? this.imageFiles,
      pickedFiles: pickedFiles ?? this.pickedFiles,
      isRecording: isRecording ?? this.isRecording,
      records: records ?? this.records,
    );
  }
}
