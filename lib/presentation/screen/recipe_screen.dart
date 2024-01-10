import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_yt/core/app_bar_type.dart';
import 'package:food_app_yt/data/local/shared_pre.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_bloc.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_event.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_state.dart';
import 'package:food_app_yt/presentation/widget/loading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/model/food_response.dart';
import '../widget/food_item.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {

  AppBarType _barType = AppBarType.normal;
  late ScrollController _scrollController;
  bool _isFabVisible = true;
  Timer? _timer;
  final _shared = SharedPrefManager();

  int selectedMealType = 0;
  int selectedDietType = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _listener();
    _init();
    super.initState();
  }

  void _init() async {
    final mealType = await _shared.getMealType();
    final dietType = await _shared.getDietType();
    selectedDietType = dietType;
    selectedMealType = mealType;
    BlocProvider.of<RecipeBloc>(context).add(OnGetRecipes(mealTypes[selectedMealType], dietTypes[selectedDietType]));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _listener() {
    _scrollController.addListener(() {
      setState(() {
        _isFabVisible = _scrollController.position.userScrollDirection != ScrollDirection.reverse;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _barType == AppBarType.normal ? const Text("Recipes") : _searchWidget(),actions: [
        _barType == AppBarType.normal ? IconButton(
          onPressed: () => setState(() { _barType = AppBarType.search; }),
          icon: const Icon(CupertinoIcons.search),
        ) : Container()
      ],),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if(state is SuccessState) {
            return _successField(state.results);
          } else {
            return const Loading();
          }
        },
      ),
      floatingActionButton: _isFabVisible ? FloatingActionButton(
        onPressed: _showBottomSheet,
        child: const Icon(Icons.restaurant_menu),
      ) : null,
    );
  }

  _searchWidget() {
    return TextField(
      autofocus: true,
      onChanged: (value) {
        if(_timer?.isActive == true) {
          _timer?.cancel();
        }
        _timer = Timer(const Duration(milliseconds: 700), () {
          BlocProvider.of<RecipeBloc>(context).add(OnSearch(value));
        });
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search food...',
        suffixIcon: IconButton(
          onPressed: () => setState(() { _barType = AppBarType.normal; }),
          icon: const Icon(Icons.close),
        )
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(context: context, builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Meal Type", style: GoogleFonts.baloo2(fontSize: 20)),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: mealTypes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(onTap: () {
                        _shared.saveMealType(index);
                        setState(() {
                          selectedMealType = index;
                        });
                      },child: Chip(label: Text(mealTypes[index],style: TextStyle(
                        color: selectedMealType == index ? Colors.white : Colors.black
                      ),),backgroundColor: selectedMealType == index ? Theme.of(context).colorScheme.onBackground : Colors.white)),
                    );
                  },
                ),
              ),
              Text("Diet Type", style: GoogleFonts.baloo2(fontSize: 20)),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: dietTypes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(onTap: () {
                        _shared.saveDietType(index);
                        setState(() {
                          selectedDietType = index;
                        });
                      },child: Chip(label: Text(dietTypes[index],style: TextStyle(
                          color: selectedDietType == index ? Colors.white : Colors.black
                      ),),backgroundColor: selectedDietType == index ? Theme.of(context).colorScheme.onBackground : Colors.white)),
                    );
                  },
                ),
              ),
              SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<RecipeBloc>(context).add(OnGetRecipes(mealTypes[selectedMealType], dietTypes[selectedDietType]));
              }, child: Text("Apply"),style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                foregroundColor: Colors.white
              ),))
            ],
          ),
        );
      }
    ));
  }

  _successField(List<Results> results) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: results.length,
      itemBuilder: (context, index) {
        return FoodItem(
          results: results[index],
          onClick: () {
            context.push("/detail",extra: { "food": results[index] });
          }
        );
      },
    );
  }
}
