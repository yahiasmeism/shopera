import 'package:flutter/widgets.dart';
import '../../features/main/pages/main_page.dart';
import '../../features/settings/pages/settings_page.dart';
import '../../features/cart/persentation/pages/cart_page.dart';
import '../../features/home/persentation/pages/home_page.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/startup_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/authentication/presentation/pages/on_boarding_page.dart';
import '../../features/authentication/presentation/pages/update_user_page.dart';

Map<String, WidgetBuilder> appRoutes() {
  return <String, WidgetBuilder>{
    MainPage.routeName: (context) => const MainPage(),
    CartPage.routeName: (context) => const CartPage(),
    HomePage.routeName: (context) => const HomePage(),
    UpdateUserPage.routeName: (context) => const UpdateUserPage(),
    SettingsPage.routeName: (context) => const SettingsPage(),
    SignInPage.routeName: (context) => SignInPage(),
    SignUpPage.routeName: (context) => SignUpPage(),
    OnBoardingPage.routeName: (context) => OnBoardingPage(),
    StartupPage.routeName: (context) => const StartupPage(),
    // 'products': (context) => const ProductsPage(),
    // 'orders': (context) => const OrdersPage(),
  };
}
