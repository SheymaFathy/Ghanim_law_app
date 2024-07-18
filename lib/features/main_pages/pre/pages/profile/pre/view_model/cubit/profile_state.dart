part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final RequestState profileRequestState;
  final ProfileModel? profileModel;
  final String erorrMessage;
  const ProfileState(
      {this.profileRequestState = RequestState.loading,
      this.profileModel,
      this.erorrMessage = ''});
  ProfileState copyWith(
      {RequestState? profileRequestState,
      ProfileModel? profileModel,
      String? erorrMessage}) {
    return ProfileState(
      profileRequestState: profileRequestState ?? this.profileRequestState,
      profileModel: profileModel ?? this.profileModel,
      erorrMessage: erorrMessage ?? this.erorrMessage,
    );
  }

  @override
  List<Object?> get props => [profileRequestState, profileModel, erorrMessage];
}
