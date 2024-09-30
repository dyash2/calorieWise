import 'package:flutter/material.dart';

import '../controllers/nutrition_controller.dart';

class ApiFire extends StatefulWidget {
  const ApiFire({super.key});

  @override
  _ApiFireState createState() => _ApiFireState();
}

class _ApiFireState extends State<ApiFire> {
  NutritionController controller = NutritionController();
  
  // Variable to store the API result
  List<Map<String, dynamic>> result = [];
  
  // Variable to track if the API call is in progress
  bool isLoading = false;

  // Function to trigger the API call
  Future<void> fetchNutrition() async {
    setState(() {
      isLoading = true; // Show loading when API call starts
    });

    try {
      var fetchedResult = await controller.getNutritionValue('onion, tomato');
      setState(() {
        result = fetchedResult; // Set the result after fetching
      });
    } catch (e) {
      // Handle error
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false; // Hide loading when API call finishes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Call Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: fetchNutrition, // Call the API when button is pressed
              child: isLoading
                  ? CircularProgressIndicator() // Show loader if loading
                  : Text("Click Me to Fire the API"),
            ),
            SizedBox(height: 20),
            result.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        var item = result[index];
                        return ListTile(
                          title: Text('Item: ${item['name']}'),
                          subtitle: Text(
                            'Calories: ${item['calories']} | Fat: ${item['fat_total_g']}g | Protein: ${item['protein_g']}g | Carbs: ${item['carbohydrates_total_g']}g',
                          ),
                        );
                      },
                    ),
                  )
                : Text("No data fetched yet."),
          ],
        ),
      ),
    );
  }
}