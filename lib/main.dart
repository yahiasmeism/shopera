import 'core/theme/app_theme.dart';
import 'core/utils/hive_init.dart';
import 'core/constants/strings.dart';
import 'core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'core/utils/nav_bar_cubit.dart';
import 'package:flutter/foundation.dart';
import 'core/utils/app_bloc_observer.dart';
import 'core/utils/my_route_observer.dart';
import 'core/widgets/snackbar_global.dart';
import 'core/services/service_locator.dart';
import 'features/main/pages/main_page.dart';
import 'features/settings/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/persentation/cubit/home_cubit.dart';
import 'features/cart/persentation/cubit/cart_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'features/authentication/presentation/pages/on_boarding_page.dart';
import 'features/authentication/presentation/cubits/user_cubit/cubit.dart';
import 'package:shopera/features/authentication/presentation/pages/login_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  String initialRoute = OnBoardingPage.routeName;

  // initial dependancy injection
  await AppDep.init();

  // initail hive DB
  await hiveInit();

  // State Observer
  if (kDebugMode) Bloc.observer = AppBlocObserver();

  // Choose the appropriate route
  await initialization().then((routeName) {
    initialRoute = routeName;
    FlutterNativeSplash.remove();
  });

  runApp(MyApp(initialRoute));
}

Future<String> initialization() async {
  // Initialize your app here (e.g., load data, set up services, etc.)
  final SharedPreferences sharedPreferences = AppDep.sl();
  await Future.delayed(const Duration(seconds: 2));
  if (sharedPreferences.getBool(K_OnBoarding) != null) {
    if (sharedPreferences.getString(K_TOKEN) != null) {
      return MainPage.routeName;
    } else {
      return SignInPage.routeName;
    }
  } else {
    return OnBoardingPage.routeName;
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp(this.initialRoute, {super.key});

  static final AppNavigatorObserver routeObserver = AppNavigatorObserver();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppDep.sl<CartCubit>()),
        BlocProvider(create: (context) => AppDep.sl<UserCubit>()),
        BlocProvider(create: (context) => AppDep.sl<SettingsCubit>()),
        BlocProvider(create: (context) => AppDep.sl<NavigationBarCubit>()),
        BlocProvider(create: (context) => AppDep.sl<UserCubit>()),
        BlocProvider(create: (context) => AppDep.sl<HomeCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final SharedPreferences sharedPref = AppDep.sl();
          bool isDarkTheme = sharedPref.getBool(kIsDarkTheme) ?? false; // default value
          if (state is SettingsThemeChanged) {
            isDarkTheme = state.isDarkTheme;
            sharedPref.setBool(kIsDarkTheme, isDarkTheme);
          }

          return MaterialApp(
            navigatorObservers: [routeObserver],
            scaffoldMessengerKey: SnackBarGlobal.key,
            debugShowCheckedModeBanner: false,
            theme: isDarkTheme ? appDarkTheme : appLightTheme,
            routes: appRoutes(),
            initialRoute: initialRoute,
          );
        },
      ),
    );
  }
}
