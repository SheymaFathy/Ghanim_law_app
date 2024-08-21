import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/features/record_player/view_model/cubit/audio_player_cubit.dart';

import '../progress_audio_page_widget.dart';

showAudioPlayerDialog(
  BuildContext orderCtx,
  String path,
) {
  return showDialog(
    context: orderCtx,
    barrierDismissible: false,
    useRootNavigator: false,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => AudioPlayerCubit()..initRecording(path),
        child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
          builder: (context, state) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProgressAudioPageWidget(
                    audioPath: path,
                    audioPlayerState: state,
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  ).then((onValue) {});
}
