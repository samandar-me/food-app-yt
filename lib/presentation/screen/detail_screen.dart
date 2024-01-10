import 'package:flutter/material.dart';
import 'package:food_app_yt/data/model/food_response.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.food});
  final Results? food;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(food?.title ?? ""),),
    );
  }
}
