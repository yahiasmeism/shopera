import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/nav_bar_cubit.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../cart/persentation/pages/cart_page.dart';
import '../../home/persentation/pages/home_page.dart';
import '../../wish_list/presentation/pages/wish_list.dart';
import 'package:shopera/features/settings/pages/settings_page.dart';
import 'package:shopera/features/home/persentation/cubit/home_cubit.dart';
import 'package:shopera/features/authentication/presentation/cubits/user_cubit/cubit.dart';

class MainPage extends StatefulWidget {
  static const routeName = 'main page';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getCurrentUser();
    context.read<HomeCubit>().loadData();
  }

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
              return const SettingsPage();
            default:
              return const HomePage();
          }
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
