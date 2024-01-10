import 'package:bloc/bloc.dart';
import 'package:food_app_yt/domain/use_case/on_get_recipes.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_event.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipesUseCase getRecipesUseCase;

  RecipeBloc({required this.getRecipesUseCase}) : super(InitialState()) {
    on<RecipeEvent>((event, emit) async {
      if(event is OnGetRecipes) {
        final queryMap = {
          'apiKey': 'ddb2169c7f044f49a4b3d3714d627ecb',
          'number': 30,
          'addRecipeInformation': true,
          'fillIngredients': true,
          'type': event.mealType,
          'diet': event.dietType
        };

        emit(LoadingState());
        await Future.delayed(const Duration(seconds: 1));
        final response = await getRecipesUseCase(queryMap);
        response.fold((l) => emit(const ErrorState("Error")), (r) => emit(SuccessState(r)));
      } else if (event is OnSearch) {
        final queryMap = {
          'query': event.query,
          'apiKey': 'ddb2169c7f044f49a4b3d3714d627ecb',
          'number': 30,
          'addRecipeInformation': true,
          'fillIngredients': true,
          'type': "main",
          'diet': "gluten free"
        };
        emit(LoadingState());
        await Future.delayed(const Duration(seconds: 1));
        final response = await getRecipesUseCase(queryMap);
        response.fold((l) => emit(const ErrorState("Error")), (r) => emit(SuccessState(r)));
      }
    });
  }
}
