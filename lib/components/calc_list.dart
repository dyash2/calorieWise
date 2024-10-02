import 'package:flutter/material.dart';

class CalcuList extends StatelessWidget {
  final String title;
  final IconData appIcon;
  final Color backgroundColor;
  final String? subtitle;
  final Widget
      destinationPage; // Added to hold the destination page for navigation

  const CalcuList({
    super.key,
    required this.title,
    required this.appIcon,
    required this.backgroundColor,
    this.subtitle,
    required this.destinationPage, // Accept the destination page as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  destinationPage), 
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(appIcon, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: const TextStyle(fontSize: 14),
              ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
