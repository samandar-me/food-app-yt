import 'package:flutter/material.dart';
import 'package:food_app_yt/presentation/screen/main_screen.dart';

void main() {
  runApp(FoodApp());
}
class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

