import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/enum/enum.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(const AudioPlayerState());
  @override
  Future<void> close() async {
    await pauseRecording();
    await stopAudio();
    super.close();
  }

  final AudioPlayer audioPlayer = AudioPlayer();
  Future<void> initRecording(String path) async {
    await audioPlayer.setFilePath(path);

    emit(state.copyWith(
        audioPlayer: audioPlayer,
        totalDuration: audioPlayer.duration ?? const Duration(seconds: 0),
        playAudioState: RequestState.sucess));

    audioPlayer.positionStream.listen((position) {
      emit(state.copyWith(currentPosition: position));
      if (state.currentPosition!.inMilliseconds ==
          state.totalDuration!.inMilliseconds) {
        if (state.isSeeking) {
          emit(state.copyWith(isPlaying: true));
        } else {
          emit(state.copyWith(isPlaying: false));
        }
        emit(state.copyWith(isPlaying: false));
      }
    });
  }

  Future<void> playRecording(String path) async {
    initRecording(path);
    audioPlayer.play();
    emit(state.copyWith(isPlaying: true));
  }

  Future<void> seekRecording(Duration dur) async {
    emit(state.copyWith(isSeeking: false));
    audioPlayer.seek(dur);
    emit(state.copyWith(
        audioPlayer: audioPlayer,
        currentPosition: dur,
        isSeeking: true,
        isPlaying: true));
  }

  Future<void> pauseRecording() async {
    await audioPlayer.pause();
    emit(state.copyWith(audioPlayer: audioPlayer, isPlaying: false));
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    emit(state.copyWith(audioPlayer: audioPlayer, isPlaying: false));
  }
}