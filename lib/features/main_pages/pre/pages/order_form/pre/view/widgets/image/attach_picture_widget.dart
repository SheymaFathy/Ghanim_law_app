import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/order_form/pre/view/order_form.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/order_form/pre/view_model/cubit/add_order_cubit.dart';

attachPictureWidget(BuildContext orderCtx) {
  return showDialog(
    context: orderCtx,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: AddOrderCubit(),
        child: BlocBuilder<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
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
                        BlocProvider.of<AddOrderCubit>(orderCtx)
                            .pickImagesFromGallery();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text('كاميرا'),
                      onTap: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<AddOrderCubit>(orderCtx)
                            .takePictureWithCamera();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

attachVoiceWidget(BuildContext orderCtx, String path) {
  return showDialog(
    context: orderCtx,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: AddOrderCubit()..initRecording(path),
        child: BlocBuilder<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
            return AlertDialog(
                content: SingleChildScrollView(
                    child: ProgressAudioBar(
              path: path,
            )));
          },
        ),
      );
    },
  );
}

class ProgressAudioBar extends StatelessWidget {
  const ProgressAudioBar({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    final addorderCubit = context.watch<AddOrderCubit>();
    switch (addorderCubit.state.playAudioState) {
      case RequestState.loading:
        return Center(child: CircularProgressIndicator());
      case RequestState.sucess:
        return ListBody(
          children: [
            ProgressBar(
              progress: addorderCubit.state.currentPosition!,
              total: addorderCubit.state.totalDuration!,
              onSeek: (duration) {
                addorderCubit.seekRecording(duration);
              },
            ),
            IconButton(
                onPressed: () {
                  if (addorderCubit.state.isPlaying) {
                    addorderCubit.pauseRecording();
                  } else {
                    addorderCubit.playRecording(path);
                  }
                },
                icon: addorderCubit.state.isPlaying
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow))
          ],
        );
      case RequestState.erorr:
        return Text("");
    }
  }
}
