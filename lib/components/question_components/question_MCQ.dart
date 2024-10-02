import 'package:flutter/material.dart';
import '../../common/textColor.dart';
import '../../model/question_model.dart';

class QuestionMcq extends StatefulWidget {
  const QuestionMcq({
    super.key,
    required this.question,
    required this.textEditingController,
    this.indexNumber,
  });

  final Question question;
  final TextEditingController textEditingController;
  final int? indexNumber;

  @override
  State<QuestionMcq> createState() => _QuestionMcqState();
}

class _QuestionMcqState extends State<QuestionMcq> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final bool _isRequired = widget.question.isRequired;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: widget.question.title,
              style: const TextStyle(
                  fontSize: 16,
                  color: TextColor.textColorDark,
                  fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: _isRequired ? " *" : "",
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
          ]),
        ),
        const SizedBox(height: 10),
        // ListView.builder to display MCQ options
        ListView.builder(
          shrinkWrap: true, // To avoid infinite height error
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          itemCount: widget.question.options.length,
          itemBuilder: (context, index) {
            final option = widget.question.options[index];
            return RadioListTile<int>(
              title: Text(option.value),
              value: index,
              groupValue: _selectedOption,
              onChanged: (int? value) {
                setState(() {
                  _selectedOption = value;
                  widget.textEditingController.text = option.value;
                  widget.question.selectedValue = value; // Update selected value
                });
              },
            );
          },
        ),
      ],
    );
  }
}
