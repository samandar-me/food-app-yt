import 'package:dartz/dartz.dart';
import 'package:food_app_yt/core/failure.dart';
import 'package:food_app_yt/data/model/food_response.dart';

abstract class RemoteRepository {
  Future<bool> login();
  Future<Either<Failure, List<Results>>> getRecipes(Map<String, dynamic> query);
}