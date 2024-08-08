// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'setting_cubit.dart';

class SettingState {
  final Locale locale;

  const SettingState({this.locale = const Locale("ar")});

  SettingState copyWith({
    Locale? locale,
    bool? themeMode,
  }) {
    return SettingState(
      locale: locale ?? this.locale,
    );
  }
}

class ThemeSettingChangedLoadingState extends SettingState {}

class ThemeSettingChangedSuccessState extends SettingState {}
