import 'package:dio/dio.dart';
import '../api/api_consumer.dart';
import 'package:get_it/get_it.dart';
import '../network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/authentication/domain/usecases/update_user.dart';
import 'package:shopera/features/cart/persentation/cubit/cart_cubit.dart';
import 'package:shopera/features/authentication/domain/usecases/login.dart';
import 'package:shopera/features/authentication/domain/usecases/register.dart';
import 'package:shopera/features/cart/domin/usecases/create_cart_usecase.dart';
import 'package:shopera/features/cart/domin/usecases/delete_cart_usecase.dart';
import 'package:shopera/features/cart/domin/usecases/update_cart_usecase.dart';
import 'package:shopera/features/cart/domin/repositories/cart_repositories.dart';
import 'package:shopera/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:shopera/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:shopera/features/cart/data/repositories_impl/cart_repository_impl.dart';
import 'package:shopera/features/authentication/domain/repositories/auth_repository.dart';
import 'package:shopera/features/authentication/presentation/cubits/user_cubit/cubit.dart';
import 'package:shopera/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:shopera/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:shopera/features/authentication/data/datasources/auth_remote_data_source.dart';


final sl = GetIt.instance;

Future<void> init() async {
  //! Featurs - Home

  //Bloc

  //Use cases

  // Repository

  // Data sources

  //! ***************  Featurs - User ***************

  //Bloc
  sl.registerFactory(
    () => UserCubit(
      getLogin: sl(),
      getRegister: sl(),
      putUser: sl(),
    ),
  );
  //Use cases
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUsecase(repository: sl()));
  sl.registerLazySingleton(() => (repository: sl()));
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



  //! ***************  Featurs - Products ***************

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
      local: sl(),
      remote: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(
      api: sl(),
    ),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(),
  );
  //! ***************  Featurs - Cart ***************

  //Bloc

  //Use cases

  // Repository

  // Data sources

  //! ***************  Featurs - Orders ***************

  //Bloc

  //Use cases

  // Repository

  // Data sources

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
