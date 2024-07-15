part of 'main_page_cubit.dart';

class MainPageState extends Equatable {
  final int selectedNavBarIndex;
  const MainPageState({this.selectedNavBarIndex = 0});
  MainPageState copyWith({int? selectedNavBarIndex}) {
    return MainPageState(
        selectedNavBarIndex: selectedNavBarIndex ?? this.selectedNavBarIndex);
  }

  @override
  List<Object?> get props => [selectedNavBarIndex];
}
