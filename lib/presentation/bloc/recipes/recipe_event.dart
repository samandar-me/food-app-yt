import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object?> get props => [];
}

class OnGetRecipes extends RecipeEvent {
  final String mealType;
  final String dietType;

  const OnGetRecipes(this.mealType, this.dietType);

  @override
  List<Object?> get props => [mealType, dietType];
}
class OnSearch extends RecipeEvent {
  final String query;
  const OnSearch(this.query);

  @override
  List<Object?> get props => [query];
}
