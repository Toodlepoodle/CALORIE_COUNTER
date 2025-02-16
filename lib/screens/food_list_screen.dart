import 'package:flutter/material.dart';
import '../models/food_item.dart';

class FoodListScreen extends StatelessWidget {
  final Function(FoodItem) onFoodSelected;

  FoodListScreen({required this.onFoodSelected});

  final List<FoodItem> foods = [
    FoodItem(name: 'Banana', calories: 105),
    FoodItem(name: 'Bread', calories: 79),
    FoodItem(name: 'Egg', calories: 68),
    FoodItem(name: 'Oatmeal', calories: 150),
    FoodItem(name: 'Yogurt', calories: 100),
    FoodItem(name: 'Apple', calories: 95),
    FoodItem(name: 'Chicken Salad', calories: 250),
    FoodItem(name: 'Pasta', calories: 400),
    FoodItem(name: 'Pizza', calories: 600),
    FoodItem(name: 'Burger', calories: 500),
    FoodItem(name: 'Rice', calories: 200),
    FoodItem(name: 'Fish', calories: 300),
    FoodItem(name: 'Steak', calories: 450),
    FoodItem(name: 'Soup', calories: 150),
    FoodItem(name: 'Sandwich', calories: 350),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Food'),
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          FoodItem food = foods[index];
          return ListTile(
            title: Text(food.name),
            subtitle: Text('${food.calories} calories'),
            onTap: () {
              onFoodSelected(food);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}