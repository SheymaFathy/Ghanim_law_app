import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

part 'chat_view_state.dart';

class ChatViewCubit extends Cubit<ChatViewState> {
  ChatViewCubit() : super(ChatViewInitial());

  final TextEditingController messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [];

  void sendMessage(String content, String type) {
    if (content.isEmpty) return;

    final newMessage = {
      "content": content,
      "type": type,
      "fileName": type == "file" ? "Attached File" : null,
      "timestamp": DateTime.now().toString(),
    };

    messages.insert(0, newMessage);
    emit(ChatMessageSent(messages: List.from(messages)));
    messageController.clear();
  }

  Future<void> attachImage({required ImageSource source}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        sendMessage(pickedImage.path, "image");
      }
    } catch (e) {
      debugPrint("Image picking error: $e");
    }
  }

  Future<void> attachFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.isNotEmpty) {
        final filePath = result.files.single.path;
        final fileName = result.files.single.name;
        if (filePath != null) {
          sendMessage(filePath, "file");
        }
      }
    } catch (e) {
      debugPrint("File picking error: $e");
    }
  }
}
