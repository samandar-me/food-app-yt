import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_bloc.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_event.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_state.dart';
import 'package:food_app_yt/presentation/widget/loading.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {

  @override
  void initState() {
    BlocProvider.of<RecipeBloc>(context).add(OnGetRecipes(_query()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe"),),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if(state is SuccessState) {
            print(state.results.length);
            return Container();
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
  _query() {
    return {
      'apiKey': 'ddb2169c7f044f49a4b3d3714d627ecb',
      'number': 30,
      'addRecipeInformation': true,
      'fillIngredients': true,
      'type': 'desert',
      'diet': 'gluten free'
    };
  }
}
