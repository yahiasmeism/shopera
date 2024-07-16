part of 'cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsThemeChanged extends SettingsState {
  final bool isLightTheme;

  const SettingsThemeChanged(this.isLightTheme);

  @override
  List<Object> get props => [isLightTheme];
}
