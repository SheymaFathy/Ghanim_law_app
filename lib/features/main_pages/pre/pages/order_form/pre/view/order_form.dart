import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/core/widget/custom_button.dart';
import 'package:ghanim_law_app/core/widget/global_textfield.dart';
import 'package:ghanim_law_app/features/auth/widget/custom_auth_title.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/order_form/pre/view/widgets/custom_attached_row.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles;
  List<PlatformFile>? _pickedFiles;
  List<String> _audioFiles = [];
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  String? _audioPath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await _recorder.openRecorder();
    await _player.openPlayer();
  }

  Future<void> _recordVoice(BuildContext context) async {
    if (_isRecording) {
      await _recorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    } else {
      _audioPath = 'audio_${DateTime.now().millisecondsSinceEpoch}.aac';
      await _recorder.startRecorder(
        toFile: _audioPath,
        codec: Codec.aacADTS,
      );
      setState(() {
        _isRecording = true;
      });
    }
  }

  void _showRecordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('تسجيل الصوت'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _recordVoice(context);
                      setState(() {});
                    },
                    child: Text(_isRecording ? 'إيقاف التسجيل' : 'بدء التسجيل'),
                  ),
                  if (_audioPath != null)
                    ElevatedButton(
                      onPressed: () async {
                        await _player.startPlayer(
                          fromURI: _audioPath,
                          codec: Codec.aacADTS,
                        );
                      },
                      child: const Text('سماع التسجيل'),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  onPressed: _audioPath != null
                      ? () {
                    setState(() {
                      _audioFiles.add(_audioPath!);
                    });
                    Navigator.of(context).pop();
                  }
                      : null,
                  child: const Text('تأكيد'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _attachFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'mp3', 'docx', 'xls', 'wav'],
    );
    if (result != null) {
      openFiles(result.files);
    }
  }

  Future<void> _pickImagesFromGallery() async {
    try {
      final List<XFile>? selectedImages = await _picker.pickMultiImage();
      if (selectedImages != null) {
        setState(() {
          _imageFiles = (_imageFiles ?? [])..addAll(selectedImages);
        });
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  Future<void> _takePictureWithCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _imageFiles = (_imageFiles ?? [])..add(image);
        });
      }
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  void _attachPicture(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اختر مصدر الصورة'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('معرض الصور'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImagesFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('كاميرا'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _takePictureWithCamera();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFileOptions(int index, bool isImage, bool isAudio) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خيارات ${isImage ? 'الصورة' : (isAudio ? 'الصوت' : 'الملف')}'),
          content: Text('هل تريد حذف هذا ${isImage ? 'الصورة' : (isAudio ? 'الصوت' : 'الملف')}؟'),
          actions: <Widget>[
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('حذف'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  if (isImage) {
                    _imageFiles!.removeAt(index);
                  } else if (isAudio) {
                    _audioFiles.removeAt(index);
                  } else {
                    _pickedFiles!.removeAt(index);
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }

  void openFiles(List<PlatformFile> files) {
    setState(() {
      _pickedFiles = (_pickedFiles ?? [])..addAll(files);
    });
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'submit-consultation'.tr(context)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            const CustomTextTitleAuth(
              title: 'اخبرنا كيف نساعدك؟',
            ),
            const SizedBox(
              height: 20,
            ),
            GlobalTextfield(
              maxline: 10,
              hinttext: "submit-consultation".tr(context),
            ),
            CustomAttachedFile(
              text: 'send_file'.tr(context),
              iconData: Icons.file_present_sharp,
              ontab: () => _attachFile(context),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomAttachedFile(
              text: 'Send_voice'.tr(context),
              iconData: Icons.mic,
              ontab: () => _showRecordDialog(context),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomAttachedFile(
              text: 'send_pic'.tr(context),
              iconData: Icons.photo_camera_back,
              ontab: () => _attachPicture(context),
            ),
            if (_imageFiles != null && _imageFiles!.isNotEmpty)
              ..._imageFiles!.asMap().entries.map((entry) {
                int index = entry.key;
                XFile image = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.file(
                          File(image.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(image.name),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showFileOptions(index, true, false),
                      ),
                    ],
                  ),
                );
              }).toList(),
            if (_pickedFiles != null && _pickedFiles!.isNotEmpty)
              ..._pickedFiles!.asMap().entries.map((entry) {
                int index = entry.key;
                PlatformFile file = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.insert_drive_file, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(file.name),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showFileOptions(index, false, false),
                      ),
                    ],
                  ),
                );
              }).toList(),
            if (_audioFiles.isNotEmpty)
              ..._audioFiles.asMap().entries.map((entry) {
                int index = entry.key;
                String audioPath = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.audiotrack, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(audioPath.split('/').last),
                      ),
                      IconButton(
                        icon: const Icon(Icons.play_arrow, color: Colors.blue),
                        onPressed: () async {
                          await _player.startPlayer(
                            fromURI: audioPath,
                            codec: Codec.aacADTS,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showFileOptions(index, false, true),
                      ),
                    ],
                  ),
                );
              }).toList(),
            const SizedBox(
              height: 15,
            ),
            CustomBotton(
              backgroundColor: AppColors.primeryColor,
              textColor: AppColors.backgroundColor,
              text: 'confirm'.tr(context),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
