import 'package:flutter/widgets.dart';
import '../../features/cart/persentation/pages/cart_page.dart';
import '../../features/home/persentation/pages/home_page.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/startup_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/authentication/presentation/pages/on_boarding_page.dart';
import '../../features/authentication/presentation/pages/update_user_page.dart';

Map<String, WidgetBuilder> appRoutes() {
  return <String, WidgetBuilder>{
    CartPage.routeName: (context) => const CartPage(),
    HomePage.routeName: (context) => const HomePage(),
    SignIn.routeName: (context) => SignIn(),
    SignUpPage.routeName: (context) => SignUpPage(),
    UpdateUserPage.routeName: (context) => const UpdateUserPage(),
    OnBoardingPage.routeName: (context) => OnBoardingPage(),
    StartupPage.routeName: (context) => const StartupPage(),
    // 'products': (context) => const ProductsPage(),
    // 'orders': (context) => const OrdersPage(),
  };
}
