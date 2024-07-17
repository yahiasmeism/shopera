import 'package:bloc/bloc.dart';


enum NavigationBarState { home, wishList, cart, settings }

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(NavigationBarState.home);

  void navigateTo(NavigationBarState state) => emit(state);
}
