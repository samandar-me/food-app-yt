import 'package:food_app_yt/data/manager/auth_manager.dart';
import 'package:food_app_yt/data/repository/remote_repository_impl.dart';
import 'package:food_app_yt/domain/repository/remote_repository.dart';
import 'package:food_app_yt/domain/use_case/on_login.dart';
import 'package:food_app_yt/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));

  sl.registerLazySingleton(() => AuthManager());
  sl.registerLazySingleton<RemoteRepository>(() => RemoteRepositoryImpl(sl()));

  sl.registerLazySingleton(() => OnLoginUseCase(sl()));
}