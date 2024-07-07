import 'dart:developer';

import 'package:bloc/bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('Bloc => $bloc (CurrentState: ${change.currentState} => NextState: ${change.nextState})');
    super.onChange(bloc, change);
  }
}
