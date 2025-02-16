import 'meal.dart';

class DayLog {
  final DateTime date;
  final List<Meal> meals;

  DayLog({required this.date, required this.meals});

  int get totalCalories => meals.fold(0, (sum, meal) => sum + meal.totalCalories);
}