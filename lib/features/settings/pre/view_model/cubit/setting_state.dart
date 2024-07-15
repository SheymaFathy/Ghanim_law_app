part of 'setting_cubit.dart';

class SettingState extends Equatable {
  const SettingState();
  @override
  List<Object?> get props => [];
}

class ChangeLocaleState extends SettingState {
  final Locale locale;

  const ChangeLocaleState({required this.locale});
  @override
  List<Object?> get props => [locale];
}
