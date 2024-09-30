import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NutritionScreen extends StatefulWidget {
  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  TextEditingController _textController = TextEditingController();
  bool isLoading = false;
  double targetWeight = 0;
  double actualWeight = 0;
  String activityLevel = 'Sedentary';
  final List<String> activityLevels = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Very Active',
    'Super Active'
  ];

  double? bmr;
  double? tdee;
  double? calorieDeficit;
  double? calorieSurplus;
  double? foodCalories; // Calories from API
  String resultMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';
    actualWeight = prefs.getDouble('weight') ?? 0;
    double height = prefs.getDouble('height') ?? 0;
    String gender = prefs.getString('gender') ?? 'Male';

    // Calculate BMR
    if (gender == 'Male') {
      bmr = 10 * actualWeight + 6.25 * height - 5 * 30 + 5;
    } else {
      bmr = 10 * actualWeight + 6.25 * height - 5 * 30 - 161;
    }

    setState(() {});
  }

  void calculateTDEE() {
    switch (activityLevel) {
      case 'Sedentary':
        tdee = bmr! * 1.2;
        break;
      case 'Lightly Active':
        tdee = bmr! * 1.375;
        break;
      case 'Moderately Active':
        tdee = bmr! * 1.55;
        break;
      case 'Very Active':
        tdee = bmr! * 1.725;
        break;
      case 'Super Active':
        tdee = bmr! * 1.9;
        break;
    }

    calorieDeficit = tdee! - 500;
    calorieSurplus = tdee! + 500;
    setState(() {});
  }

  Future<void> fetchFoodCalories(String food) async {
    setState(() {
      isLoading = true;
    });

    try {
      // Example API URL - replace with your actual API endpoint
      var url =
          Uri.parse('https://api.calorieninjas.com/v1/nutrition?query=$food');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // Get the calories from the API response
        foodCalories = data['items'][0]['calories'];
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  void calculateWeightLoss() {
    if (foodCalories != null && tdee != null) {
      double remainingCalories = tdee! - foodCalories!;

      if ((actualWeight - targetWeight) < 25) {
        resultMessage = "Don't lose weight.";
      } else {
        resultMessage = remainingCalories > 0
            ? "Caloric deficit of ${remainingCalories.toStringAsFixed(2)}"
            : "Caloric surplus of ${(remainingCalories * -1).toStringAsFixed(2)}";
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Select Activity Level:'),
              DropdownButton<String>(
                value: activityLevel,
                onChanged: (String? newValue) {
                  setState(() {
                    activityLevel = newValue!;
                    calculateTDEE();
                  });
                },
                items: activityLevels
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              if (bmr != null) Text('BMR: ${bmr!.toStringAsFixed(2)}'),
              if (tdee != null) Text('TDEE: ${tdee!.toStringAsFixed(2)}'),
              if (calorieDeficit != null)
                Text('Calorie Deficit: ${calorieDeficit!.toStringAsFixed(2)}'),
              if (calorieSurplus != null)
                Text('Calorie Surplus: ${calorieSurplus!.toStringAsFixed(2)}'),
              const SizedBox(height: 20),
              const Text('Enter your target weight (kg):'),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Target Weight',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  targetWeight = double.parse(value);
                },
              ),
              const SizedBox(height: 20),
              const Text('Enter your food:'),
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Enter your food',
                  border: OutlineInputBorder(),
                ),
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  String food = _textController.text;
                  await fetchFoodCalories(food);
                  calculateWeightLoss();
                },
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 20),
              if (resultMessage.isNotEmpty)
                Text(
                  resultMessage,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
