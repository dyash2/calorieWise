import '../question_model.dart';

List<Question> calorieCalculatorModel = [
  Question(
    title: "Sex",
    variable: "sex",
    type: Type.RADIO,
    isRequired: true,
    options: [
      Option(value: "Male", points: 1),
      Option(value: "Female", points: 2),
    ], 
  ),
  Question(
    title: "Height",
    variable: "height",
    suffixText: "cm",
    isRequired: true,
    type: Type.NUMBER,
    options: [],
    config: QuestionConfig(minValue: 140, maxValue: 210),
  ),
  Question(
    title: "Weight",
    variable: "weight",
    suffixText: "kg",
    isRequired: true,
    type: Type.NUMBER,
    options: [],
    config: QuestionConfig(minValue: 40, maxValue: 180),
  ),
  Question(
    title: "Age",
    variable: "age",
    suffixText: "yrs",
    isRequired: true,
    type: Type.NUMBER,
    options: [],
    config: QuestionConfig(minValue: 10, maxValue: 100),
  ),
  Question(
    title: "Activity level",
    variable: "activity_level",
    isRequired: false,
    type: Type.MULTIPLE_CHOICE,
    options: [
      Option(value: "No exercise", points: 1),
      Option(value: "Exercise 1-2 times/week", points: 2),
      Option(value: "Exercise 3-4 times/week", points: 3),
      Option(value: "Exercise 5+ times/week", points: 4),
    ],
  ),
  Question(
    title: "Calories",
    variable: "calories",
    suffixText: "kcal/day",
    isRequired: true,
    type: Type.NUMBER,
    options: [],
    config: QuestionConfig(minValue: 1000, maxValue: 4000),
  ),
];
