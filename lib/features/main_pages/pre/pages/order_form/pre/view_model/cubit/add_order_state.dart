part of 'add_order_cubit.dart';

class AddOrderState {
  final List<XFile>? imageFiles;
  final List<PlatformFile>? pickedFiles;
  final bool isRecording;
  final Duration? currentPosition;
  final Duration? totalDuration;
  final List<String>? records;
  const AddOrderState(
      {this.imageFiles,
      this.pickedFiles,
      this.isRecording = false,
      this.currentPosition,
      this.totalDuration,
      this.records});

  AddOrderState copyWith(
      {List<XFile>? imageFiles,
      List<PlatformFile>? pickedFiles,
      Duration? currentPosition,
      Duration? totalDuration,
      List<String>? records,
      bool? isRecording}) {
    return AddOrderState(
        imageFiles: imageFiles ?? this.imageFiles,
        pickedFiles: pickedFiles ?? this.pickedFiles,
        isRecording: isRecording ?? this.isRecording,
        currentPosition: currentPosition ?? this.currentPosition,
        totalDuration: totalDuration ?? this.totalDuration,
        records: records ?? this.records);
  }
}
