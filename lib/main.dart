import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/core/widgets/snackbar_global.dart';
import 'package:shopera/features/authentication/presentation/cubits/user_cubit/cubit.dart';
import 'package:shopera/features/authentication/presentation/pages/home_page.dart';
import 'package:shopera/features/cart/persentation/cubit/cart_cubit.dart';

import 'core/routes/app_routes.dart';
import 'core/services/service_locator.dart' as di;
import 'core/theme/app_theme.dart';
import 'core/utils/hive_init.dart';
import 'core/utils/app_bloc_observer.dart';

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
        scaffoldMessengerKey: SnackBarGlobal.key,
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: const Placeholder(),
        routes: appRoutes(),
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
