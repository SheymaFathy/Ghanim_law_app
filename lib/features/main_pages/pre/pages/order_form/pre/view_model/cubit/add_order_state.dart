part of 'add_order_cubit.dart';

class AddOrderState {
  final List<XFile>? imageFiles;
  final List<PlatformFile>? pickedFiles;

  const AddOrderState({this.imageFiles, this.pickedFiles});

  AddOrderState copyWith({
    List<XFile>? imageFiles,
    List<PlatformFile>? pickedFiles,
  }) {
    return AddOrderState(
      imageFiles: imageFiles ?? this.imageFiles,
      pickedFiles: pickedFiles ?? this.pickedFiles,
    );
  }
}
