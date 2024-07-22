import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../../../../../../core/enum/enum.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit() : super(const AddOrderState());

// gloabal Method
  void deleteFiles(int index, String fileType) {
    if (fileType == 'image') {
      imageFiles!.removeAt(index);
      emit(state.copyWith(imageFiles: imageFiles));
    } else if (fileType == 'audio') {
      recordsList!.removeAt(index);
      emit(state.copyWith(records: recordsList));
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
    } else {
      final directory = await getApplicationDocumentsDirectory();
      String fileName =
          "recording_${DateTime.now().millisecondsSinceEpoch}.m4a";
      fileRecordPath = "${directory.path}/$fileName";
      const config = RecordConfig(
        encoder: AudioEncoder.aacLc,
        sampleRate: 44100,
        bitRate: 128000,
      );
      await recorder.start(config, path: fileRecordPath!);

      isRecording = true;
      emit(state.copyWith(isRecording: isRecording));
    }
  }

  Future<void> stopRecording() async {
    await recorder.stop().then((onValue) {
      saveRecordInList(onValue!);
    });
    isRecording = false;
    emit(state.copyWith(isRecording: isRecording));
  }

  Future<void> saveRecordInList(String path) async {
    recordsList = (recordsList ?? [])..add(path);
    emit(state.copyWith(records: recordsList));
  }

  Future<void> initRecording(String path) async {
    await audioPlayer.setFilePath(path);
    emit(state.copyWith(
        totalDuration: audioPlayer.duration ?? const Duration(seconds: 0),
        playAudioState: RequestState.sucess));
    audioPlayer.positionStream.listen((position) {
      emit(state.copyWith(currentPosition: position));
      if (state.currentPosition!.inMilliseconds ==
          state.totalDuration!.inMilliseconds) {
        emit(state.copyWith(isPlaying: false));
      }
    });
  }

  Future<void> playRecording(String path) async {
    initRecording(path);
    audioPlayer.play();
    emit(state.copyWith(isPlaying: true));
  }

  Future<void> seekRecording(Duration dur) async {
    audioPlayer.seek(dur);

    emit(state.copyWith(currentPosition: dur));
  }

  Future<void> pauseRecording() async {
    audioPlayer.pause();
    emit(state.copyWith(isPlaying: false));
  }
// Audio Controllers  @override
}