import 'dart:developer';

import 'package:bloc/bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('Bloc => $bloc (CurrentState: ${change.currentState} => NextState: ${change.currentState})');
    super.onChange(bloc, change);
  }
}
