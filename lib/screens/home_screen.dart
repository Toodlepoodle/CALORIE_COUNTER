import 'package:flutter/material.dart';
import 'meal_screen.dart';
import '../models/day_log.dart';
import '../services/database.dart';
import '../widgets/calorie_progress.dart';

class HomeScreen extends StatelessWidget {
  final String userName = "User1"; // Replace with dynamic user input if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Tracker'),
      ),
      body: Column(
        children: [
          CalorieProgress(),
          Expanded(
            child: ListView.builder(
              itemCount: Database.getDayLogs(userName).length,
              itemBuilder: (context, index) {
                DayLog dayLog = Database.getDayLogs(userName)[index];
                return ListTile(
                  title: Text(dayLog.date.toString()),
                  subtitle: Text('Total Calories: ${dayLog.totalCalories}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MealScreen(userName: userName)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}