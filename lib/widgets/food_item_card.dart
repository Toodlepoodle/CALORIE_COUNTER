import 'package:flutter/material.dart';
import '../models/food_item.dart';

class FoodItemCard extends StatelessWidget {
  final FoodItem food;

  FoodItemCard({required this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(food.name),
        subtitle: Text('${food.calories} calories'),
      ),
    );
  }
}