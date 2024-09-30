import 'package:calorie_wise/screens/nutrition_screen.dart';
import 'package:calorie_wise/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  final num weight;
  final num height;
  final String gender;

  const HomeScreen({
    super.key,
    required this.name,
    required this.weight,
    required this.height,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Home Screen'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                          name: name, weight: weight, height: height)));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Welcome To\nCalorie Wise, $name!',
              style: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Nutrition Calculator Screen
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NutritionScreen()));
              },
              child: const Text(
                "Calculate Nutrition\nBy Your Food",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
