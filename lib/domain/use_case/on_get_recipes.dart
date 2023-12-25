import 'package:dartz/dartz.dart';
import 'package:food_app_yt/core/failure.dart';
import 'package:food_app_yt/data/model/food_response.dart';
import 'package:food_app_yt/domain/repository/remote_repository.dart';

class GetRecipesUseCase {
  final RemoteRepository remoteRepository;
  const GetRecipesUseCase(this.remoteRepository);

  Future<Either<Failure, List<Results>>> call(Map<String, dynamic> query) async {
    return await remoteRepository.getRecipes(query);
  }
}