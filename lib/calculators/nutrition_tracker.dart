import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../controllers/nutrition_controller.dart';

class CalorieTracker extends StatefulWidget {
  const CalorieTracker({super.key});

  @override
  _CalorieTrackerState createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {
  List<Map<String, dynamic>> nutritionData = []; // To store API data
  final NutritionController nutritionController = NutritionController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchNutritionData('apple'); // Initial fetch
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Column(
          children: [
            // Header Section
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/8312.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(100),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.purple.shade500.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    left: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Nutrition Tracker\n',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Track your daily intake',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Search TextFormField and Results Section
            Expanded(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        searchQuery = value; // Update the search query
                        fetchNutritionData(
                            searchQuery); // Fetch data based on the query
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
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ResponseList class to display nutrition info
class ResponseList extends StatelessWidget {
  final String title;
  final String value;

  const ResponseList({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
