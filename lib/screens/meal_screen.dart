import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/meal.dart';
import '../services/database.dart';
import 'food_list_screen.dart';
import '../models/day_log.dart';

class MealScreen extends StatefulWidget {
  final String userName;

  MealScreen({required this.userName});

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  String selectedMealType = 'Breakfast';
  List<FoodItem> selectedFoods = [];

  void _addFood(FoodItem food) {
    setState(() {
      selectedFoods.add(food);
    });
  }

  void _saveMeal() {
    Meal meal = Meal(type: selectedMealType, foods: selectedFoods);
    Database.addDayLog(widget.userName, DayLog(date: DateTime.now(), meals: [meal]));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Meal'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedMealType,
            onChanged: (String? newValue) {
              setState(() {
                selectedMealType = newValue!;
              });
            },
            items: <String>['Breakfast', 'Lunch', 'Dinner']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedFoods.length,
              itemBuilder: (context, index) {
                FoodItem food = selectedFoods[index];
                return ListTile(
                  title: Text(food.name),
                  subtitle: Text('${food.calories} calories'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodListScreen(onFoodSelected: _addFood)),
              );
            },
            child: Text('Add Food'),
          ),
          ElevatedButton(
            onPressed: _saveMeal,
            child: Text('Save Meal'),
          ),
        ],
      ),
    );
  }
}