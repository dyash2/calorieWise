import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text; // Required
  final Color backgroundColor; // Required
  final VoidCallback? onPressed; // Optional
  final double widthFactor;
  final double height;
  final double borderRadius;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.text, // Required text
    required this.backgroundColor, // Required background color
    required this.onPressed,
    this.widthFactor = 0.6, 
    this.height = 50.0,
    this.borderRadius = 30.0,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * widthFactor,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: textColor,
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text.toUpperCase(),
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
