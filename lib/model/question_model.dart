class Question {
  String title;
  String variable;
  Type type;
  List<Option> options;
  int? selectedValue;
  String? suffixText;
  QuestionConfig? config;
  bool isRequired;
  String? hint;
  Question({
    required this.title,
    required this.variable,
    required this.type,
    required this.options,
    this.selectedValue,
    this.suffixText,
    this.hint,
    this.config,
    required this.isRequired,
  });
}

class Option {
  final String value;
  final int points;

  Option({required this.value, required this.points});
}

enum Type {
  RADIO,
  MULTIPLE_CHOICE,
  NUMBER,
}

class QuestionConfig {
  final int minValue;
  final int maxValue;

  QuestionConfig({required this.minValue, required this.maxValue});
}