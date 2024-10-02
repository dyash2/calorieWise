import 'dart:developer' as l;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/textColor.dart';
import '../../model/question_model.dart';

class QuestionNumber extends StatefulWidget {
  const QuestionNumber({
    super.key,
    required this.textEditingController,
    required this.question,
    this.indexNumber,
  });

  final TextEditingController textEditingController;
  final Question question;
  final int? indexNumber;

  @override
  State<QuestionNumber> createState() => _QuestionNumberState();
}

class _QuestionNumberState extends State<QuestionNumber> {
  @override
  Widget build(BuildContext context) {
    bool _isRequired = widget.question.isRequired;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: widget.question.title,
              style: const TextStyle(
                fontSize: 18,
                color: TextColor.textColorDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: _isRequired ? " *" : "",
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
          ]),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.textEditingController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(width: 2, color: Colors.blue),
            ),
            border: const OutlineInputBorder(),
            suffixIcon: widget.question.suffixText != null &&
                    widget.question.suffixText!.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.only(right: 0),
                    width: 80,
                    height: 67,
                    decoration: BoxDecoration(
                      color: const Color(0xffF0F0F0),
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                    ),
                    child: Center(
                      child: Text(widget.question.suffixText ?? ""),
                    ),
                  )
                : null,
            labelText: widget.question.variable,
            hintText: widget.question.variable,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
            NumberInputFormatter(), // Custom input formatter
          ],
          validator: (value) {
            return validator(value, widget.question);
          },
        ),
      ],
    );
  }

  String? validator(String? value, Question question) {
    bool _isRequired = question.isRequired;

    if (value == null || value.isEmpty) {
      return _isRequired ? "This field is required" : null;
    }

    // Regular expression to match positive and negative numbers (integers and decimals)
    if (!RegExp(r'^-?\d+(\.\d+)?$').hasMatch(value)) {
      return "Enter a valid number";
    }

    // Check for valid number input before parsing
    if (value == '-' || value == '.' || value == '-.') {
      return "Enter a complete number";
    }

    try {
      final numValue = num.parse(value);

      if (question.config != null) {
        if (question.config!.maxValue != null && numValue > question.config!.maxValue!) {
          return "Max limit ${question.config!.maxValue}";
        }
        if (question.config!.minValue != null && numValue < question.config!.minValue!) {
          return "Min limit ${question.config!.minValue}";
        }
      }
    } catch (e) {
      return "Enter a valid number";
    }

    return null;
  }
}

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Allow only one '-' at the beginning
    if (text == '-') {
      return newValue;
    }

    // Allow only one '.' and '-' only at the beginning
    final newText = text.replaceAll(RegExp(r'[^0-9\.\-]'), '');
    final dotCount = newText.split('.').length - 1;
    final dashCount = newText.split('-').length - 1;

    if (dotCount > 1 ||
        dashCount > 1 ||
        (dashCount == 1 && !newText.startsWith('-'))) {
      return oldValue;
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
