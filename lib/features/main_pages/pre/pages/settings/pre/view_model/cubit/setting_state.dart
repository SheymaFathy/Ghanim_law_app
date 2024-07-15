part of 'setting_cubit.dart';

class SettingState extends Equatable {
  final Locale locale;
  const SettingState({this.locale = const Locale("ar")});
  @override
  List<Object?> get props => [locale];
}
