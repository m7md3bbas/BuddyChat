part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsSuccess extends SettingsState {}

final class SettingsFailure extends SettingsState {
  final Failure failure;
  SettingsFailure({required this.failure});
}

final class SettingGetPassword extends SettingsState {
  final String password;
  SettingGetPassword({required this.password});
}
