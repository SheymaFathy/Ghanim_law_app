import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/features/record_player/view_model/cubit/audio_player_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enum/enum.dart';

class ProgressAudioPageWidget extends StatelessWidget {
  const ProgressAudioPageWidget(
      {super.key, required this.audioPlayerState, required this.audioPath});
  final AudioPlayerState audioPlayerState;
  final String audioPath;
  @override
  Widget build(BuildContext context) {
    final audioPlayerCubit = context.read<AudioPlayerCubit>();
    switch (audioPlayerCubit.state.playAudioState) {
      case RequestState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case RequestState.sucess:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: const Icon(Icons.close)),
            ProgressBar(
              progress: audioPlayerCubit.state.currentPosition!,
              total: audioPlayerCubit.state.totalDuration!,
              onSeek: (duration) {
                audioPlayerCubit.seekRecording(duration);
              },
            ),
            Center(
              child: IconButton(
                  onPressed: () {
                    if (audioPlayerCubit.state.isPlaying) {
                      audioPlayerCubit.pauseRecording();
                    } else {
                      audioPlayerCubit.playRecording(audioPath);
                    }
                  },
                  icon: audioPlayerCubit.state.isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow)),
            )
          ],
        );
      case RequestState.erorr:
        return const Text("");
    }
  }
}
