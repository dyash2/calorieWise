import 'dart:ui';
import 'package:calorie_wise/calculators/nutrition_tracker.dart';
import 'package:calorie_wise/components/custom_button.dart';
import 'package:flutter/material.dart';
import '../components/exit_dialog.dart';
import 'calculators_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show the confirmation dialog when the user tries to quit
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => const ExitConfirmationDialog(),
        );
        return shouldExit ?? false; // Return true to exit, false to stay
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            actions: [],
            backgroundColor: Colors.transparent,
          ),
          body: Column(children: [
            Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    // Background image
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/running_person.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(100))),
                    ),
                    // Glassy purple container
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(100)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.purple.shade500.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(100)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Positioned text at bottom-left
                    const Positioned(
                      bottom: 20, // Adjusts the distance from bottom
                      left: 20, // Adjusts the distance from left
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          '''Eat
Good,
Live
Healthy,
Feel 
Great!''',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                )),
            // Button Section
            CustomButton(
              text: "START",
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CalculatorsScreen()));
              },
            )
          ])),
    );
  }
}
