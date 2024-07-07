import 'package:flutter/material.dart';
import '../../features/authentication/presentation/pages/home_page.dart';
import 'package:shopera/features/authentication/presentation/pages/login_page.dart';
import 'package:shopera/features/authentication/presentation/pages/register_page.dart';
import 'package:shopera/features/authentication/presentation/pages/update_user_page.dart';

Map<String, WidgetBuilder> appRoutes() {
  return <String, WidgetBuilder>{
    HomePage.routeName: (context) => const HomePage(),
    LoginPage.routeName: (context) => LoginPage(),
    RegisterPage.routeName: (context) =>  RegisterPage(),
    UpdateUserPage.routeName: (context) => const UpdateUserPage(),
    // 'products': (context) => const ProductsPage(),
    // 'orders': (context) => const OrdersPage(),
  };
}
