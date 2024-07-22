part of 'audio_player_cubit.dart';

class AudioPlayerState extends Equatable {
  final Duration? currentPosition;
  final Duration? totalDuration;
  final bool isPlaying;
  final RequestState playAudioState;
  final AudioPlayer? audioPlayer;
  final bool isSeeking;
  const AudioPlayerState(
      {this.currentPosition,
      this.totalDuration,
      this.audioPlayer,
      this.isPlaying = false,
      this.playAudioState = RequestState.loading,
      this.isSeeking = false});

  AudioPlayerState copyWith(
      {Duration? currentPosition,
      Duration? totalDuration,
      bool? isPlaying,
      RequestState? playAudioState,
      AudioPlayer? audioPlayer,
      bool? isSeeking}) {
    return AudioPlayerState(
        currentPosition: currentPosition ?? this.currentPosition,
        totalDuration: totalDuration ?? this.totalDuration,
        isPlaying: isPlaying ?? this.isPlaying,
        playAudioState: playAudioState ?? this.playAudioState,
        audioPlayer: audioPlayer ?? this.audioPlayer,
        isSeeking: isSeeking ?? this.isSeeking);
  }

  @override
  List<Object?> get props {
    return [
      currentPosition,
      totalDuration,
      isPlaying,
      playAudioState,
      audioPlayer,
      isSeeking
    ];
  }
}
