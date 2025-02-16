import 'package:flutter/material.dart';
import '../models/day_log.dart';
import '../services/database.dart';

class HistoryScreen extends StatelessWidget {
  final String userName = "User1"; // Replace with dynamic user input if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: Database.getDayLogs(userName).length,
        itemBuilder: (context, index) {
          DayLog dayLog = Database.getDayLogs(userName)[index];
          return ListTile(
            title: Text(dayLog.date.toString()),
            subtitle: Text('Total Calories: ${dayLog.totalCalories}'),
          );
        },
      ),
    );
  }
}