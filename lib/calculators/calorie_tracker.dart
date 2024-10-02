import 'package:calorie_wise/common/textColor.dart';
import 'package:calorie_wise/components/custom_button.dart';
import 'package:calorie_wise/components/header_section.dart';
import 'package:calorie_wise/model/question_model/calorie_tracker_questions.dart';
import 'package:flutter/material.dart';
import '../components/question_components/question_MCQ.dart';
import '../components/question_components/question_NUMBER.dart';
import '../model/question_model.dart';
import '../screens/calculators_screen.dart';
import '../screens/result_screen.dart'; // Import ResultScreen

class CalorieTracker extends StatefulWidget {
  @override
  State<CalorieTracker> createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {
  Map<String, dynamic> userResponses = {};
  Map<String, TextEditingController> controllers = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    for (var question in calorieCalculatorModel) {
      if (question.type == Type.NUMBER) {
        controllers[question.variable] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    controllers.forEach((key, controller) {
      controller.dispose();
    });
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildQuestion(Question question, int index) {
    switch (question.type) {
      case Type.MULTIPLE_CHOICE:
        return QuestionMcq(
          question: question,
          textEditingController: TextEditingController(),
        );
      case Type.NUMBER:
        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Optional padding
              child: Text(
                question.title,
                style: const TextStyle(
                  fontSize: 16,
                  color: TextColor.textColorDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controllers[question.variable],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: question.title,
                  suffixText: question.suffixText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: TextColor.textColorDark,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (value) {
                  userResponses[question.variable] =
                      value.isNotEmpty ? double.tryParse(value) : null;
                },
              ),
            ),
          ],
        );
      case Type.RADIO:
        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Gender",
                style: const TextStyle(
                  fontSize: 16,
                  color: TextColor.textColorDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ...question.options.map((option) {
              return RadioListTile(
                title: Text(option.value),
                value: option.value,
                groupValue: userResponses[question.variable],
                onChanged: (value) {
                  setState(() {
                    userResponses[question.variable] = value;
                  });
                },
              );
            }).toList(),
          ],
        );
      default:
        return Container();
    }
  }

  void calculateCalories() {
    // // Validation
    // Calculate results
    double totalCalories = calculateTotalCalories();
    double bmi = calculateBMI();
    double tdee = calculateTDEE(totalCalories);

    // Navigate to ResultScreen with calculated values
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          totalCalories: totalCalories,
          bmi: bmi,
          tdee: tdee,
        ),
      ),
    );
  }

  bool areAllResponsesValid() {
    for (var question in calorieCalculatorModel) {
      if (question.type == Type.MULTIPLE_CHOICE &&
          (userResponses[question.variable] == null)) {
        return false;
      }
      if (question.type == Type.NUMBER &&
          (!controllers[question.variable]!.text.isNotEmpty)) {
        return false;
      }
    }
    return true;
  }

  double calculateTotalCalories() {
    // Implementation of calorie calculation
    double baseCalories = 2000;

    if (userResponses['sex'] == 'Male') {
      baseCalories += 200;
    } else if (userResponses['sex'] == 'Female') {
      baseCalories += 100;
    }

    switch (userResponses['activity_level']) {
      case "No exercise":
        break;
      case "Exercise 1-2 times/week":
        baseCalories += 200;
        break;
      case "Exercise 3-4 times/week":
        baseCalories += 400;
        break;
      case "Exercise 5+ times/week":
        baseCalories += 600;
        break;
    }

    double weight = userResponses['weight'] ?? 0;
    double height = userResponses['height'] ?? 0;

    return baseCalories + (weight * 10) + (height * 5);
  }

  double calculateBMI() {
    double weight = userResponses['weight'] ?? 0;
    double height = userResponses['height'] ?? 0;

    if (weight > 0 && height > 0) {
      return weight / ((height / 100) * (height / 100));
    }
    return 0;
  }

  double calculateTDEE(double totalCalories) {
    double weight = userResponses['weight'] ?? 0;
    double height = userResponses['height'] ?? 0;
    double age = userResponses['age'] ?? 0;
    double bmr;

    if (userResponses['sex'] == 'Male') {
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      bmr = 10 * weight + 6.25 * height - 5 * age - 161;
    }

    return bmr * (1 + (totalCalories / 2000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
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
              title: "Calorie Tracker",
              subtitle: "Track Your Calories",
              imagePath: "assets/8312.jpg",
            ),
            Expanded(
              flex: 4,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: calorieCalculatorModel.length,
                itemBuilder: (context, index) {
                  Question question = calorieCalculatorModel[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildQuestion(question, index),
                      ],
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              text: "Calculate",
              onPressed: calculateCalories,
              backgroundColor: Colors.purpleAccent.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }
}
