import 'package:flutter/material.dart';
import 'package:shopera/features/cart/persentation/pages/cart_page.dart';
import '../../features/authentication/presentation/pages/home_page.dart';

Map<String, WidgetBuilder> appRoutes() {
  return <String, WidgetBuilder>{
    HomePage.routeName: (context) => const HomePage(),
    CartPage.routeName: (context) => const CartPage(),
    // 'login': (context) =>  LoginPage(),
    // 'register': (context) =>  RegisterPage(),
    // 'update_profile': (context) => const UpdateUserPage(),
    // 'products': (context) => const ProductsPage(),
    // 'orders': (context) => const OrdersPage(),
  };
}
