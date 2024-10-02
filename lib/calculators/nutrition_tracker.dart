import 'dart:ui';
import 'package:calorie_wise/components/custom_button.dart';
import 'package:calorie_wise/components/header_section.dart';
import 'package:calorie_wise/screens/calculators_screen.dart';
import 'package:calorie_wise/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../components/exit_dialog.dart';
import '../components/response_list.dart';
import '../controllers/nutrition_controller.dart';

class NutritionTracker extends StatefulWidget {
  const NutritionTracker({super.key});

  @override
  _NutritionTrackerState createState() => _NutritionTrackerState();
}

class _NutritionTrackerState extends State<NutritionTracker> {
  List<Map<String, dynamic>> nutritionData = []; // To store API data
  final NutritionController nutritionController = NutritionController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchNutritionData(''); // Initial fetch
  }

  Future<void> fetchNutritionData(String query) async {
    try {
      List<Map<String, dynamic>> data =
          await nutritionController.getNutritionValue(query);
      setState(() {
        nutritionData = data; // Update state with fetched data
      });
    } catch (e) {
      log('Error fetching nutrition data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show the confirmation dialog when the user tries to quit
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => const ExitConfirmationDialog(),
        );
        return shouldExit ?? false; // Return true to exit, false to stay
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: GestureDetector(
            child:
                const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CalculatorsScreen()));
            },
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          color: Colors.grey.shade100,
          child: Column(
            children: [
              const HeaderSection(
                  title: "Nutrition Tracker",
                  subtitle: "Track your daily intake",
                  imagePath: 'assets/8312.jpg'),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          searchQuery = value;
                          fetchNutritionData(searchQuery);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          hintText: 'Search for food...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(height: 10),
                          
                      // Display the name of the first food item if available
                      if (nutritionData.isNotEmpty)
                        Text(
                          nutritionData[0]['name']?.toUpperCase() ??
                              'NO FOOD FOUND',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else
                        const Text(
                          'No Food Found',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(height: 10),
                          
                      // Display nutritional information
                      for (var item in nutritionData) ...[
                        ResponseList(
                          title: 'Calories',
                          value:
                              '${item['calories'] ?? 'N/A'}', // Ensure value is a string
                        ),
                        const Divider(),
                        ResponseList(
                          title: 'Fat Total',
                          value:
                              '${item['fat_total_g'] ?? 'N/A'} g', // Ensure value is a string
                        ),
                        const Divider(),
                        ResponseList(
                          title: 'Protein',
                          value:
                              '${item['protein_g'] ?? 'N/A'} g', // Ensure value is a string
                        ),
                        const Divider(),
                        ResponseList(
                          title: 'Carbohydrates',
                          value:
                              '${item['carbohydrates_total_g'] ?? 'N/A'} g', // Ensure value is a string
                        ),
                        const Divider(),
                        ResponseList(
                          title: 'Sugar',
                          value:
                              '${item['sugar_g'] ?? 'N/A'} g', // Ensure value is a string
                        ),
                        const Divider(),
                        Center(
                          child: Column(
                            children: [
                              CustomButton(
                                text: 'SAVE',
                                backgroundColor: Colors.purpleAccent,
                                onPressed: () {
                                  print(
                                      'Saved: ${nutritionData[0]['name'] ?? 'N/A'}');
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomButton(
                                text: 'SHARE',
                                backgroundColor: Colors.pink,
                                onPressed: () {
                                  print(
                                      'Shared: ${nutritionData[0]['name'] ?? 'N/A'}');
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
