import 'package:flutter/foundation.dart';
import 'package:shopera/features/home/persentation/cubit/home_cubit.dart';
import 'package:shopera/features/home/persentation/pages/home_page.dart';

import 'core/services/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/hive_init.dart';
import 'core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'core/utils/app_bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/core/widgets/snackbar_global.dart';
import 'package:shopera/features/cart/persentation/cubit/cart_cubit.dart';
import 'package:shopera/features/authentication/presentation/pages/on_boarding_page.dart';
import 'package:shopera/features/authentication/presentation/cubits/user_cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initial dependancy injection
  await AppDep.init();

  // initail hive DB
  await hiveInit();

  // State Observer
  // if (kDebugMode) Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppDep.sl<CartCubit>()),
        BlocProvider(create: (context) => AppDep.sl<UserCubit>()),
        BlocProvider(create: (context) => AppDep.sl<HomeCubit>()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: SnackBarGlobal.key,
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        routes: appRoutes(),
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
