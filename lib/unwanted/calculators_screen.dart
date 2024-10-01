// import 'dart:ui';
// import 'package:calorie_wise/calculators/calorie_tracker.dart';
// import 'package:flutter/material.dart';

// import '../views/calc_list.dart';

// class CalcListScreen extends StatelessWidget {
//   const CalcListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         actions: [],
//         backgroundColor: Colors.transparent,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/8312.jpg"),
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(100),
//                     ),
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       bottomRight: Radius.circular(100),
//                     ),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.purple.shade500.withOpacity(0.3),
//                           borderRadius: const BorderRadius.only(
//                             bottomRight: Radius.circular(100),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const Positioned(
//                   bottom: 25,
//                   left: 20,
//                   child: Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Text(
//                       '''Calculators
// Selection''',
//                       style: TextStyle(
//                         fontFamily: 'OpenSans',
//                         fontSize: 40,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Button Section
//           Expanded(
//             flex: 3,
//             child: ListView(
//               children: [
//                 CalcuList(
//                   title: "Calorie Tracker",
//                   appIcon: Icons.fastfood,
//                   backgroundColor: Colors.greenAccent,
//                   subtitle: "Log Your Daily Caloric Intake",
//                   destinationPage:
//                       CalorieTracker(), // Replace with your actual page
//                 ),
//                 CalcuList(
//                   title: "Weight Monitor",
//                   appIcon: Icons.monitor_weight,
//                   backgroundColor: Colors.blueAccent,
//                   subtitle: "Set and Track Your Weight Goals",
//                   destinationPage:
//                       CalorieTracker(), // Replace with your actual page
//                 ),
//                 CalcuList(
//                   title: "Nutrition Log",
//                   appIcon: Icons.local_dining,
//                   backgroundColor: Colors.orangeAccent,
//                   subtitle: "Track Your Nutritional Intake",
//                   destinationPage:
//                       CalorieTracker(), // Replace with your actual page
//                 ),
//                 Text("More Coming Soon")
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

