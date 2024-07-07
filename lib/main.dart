import 'core/theme/app_theme.dart';
import 'core/utils/hive_init.dart';
import 'core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'core/utils/app_bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/service_locator.dart' as di;
import 'package:shopera/features/cart/persentation/cubit/cart_cubit.dart';
import 'package:shopera/features/authentication/presentation/pages/home_page.dart';
import 'package:shopera/features/authentication/presentation/pages/login_page.dart';
import 'package:shopera/features/authentication/presentation/cubits/user_cubit/cubit.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initial dependancy injection
  await di.init();

  // initail hive DB
  await hiveInit();

  // State Observer
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<CartCubit>()),
        BlocProvider(create: (context) => di.sl<UserCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: const Placeholder(),
        routes: appRoutes(),
        initialRoute: LoginPage.routeName,
      ),
    );
  }
}
