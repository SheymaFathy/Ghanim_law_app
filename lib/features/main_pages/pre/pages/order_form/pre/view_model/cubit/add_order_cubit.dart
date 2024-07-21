import 'package:bloc/bloc.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit() : super(AddOrderState());

// gloabal Method
  void deleteFiles(int index, String fileType) {
    if (fileType == 'image') {
      imageFiles!.removeAt(index);
      emit(state.copyWith(imageFiles: imageFiles));
    } else if (fileType == 'audoi') {
      //  addorderCubit.audioFiles.removeAt(index);
    } else {
      pickedFiles!.removeAt(index);
      emit(state.copyWith(pickedFiles: pickedFiles));
    }
  }

  // Images Controllers
  final ImagePicker picker = ImagePicker();
  List<XFile>? imageFiles;
  Future<void> pickImagesFromGallery() async {
    try {
      final List<XFile>? selectedImages = await picker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        imageFiles = (imageFiles ?? [])..addAll(selectedImages);
        emit(state.copyWith(imageFiles: imageFiles));
      }
    } catch (e) {
      print("Error picking images: $e");
      // Handle error state
    }
  }

  Future<void> takePictureWithCamera() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imageFiles = (imageFiles ?? [])..add(image);
        emit(state.copyWith(imageFiles: imageFiles));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error taking picture: $e");
      }
    }
  }
  // Images Controllers

  // Files Controllers
  List<PlatformFile>? pickedFiles;
  void openFiles(List<PlatformFile> files) {
    pickedFiles = (pickedFiles ?? [])..addAll(files);
    emit(state.copyWith(pickedFiles: pickedFiles));
  }

  void attachFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'mp3', 'docx', 'xls', 'wav'],
    );
    if (result != null) {
      openFiles(result.files);
    }
  }
// Files Controllers
}
