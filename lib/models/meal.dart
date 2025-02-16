import 'food_item.dart';

class Meal {
  final String type;
  final List<FoodItem> foods;

  Meal({required this.type, required this.foods});

  int get totalCalories => foods.fold(0, (sum, food) => sum + food.calories);
}