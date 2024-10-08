import '../utils/nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/features/cart/persentation/components/cart_button.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBarCubit, NavigationBarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          onTap: (index) {
            switch (index) {
              case 0:
                context.read<NavigationBarCubit>().navigateTo(NavigationBarState.home);
                break;
              case 1:
                context.read<NavigationBarCubit>().navigateTo(NavigationBarState.search);
                break;
              case 2:
                context.read<NavigationBarCubit>().navigateTo(NavigationBarState.wishList);
                break;
              case 3:
                context.read<NavigationBarCubit>().navigateTo(NavigationBarState.cart);
                break;
              case 4:
                context.read<NavigationBarCubit>().navigateTo(NavigationBarState.settings);
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: "Favorite"),
            BottomNavigationBarItem(icon: CartIconWidget(), label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "Settings"),
          ],
        );
      },
    );
  }
}
