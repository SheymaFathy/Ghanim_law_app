import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import '../view_model/chat_view_cubit.dart';

class ChatViewScreen extends StatelessWidget {
  const ChatViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatViewCubit(),
      child: BlocBuilder<ChatViewCubit, ChatViewState>(
        builder: (context, state) {
          final cubit = context.read<ChatViewCubit>();

          return Scaffold(
            appBar: AppBar(
              title: const Text("Chat"),
            ),
            body: Column(
              children: [
                Expanded(
                  child: state is ChatMessageSent
                      ? ListView.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return _buildMessageItem(message);
                    },
                  )
                      : const Center(child: Text("No messages yet.")),
                ),
                _buildInputField(cubit, context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> message) {
    if (message["type"] == "text") {
      // نص الرسالة
      return ListTile(
        title: Text(message["content"]),
        subtitle: Text(
          _formatTimestamp(message["timestamp"]),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      );
    } else if (message["type"] == "image") {
      //img showing
     return ListTile(
        title: Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(message["content"]),
                width: 200,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        subtitle: Text(
          _formatTimestamp(message["timestamp"]),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      );


    } else if (message["type"] == "file") {
      // عرض الملف
      return ListTile(
        title: Text(message["fileName"] ?? "Unnamed File"),
        subtitle: Text(
          "File attached\n" + _formatTimestamp(message["timestamp"]),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: const Icon(Icons.attach_file),
        onTap: () {
        },
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildInputField(ChatViewCubit cubit, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () => _showAttachmentOptions(context, cubit),
          ),
          Expanded(
            //text msg input
            child: TextField(
              controller: cubit.messageController,
              decoration:  InputDecoration(
                hintText:  "type_your_msg".tr(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),

              ),
              minLines: 1,
              maxLines: 10,
              ),
            ),

          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              cubit.sendMessage(cubit.messageController.text, "text");
            },
          ),
        ],
      ),
    );
  }

  void _showAttachmentOptions(BuildContext context, ChatViewCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title:  Text("use_camera".tr(context)),
              onTap: () {
                Navigator.pop(context);
                cubit.attachImage(source: ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title:  Text("use_galary".tr(context)),
              onTap: () {
                Navigator.pop(context);
                cubit.attachImage(source: ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title:  Text("use_attachment".tr(context)),
              onTap: () {
                Navigator.pop(context);
                cubit.attachFile();
              },
            ),
          ],
        );
      },
    );
  }

  String _formatTimestamp(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    return "${dateTime.hour}:${dateTime.minute}";
  }
}
