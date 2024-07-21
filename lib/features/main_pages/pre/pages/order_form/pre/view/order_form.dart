import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import '../../../../../../../core/get_it/service_locator.dart';
import '../view_model/cubit/add_order_cubit.dart';
import 'widgets/files/show_file_options_dialog.dart';
import 'widgets/image/attach_picture_widget.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
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
      body: BlocProvider.value(
        value: getIt<AddOrderCubit>(),
        child: BlocBuilder<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
            final addOrderCubit = context.read<AddOrderCubit>();
            return Padding(
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
                    ontab: () => addOrderCubit.attachFile(),
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
                    ontab: () => attachPictureWidget(context),
                  ),
                  if (state.imageFiles != null && state.imageFiles!.isNotEmpty)
                    ...state.imageFiles!.asMap().entries.map((entry) {
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
                              onPressed: () => showFileOptionsDialog(
                                index,
                                "image",
                                context,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  if (state.pickedFiles != null &&
                      state.pickedFiles!.isNotEmpty)
                    ...state.pickedFiles!.asMap().entries.map((entry) {
                      int index = entry.key;
                      PlatformFile file = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.insert_drive_file,
                                color: Colors.grey),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(file.name),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => showFileOptionsDialog(
                                index,
                                "file",
                                context,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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
                              icon: const Icon(Icons.play_arrow,
                                  color: Colors.blue),
                              onPressed: () async {
                                await _player.startPlayer(
                                  fromURI: audioPath,
                                  codec: Codec.aacADTS,
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => showFileOptionsDialog(
                                index,
                                "audio",
                                context,
                              ),
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
            );
          },
        ),
      ),
    );
  }
}
