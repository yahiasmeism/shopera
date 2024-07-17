import 'core/theme/app_theme.dart';
import 'core/utils/hive_init.dart';
import 'package:get_it/get_it.dart';
import 'core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'core/utils/nav_bar_cubit.dart';
import 'core/utils/app_bloc_observer.dart';
import 'features/main/pages/main_page.dart';
import 'features/settings/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/service_locator.dart' as di;
import 'package:shopera/core/constants/strings.dart';
import 'features/home/persentation/pages/home_page.dart';
import 'package:shopera/core/widgets/snackbar_global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shopera/features/cart/persentation/cubit/cart_cubit.dart';
import 'package:shopera/features/authentication/presentation/pages/login_page.dart';
import 'package:shopera/features/authentication/presentation/pages/on_boarding_page.dart';
import 'package:shopera/features/authentication/presentation/cubits/user_cubit/cubit.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  String initialRoute = OnBoardingPage.routeName;

  // initial dependancy injection
  await di.init();

  // initail hive DB
  await hiveInit();

  // State Observer
  Bloc.observer = AppBlocObserver();

  // Choose the appropriate route
  await initialization().then((routeName) {
    initialRoute = routeName;
    FlutterNativeSplash.remove();
  });

  runApp(MyApp(initialRoute));
}

Future<String> initialization() async {
  // Initialize your app here (e.g., load data, set up services, etc.)
  final sharedPreferences = GetIt.instance<SharedPreferences>();
  await Future.delayed(const Duration(seconds: 2));
  if (sharedPreferences.getBool(K_OnBoarding) != null) {
    if (sharedPreferences.getString(K_TOKEN) != null) {
      return MainPage.routeName;
    } else {
      return LoginPage.routeName;
    }
  } else {
    return OnBoardingPage.routeName;
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<CartCubit>()),
        BlocProvider(create: (context) => di.sl<UserCubit>()),
        BlocProvider(create: (context) => di.sl<SettingsCubit>()),
        BlocProvider(create: (context) => di.sl<NavigationBarCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          bool isLightTheme = true; // default value
          if (state is SettingsThemeChanged) {
            isLightTheme = state.isLightTheme;
          }

          return MaterialApp(
            scaffoldMessengerKey: SnackBarGlobal.key,
            debugShowCheckedModeBanner: false,
            theme: isLightTheme ? appLightTheme : appDarkTheme,
            routes: appRoutes(),
            initialRoute: initialRoute,
          );
        },
      ),
    );
  }
}
