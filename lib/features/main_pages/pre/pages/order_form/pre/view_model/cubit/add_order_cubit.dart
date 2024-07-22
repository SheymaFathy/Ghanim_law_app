import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit() : super(const AddOrderState());

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
      final List<XFile> selectedImages = await picker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        imageFiles = (imageFiles ?? [])..addAll(selectedImages);
        emit(state.copyWith(imageFiles: imageFiles));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking images: $e");
      }
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

// Audio Controllers
  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioRecorder recorder = AudioRecorder();
  List<String>? recordsList;
  bool isRecording = false;
  String? fileRecordPath;

  Future<void> startRecording() async {
    final bool isPermissionGranted = await recorder.hasPermission();
    if (!isPermissionGranted) {
      return;
    }
    final directory = await getApplicationDocumentsDirectory();
    String fileName = "recording_${DateTime.now().millisecondsSinceEpoch}.m4a";
    fileRecordPath = "${directory.path}/$fileName";
    const config = RecordConfig(
      // Specify the format, encoder, sample rate, etc., as needed
      encoder: AudioEncoder.aacLc, // For example, using AAC codec
      sampleRate: 44100, // Sample rate
      bitRate: 128000, // Bit rate
    );
    await recorder.start(config, path: fileRecordPath!);

    isRecording = true;
    emit(state.copyWith(isRecording: isRecording));
  }

  Future<void> stopRecording() async {
    await recorder.stop();
    isRecording = false;
    emit(state.copyWith(isRecording: isRecording));
  }

  Future<void> saveRecordInList(String path) async {
    print(fileRecordPath != null);
    recordsList = (recordsList ?? [])..add(path);
    emit(state.copyWith(records: recordsList));
  }

  Future<void> playRecording(int index) async {
    if (fileRecordPath != null) {
      await audioPlayer.setFilePath(recordsList![index]);
      audioPlayer.play();
      emit(state.copyWith(
          totalDuration: audioPlayer.duration ?? const Duration(seconds: 0)));
      audioPlayer.positionStream.listen((position) {
        emit(state.copyWith(currentPosition: position));
      });
    }
  }

// Audio Controllers  @override
}
