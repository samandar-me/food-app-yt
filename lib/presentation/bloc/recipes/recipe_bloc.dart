import 'package:bloc/bloc.dart';
import 'package:food_app_yt/domain/use_case/on_get_recipes.dart';
import 'package:food_app_yt/domain/use_case/on_login.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_event.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipesUseCase getRecipesUseCase;

  RecipeBloc({required this.getRecipesUseCase}) : super(InitialState()) {
    on<RecipeEvent>((event, emit) async {
      if(event is OnGetRecipes) {
        emit(LoadingState());
        await Future.delayed(const Duration(seconds: 1));
        final response = await getRecipesUseCase(event.query);
        response.fold((l) => emit(const ErrorState("Error")), (r) => emit(SuccessState(r)));
      }
    });
  }
}
