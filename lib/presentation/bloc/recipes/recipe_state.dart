import 'package:equatable/equatable.dart';

import '../../../data/model/food_response.dart';


abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object?> get props => [];
}

class InitialState extends RecipeState{}
class LoadingState extends RecipeState{}
class ErrorState extends RecipeState{
  final String message;
  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
class SuccessState extends RecipeState {
  final List<Results> results;
  const SuccessState(this.results);

  @override
  List<Object?> get props => [results];
}