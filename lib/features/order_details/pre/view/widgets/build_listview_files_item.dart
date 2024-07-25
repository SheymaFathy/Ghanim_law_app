import 'package:file_downloader_flutter/file_downloader_flutter.dart';
import 'package:flutter/material.dart';

class BuildListViewFilesItem extends StatelessWidget {
  const BuildListViewFilesItem(
      {super.key,
      required this.fileName,
      this.isDoc = false,
      this.isImage = false,
      this.isVoice = false});
  final String fileName;
  final bool isDoc;
  final bool isImage;
  final bool isVoice;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: Colors.white),
      child: Row(
        children: [
          if (isDoc) const Icon(Icons.attach_file),
          if (isImage) const Icon(Icons.image),
          if (isVoice) const Icon(Icons.keyboard_voice_outlined),
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 2,
            child: Text(
              getFileName(fileName),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          if (fileName != '')
            IconButton(
                onPressed: () {
                  FileDownloaderFlutter().urlFileSaver(url: fileName);
                },
                icon: const Icon(Icons.download))
        ],
      ),
    );
  }

  getFileName(String url) {
    List<String> segments = url.split("/");

    String fileName = segments.last;
    return fileName;
  }
}
