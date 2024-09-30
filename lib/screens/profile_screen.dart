import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'nutrition_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final num weight;
  final num height;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.weight,
    required this.height,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String selectedGender = 'Male';
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    weightController.text = widget.weight.toString();
    heightController.text = widget.height.toString();
  }

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setDouble('weight', double.parse(weightController.text));
    await prefs.setDouble('height', double.parse(heightController.text));
    await prefs.setString('gender', selectedGender);
  }

  void navigateToNutrition() async {
    await _saveProfileData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NutritionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Gender', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: genderOptions.map((String gender) {
                    return Row(
                      children: [
                        Radio(
                          value: gender,
                          groupValue: selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                        Text(gender),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Height (cm)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: navigateToNutrition,
                  child: const Text('Submit and Go to Nutrition'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
