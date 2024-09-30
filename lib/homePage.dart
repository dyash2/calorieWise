import 'package:flutter/material.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  @override
  _CalorieCalculatorScreenState createState() =>
      _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  String gender = 'Male';
  int age = 18;
  double height = 170; // cm
  double weight = 70; // kg
  String activityLevel = 'Sedentary';
  double calorieIntake = 0;
  double targetWeight = 0; // Target weight for weight loss

  double tdee = 0;
  double calorieDeficit = 0;
  double calorieSurplus = 0;
  double weightLossTime = 0; // Time in weeks to reach target weight

  final List<String> activityLevels = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Very Active',
    'Super Active'
  ];

  void calculateTDEE() {
    // Calculate TDEE based on Mifflin-St Jeor Equation
    double bmr;

    if (gender == 'Male') {
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      bmr = 10 * weight + 6.25 * height - 5 * age - 161;
    }

    switch (activityLevel) {
      case 'Sedentary':
        tdee = bmr * 1.2;
        break;
      case 'Lightly Active':
        tdee = bmr * 1.375;
        break;
      case 'Moderately Active':
        tdee = bmr * 1.55;
        break;
      case 'Very Active':
        tdee = bmr * 1.725;
        break;
      case 'Super Active':
        tdee = bmr * 1.9;
        break;
    }

    // Calculate calorie deficit and surplus
    calorieDeficit = tdee - calorieIntake;
    calorieSurplus = calorieIntake - tdee;

    // Calculate weight loss time
    if (calorieDeficit > 0) {
      // 1 kg of fat = approximately 7700 calories
      double totalWeightLossNeeded = weight - targetWeight;
      weightLossTime =
          (totalWeightLossNeeded * 7700) / calorieDeficit / 7; // in weeks
    } else {
      weightLossTime = 0; // Cannot lose weight if there's no deficit
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Gender:'),
            DropdownButton<String>(
              value: gender,
              onChanged: (String? newValue) {
                setState(() {
                  gender = newValue!;
                });
              },
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text('Age (years):'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                age = int.parse(value);
              },
            ),
            SizedBox(height: 16),
            Text('Height (cm):'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                height = double.parse(value);
              },
            ),
            SizedBox(height: 16),
            Text('Weight (kg):'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                weight = double.parse(value);
              },
            ),
            SizedBox(height: 16),
            Text('Select Activity Level:'),
            DropdownButton<String>(
              value: activityLevel,
              onChanged: (String? newValue) {
                setState(() {
                  activityLevel = newValue!;
                });
              },
              items:
                  activityLevels.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text('Caloric Intake:'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                calorieIntake = double.parse(value);
              },
            ),
            SizedBox(height: 16),
            Text('Target Weight (kg):'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                targetWeight = double.parse(value);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  calculateTDEE();
                });
              },
              child: Text('Calculate'),
            ),
            SizedBox(height: 16),
            Text('TDEE: ${tdee.toStringAsFixed(2)} calories'),
            Text(
                'Caloric Deficit: ${calorieDeficit.toStringAsFixed(2)} calories'),
            Text(
                'Caloric Surplus: ${calorieSurplus.toStringAsFixed(2)} calories'),
            Text(
                'Time to reach target weight: ${weightLossTime.isFinite ? weightLossTime.toStringAsFixed(2) : "N/A"} weeks'),
          ],
        ),
      ),
    );
  }
}
