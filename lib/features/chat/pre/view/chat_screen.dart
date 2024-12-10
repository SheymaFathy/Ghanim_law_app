import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
class Basic extends StatefulWidget {
  const Basic({super.key});

  @override
  _BasicState createState() => _BasicState();
}
class _BasicState extends State<Basic> {
  List<ChatMessage> messages = [
    ChatMessage(
      text: 'Hey!',
      user: ChatUser(
        id: '1',
        firstName: 'Charles',
        lastName: 'Leclerc',
      ),
      createdAt: DateTime.now(),
    ),
  ];

  final ChatUser currentUser = ChatUser(
    id: '1',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: DashChat(
        inputOptions: const InputOptions(alwaysShowSend:true ),
        messageOptions: const MessageOptions(showTime: true, showOtherUsersName: true),
        currentUser: currentUser,
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
          });
        },
        messages: messages,
      ),
    );
  }
}