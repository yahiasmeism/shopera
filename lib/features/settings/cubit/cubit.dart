import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'states.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  void toggleTheme(bool isDarkTheme) {
    emit(SettingsThemeChanged(isDarkTheme));
  }
}
