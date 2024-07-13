import 'package:flutter/material.dart';
import '../../features/home/persentation/pages/home_page.dart';

Map<String, WidgetBuilder> appRoutes() {
  return <String, WidgetBuilder>{
    HomePage.routeName: (context) => const HomePage(),
    // 'login': (context) =>  LoginPage(),
    // 'register': (context) =>  RegisterPage(),
    // 'update_profile': (context) => const UpdateUserPage(),
    // 'products': (context) => const ProductsPage(),
    // 'orders': (context) => const OrdersPage(),
  };
}
