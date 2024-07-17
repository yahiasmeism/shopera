import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/nav_bar_cubit.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../cart/persentation/pages/cart_page.dart';
import '../../home/persentation/pages/home_page.dart';
import '../../wish_list/presentation/pages/wish_list.dart';
import 'package:shopera/features/settings/pages/settings_page.dart';


class MainPage extends StatelessWidget {
  static const routeName = 'main page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBarCubit, NavigationBarState>(
        builder: (context, state) {
          switch (state) {
            case NavigationBarState.home:
              return const HomePage();
            case NavigationBarState.wishList:
              return const WishListPage();
            case NavigationBarState.cart:
              return const CartPage();
            case NavigationBarState.settings:
              return SettingsPage();
            default:
              return const HomePage();
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}