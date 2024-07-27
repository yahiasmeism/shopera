import 'package:dio/dio.dart';
import 'package:shopera/features/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:shopera/features/orders/data/repository/orders_repository.dart';
import 'package:shopera/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:shopera/features/search/cubit/search_cubit.dart';
import '../api/api_consumer.dart';
import 'package:get_it/get_it.dart';
import '../utils/nav_bar_cubit.dart';
import '../network/network_info.dart';
import 'package:shopera/features/settings/cubit/cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/cart/persentation/cubit/cart_cubit.dart';
import '../../features/favorite/presentation/favorite_cubit.dart';
import '../../features/authentication/domain/usecases/login.dart';
import '../../features/authentication/domain/usecases/logout.dart';
import '../../features/home/persentation/cubit/products_cubit.dart';
import '../../features/home/domin/repositories/home_repository.dart';
import '../../features/authentication/domain/usecases/register.dart';
import '../../features/cart/domin/usecases/create_cart_usecase.dart';
import '../../features/cart/domin/usecases/delete_cart_usecase.dart';
import '../../features/cart/domin/usecases/update_cart_usecase.dart';
import '../../features/home/domin/usecases/get_products_usecase.dart';
import '../../features/cart/domin/repositories/cart_repositories.dart';
import '../../features/home/domin/usecases/get_categories_usecase.dart';
import '../../features/authentication/domain/usecases/update_user.dart';
import '../../features/home/domin/usecases/search_products_usecase.dart';
import '../../features/home/data/repositories/home_repositories_imp.dart';
import '../../features/cart/data/data_sources/cart_remote_data_source.dart';
import '../../features/cart/data/repositories_impl/cart_repository_impl.dart';
import '../../features/home/data/data_sources/products_local_data_source.dart';
import '../../features/home/data/data_sources/products_remote_data_source.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../../features/authentication/presentation/cubits/user_cubit/cubit.dart';
import '../../features/home/domin/usecases/get_products_by_category_usecase.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/authentication/data/datasources/auth_local_data_source.dart';
import '../../features/authentication/data/datasources/auth_remote_data_source.dart';

class AppDep {
  AppDep._();

  static final sl = GetIt.instance;

  static Future<void> init() async {
    //! ***************  Featurs - Main ***************

    //Bloc
    sl.registerFactory(() => NavigationBarCubit());

    //! ***************  Featurs - Settings ***************

    //Bloc
    sl.registerFactory(() => SettingsCubit());

    //Use cases

    // Repository

    // Data sources

    //! ***************  Featurs - Favorite ***************

    sl.registerFactory(() => FavoriteCubit());


    //! ***************  Featurs - Favorite ***************

    sl.registerFactory(() => FavoriteCubit());
   


    //! ***************  Featurs - User ***************
    //Bloc
    sl.registerFactory(
      () => UserCubit(getCurrentUserUsecase: sl(), getLogin: sl(), getRegister: sl(), putUser: sl(), logout: sl()),
    );
    //Use cases
    sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
    sl.registerLazySingleton(() => RegisterUsecase(repository: sl()));
    sl.registerLazySingleton(() => UpdateUsecase(repository: sl()));
    sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
    sl.registerLazySingleton(() => GetCurrentUserUsecase(repository: sl()));
    // Repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        localDataSource: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
        sharedPreferences: sl(),
      ),
    );
    // Data sources
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(),
    );
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        api: sl(),
      ),
    );

    //! ***************  Featurs - Cart ***************

    //Bloc
    sl.registerFactory(
      () => CartCubit(
        createCartUsecase: sl(),
        deleteCartUsecase: sl(),
        updateCartUsecase: sl(),
      ),
    );
    //Use cases
    sl.registerLazySingleton(() => CreateCartUsecase(repository: sl()));
    sl.registerLazySingleton(() => DeleteCartUsecase(repository: sl()));
    sl.registerLazySingleton(() => UpdateCartUsecase(repository: sl()));
    // Repository
    sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(
        sharedPreferences: sl(),
        remote: sl(),
      ),
    );
    // Data sources
    sl.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(
        api: sl(),
      ),
    );

    //! ***************  Featurs - Product-Home-Search ***************

    //Bloc
    sl.registerFactory(() => ProductsCubit(
        getProductsUsecase: sl(), getCategoriesUsecase: sl(), getProductsByCategoryUsecase: sl(), searchProductsUsecase: sl()));
    sl.registerFactory(() => SearchCubit(sl()));
    //Use cases
    sl.registerLazySingleton(() => GetProductsUsecase(homeRepository: sl()));
    sl.registerLazySingleton(() => GetCategoriesUsecase(homeRepository: sl()));
    sl.registerLazySingleton(() => GetProductsByCategoryUsecase(homeRepository: sl()));
    sl.registerLazySingleton(() => SearchProductsUsecase(homeRepository: sl()));
    // Repository
    sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(remote: sl(), local: sl(), networkInfo: sl()));
    // Data sources
    sl.registerLazySingleton<ProductsLocalDataSource>(() => ProductsLocalDataSourceImpl());
    sl.registerLazySingleton<ProductsRemoteDataSource>(() => ProductsRemoteDataSourceImpl(api: sl()));
    //! ***************  Featurs - Orders ***************

    //Bloc
    sl.registerFactory(() => OrdersCubit(repository: sl()));

    // Repository
    sl.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImpl());

    ///****************************************************
    ///! Core
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

    ///! External
    sl.registerLazySingleton<Dio>(() => Dio());
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(
      () => sharedPreferences,
    );
  }
}
