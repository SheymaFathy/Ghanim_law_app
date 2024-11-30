import 'package:flutter/material.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
    required this.staticMessages,
  });

  final List<Map<String, String>> staticMessages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        itemCount: staticMessages.length,
        itemBuilder: (context, index) {
          final message = staticMessages[index];
          final isUser = message["sender"] == "user";

          return Align(
            alignment: isUser
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isUser
                    ? Theme.of(context).colorScheme.onPrimaryFixed
                    : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message["message"]!,
                style: TextStyle(
                  color: isUser
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}