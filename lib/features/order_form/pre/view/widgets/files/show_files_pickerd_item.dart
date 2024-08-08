import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'show_file_options_dialog.dart';

class ShowFilesPickerdItem extends StatelessWidget {
  const ShowFilesPickerdItem({
    super.key,
    required this.file,
    required this.index,
  });

  final PlatformFile file;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.insert_drive_file,
              color: Theme.of(context).colorScheme.onSurface),
          const SizedBox(width: 10),
          Expanded(
            child: Text(file.name),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => showDeleteFileDialog(index, "file", context),
          ),
        ],
      ),
    );
  }
}
