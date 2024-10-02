import 'dart:ui';
import 'package:calorie_wise/components/custom_button.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double totalCalories;
  final double bmi;
  final double tdee;

  const ResultScreen({
    super.key,
    required this.totalCalories,
    required this.bmi,
    required this.tdee,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/8312.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple.shade500.withOpacity(0.3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Your Result",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${totalCalories.toStringAsFixed(2)} kcal",
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8), // Space between texts
                  Text(
                    "Body Mass Index: ${bmi.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "TDEE: ${tdee.toStringAsFixed(2)} kcal/day",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Share button
                  CustomButton(
                    text: "Share",
                    backgroundColor: Colors.green,
                    onPressed: () async {
                      final String shareContent = createShareMessage();
                      await shareToOthers(shareContent);
                    },
                  ),
                  const SizedBox(height: 10), // Space between buttons

                  // Back to home button
                  CustomButton(
                    text: "Back To Home",
                    backgroundColor: Colors.redAccent,
                    onPressed: () {
                      Navigator.pop(context); // Navigate back to the previous screen
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to create the share message
  String createShareMessage() {
    return '''
*Calorie & Health Result*

*Daily Calories:*  
*${totalCalories.toStringAsFixed(2)} kcal*  

*Body Mass Index:*  
*${bmi.toStringAsFixed(2)}*  

*TDEE:*  
*${tdee.toStringAsFixed(2)} kcal/day*  

Stay healthy and take care!
''';
  }

  // Method to share via WhatsApp
  Future<void> shareToOthers(String message) async {
    // try {
    //   // Share the message via WhatsApp
    //   await shareWhatsapp.shareText(message);
    // } catch (e) {
    //   // Handle any errors that occur during sharing
    //   print("Error sharing: $e");
    // }
  }
  
}
