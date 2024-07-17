part of 'home_cubit.dart';

class HomeState extends Equatable {
  final RequestState homeDataState;
  final HomeModel? homeModel;
  final String errorMessage;
  const HomeState(
      {this.homeDataState = RequestState.loading,
      this.homeModel,
      this.errorMessage = ''});
  HomeState copyWith(
      {RequestState? homeDataState,
      HomeModel? homeModel,
      String? errorMessage}) {
    return HomeState(
        homeDataState: homeDataState ?? this.homeDataState,
        homeModel: homeModel ?? this.homeModel,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
        homeDataState,
        homeModel,
        errorMessage,
      ];
}
