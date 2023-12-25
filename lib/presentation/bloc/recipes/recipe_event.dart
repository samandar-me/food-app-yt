import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object?> get props => [];
}

class OnGetRecipes extends RecipeEvent {
  final Map<String, dynamic> query;

  const OnGetRecipes(this.query);

  @override
  List<Object?> get props => [query];
}
