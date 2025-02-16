# Calorie Tracker App

A Flutter app to track daily calorie intake by logging meals (Breakfast, Lunch, Dinner) and food items. The app allows users to add predefined or custom food items, view daily summaries, and track progress.

---

## Table of Contents
1. [Folder Structure](#folder-structure)
2. [File Descriptions](#file-descriptions)
   - [Main Entry Point](#main-entry-point)
   - [Models](#models)
   - [Services](#services)
   - [Screens](#screens)
   - [Widgets](#widgets)
   - [Utils](#utils)
   - [Assets](#assets)
   - [Configuration](#configuration)
3. [How to Run the App](#how-to-run-the-app)
4. [Features](#features)
5. [Dependencies](#dependencies)
6. [Contributing](#contributing)
7. [License](#license)

---

## Folder Structure
calorie_tracker/
├── android/ # Android-specific files
├── ios/ # iOS-specific files
├── lib/ # Main application code
│ ├── main.dart # Entry point of the app
│ ├── models/ # Data models
│ │ ├── food_item.dart # Food item model
│ │ ├── meal.dart # Meal model
│ │ └── day_log.dart # Daily log model
│ ├── services/ # Services for data management
│ │ ├── database.dart # Local storage service
│ │ └── auth.dart # Authentication service (optional)
│ ├── screens/ # App screens
│ │ ├── home_screen.dart # Main screen with daily summary
│ │ ├── meal_screen.dart # Screen to add foods to a meal
│ │ ├── food_list_screen.dart # List of all foods
│ │ ├── add_food_screen.dart # Screen to add custom foods
│ │ └── history_screen.dart # View past days
│ ├── widgets/ # Reusable UI components
│ │ ├── food_item_card.dart # Card to display food items
│ │ ├── meal_summary.dart # Summary of a meal
│ │ └── calorie_progress.dart # Progress indicator for calories
│ └── utils/ # Utility files
│ ├── constants.dart # App constants
│ └── theme.dart # Theme data
├── assets/ # App assets
│ ├── images/ # App images
│ └── fonts/ # Custom fonts (if any)
├── test/ # Test files
├── pubspec.yaml # Dependencies and asset configuration
└── README.md # Project documentation

  

---

## File Descriptions

### **Main Entry Point**
#### **`lib/main.dart`**
- The entry point of the app.
- Initializes the Flutter app and sets up the theme.
- Launches the `HomeScreen`.
- Example:
  ```dart
  import 'package:flutter/material.dart';
  import 'screens/home_screen.dart';
  import 'utils/theme.dart';

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Calorie Tracker',
        theme: appTheme,
        home: HomeScreen(),
      );
    }
  }
Models
lib/models/food_item.dart
Represents a food item with properties like name and calories.

Example:

dart
  
class FoodItem {
  final String name;
  final int calories;

  FoodItem({required this.name, required this.calories});
}
lib/models/meal.dart
Represents a meal (Breakfast, Lunch, Dinner) with a list of FoodItems.

Example:

dart
  
import 'food_item.dart';

class Meal {
  final String type;
  final List<FoodItem> foods;

  Meal({required this.type, required this.foods});

  int get totalCalories => foods.fold(0, (sum, food) => sum + food.calories);
}
lib/models/day_log.dart
Represents a daily log with a list of Meals and total calories.

Example:

dart
  
import 'meal.dart';

class DayLog {
  final DateTime date;
  final List<Meal> meals;

  DayLog({required this.date, required this.meals});

  int get totalCalories => meals.fold(0, (sum, meal) => sum + meal.totalCalories);
}
Services
lib/services/database.dart
Manages local storage for DayLog and User data.

Example:

dart
  
import '../models/day_log.dart';
import '../models/user.dart';

class Database {
  static List<User> users = [];

  static void addDayLog(String userName, DayLog dayLog) {
    final user = users.firstWhere(
      (user) => user.name == userName,
      orElse: () => User(name: userName, dayLogs: []),
    );
    user.dayLogs.add(dayLog);
    if (!users.contains(user)) {
      users.add(user);
    }
  }

  static List<DayLog> getDayLogs(String userName) {
    final user = users.firstWhere(
      (user) => user.name == userName,
      orElse: () => User(name: userName, dayLogs: []),
    );
    return user.dayLogs;
  }
}
lib/services/auth.dart
Handles user authentication (optional).

Example:

dart
  
class Auth {
  static bool isLoggedIn = false;

  static void login() {
    isLoggedIn = true;
  }

  static void logout() {
    isLoggedIn = false;
  }
}
Screens
lib/screens/home_screen.dart
Displays a summary of daily calorie intake and a list of logged meals.

Example:

dart
  
import 'package:flutter/material.dart';
import '../models/day_log.dart';
import '../services/database.dart';
import '../widgets/calorie_progress.dart';

class HomeScreen extends StatelessWidget {
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
              itemCount: Database.getDayLogs("User1").length,
              itemBuilder: (context, index) {
                DayLog dayLog = Database.getDayLogs("User1")[index];
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
            MaterialPageRoute(builder: (context) => MealScreen(userName: "User1")),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
lib/screens/meal_screen.dart
Allows users to add foods to a meal (Breakfast, Lunch, Dinner).

Example:

dart
  
import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/meal.dart';
import '../services/database.dart';
import 'food_list_screen.dart';

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
lib/screens/food_list_screen.dart
Displays a list of predefined food items.

Example:

dart
  
import 'package:flutter/material.dart';
import '../models/food_item.dart';

class FoodListScreen extends StatelessWidget {
  final Function(FoodItem) onFoodSelected;

  FoodListScreen({required this.onFoodSelected});

  final List<FoodItem> foods = [
    FoodItem(name: 'Banana', calories: 105),
    FoodItem(name: 'Bread', calories: 79),
    FoodItem(name: 'Egg', calories: 68),
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
lib/screens/add_food_screen.dart
Allows users to add custom food items.

Example:

dart
  
import 'package:flutter/material.dart';
import '../models/food_item.dart';

class AddFoodScreen extends StatefulWidget {
  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();

  void _saveFood() {
    if (_formKey.currentState!.validate()) {
      final food = FoodItem(
        name: _nameController.text,
        calories: int.parse(_caloriesController.text),
      );
      Navigator.pop(context, food);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Custom Food'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Food Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a food name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _caloriesController,
                decoration: InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter calories';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveFood,
                child: Text('Save Food'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
lib/screens/history_screen.dart
Displays past daily logs.

Example:

dart
  
import 'package:flutter/material.dart';
import '../models/day_log.dart';
import '../services/database.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: Database.getDayLogs("User1").length,
        itemBuilder: (context, index) {
          DayLog dayLog = Database.getDayLogs("User1")[index];
          return ListTile(
            title: Text(dayLog.date.toString()),
            subtitle: Text('Total Calories: ${dayLog.totalCalories}'),
          );
        },
      ),
    );
  }
}
Widgets
lib/widgets/food_item_card.dart
Displays a food item in a card format.

Example:

dart
  
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
lib/widgets/meal_summary.dart
Displays a summary of a meal (e.g., total calories).

Example:

dart
  
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
lib/widgets/calorie_progress.dart
Displays a progress bar for daily calorie intake.

Example:

dart
  
import 'package:flutter/material.dart';

class CalorieProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Daily Calorie Intake',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ],
      ),
    );
  }
}
Utils
lib/utils/constants.dart
Defines app-wide constants (e.g., app name).

Example:

dart
  
const String appName = 'Calorie Tracker';
lib/utils/theme.dart
Defines the app's theme (e.g., colors, fonts).

Example:

dart
  
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.grey,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
);
Assets
assets/images/
Stores images used in the app.

assets/fonts/
Stores custom fonts (if any).

Configuration
pubspec.yaml
Defines the app's dependencies and assets.

Example:

yaml
  
name: calorie_tracker
description: A simple calorie tracker app.

publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: ">=2.12.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test: