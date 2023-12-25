import 'package:dartz/dartz.dart';
import 'package:food_app_yt/core/failure.dart';
import 'package:food_app_yt/data/manager/api_service.dart';
import 'package:food_app_yt/data/manager/auth_manager.dart';
import 'package:food_app_yt/data/model/food_response.dart';
import 'package:food_app_yt/domain/repository/remote_repository.dart';

import '../../core/network_info.dart';

class RemoteRepositoryImpl extends RemoteRepository {

  final AuthManager authManager;
  final NetworkInfo networkInfo;
  final ApiService apiService;
  RemoteRepositoryImpl(this.authManager, this.apiService, this.networkInfo);

  @override
  Future<bool> login() async {
    return await authManager.signIn();
  }

  @override
  Future<Either<Failure, List<Results>>> getRecipes(Map<String, dynamic> query) async {
    if(!await networkInfo.isConnected) {
      return Left(OfflineFailure());
    }
    final response = await apiService.getRecipes(query);
    if(response.results != null) {
      return Right(response.results!);
    } else {
      return Left(UnknownFailure(""));
    }
  }
}