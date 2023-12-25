import 'package:food_app_yt/core/network_info.dart';
import 'package:food_app_yt/data/manager/api_service.dart';
import 'package:food_app_yt/data/manager/auth_manager.dart';
import 'package:food_app_yt/data/repository/remote_repository_impl.dart';
import 'package:food_app_yt/domain/repository/remote_repository.dart';
import 'package:food_app_yt/domain/use_case/on_get_recipes.dart';
import 'package:food_app_yt/domain/use_case/on_login.dart';
import 'package:food_app_yt/presentation/bloc/auth/auth_bloc.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
  sl.registerFactory(() => RecipeBloc(getRecipesUseCase: sl()));

  sl.registerLazySingleton(() => AuthManager());
  sl.registerLazySingleton<RemoteRepository>(() => RemoteRepositoryImpl(sl(), sl(), sl()));

  sl.registerLazySingleton(() => OnLoginUseCase(sl()));
  sl.registerLazySingleton(() => GetRecipesUseCase(sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  
  sl.registerLazySingleton(() => InternetConnectionChecker());
  
  final dio = buildDioClient('https://api.spoonacular.com/');
  sl.registerLazySingleton(() => ApiService(dio));
}