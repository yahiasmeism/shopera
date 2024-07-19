part of 'cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsThemeChanged extends SettingsState {
  final bool isDarkTheme;

  const SettingsThemeChanged(this.isDarkTheme);

  @override
  List<Object> get props => [isDarkTheme];
}
