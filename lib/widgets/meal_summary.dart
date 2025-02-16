import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealSummary extends StatelessWidget {
  final Meal meal;

  MealSummary({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(meal.type, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...meal.foods.map((food) => ListTile(
            title: Text(food.name),
            subtitle: Text('${food.calories} calories'),
          )).toList(),
          Divider(),
          Text('Total: ${meal.totalCalories} calories', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}