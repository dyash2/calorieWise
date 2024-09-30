import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String weight = '';
  String height = '';
  String gender = '';

  // Function to navigate to ProfileScreen and get data back
  void _navigateToProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      ),
    );

    // Check if result is not null and update state
    if (result != null) {
      setState(() {
        name = result['name'];
        weight = result['weight'];
        height = result['height'];
        gender = result['gender'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _navigateToProfile, // Navigate to profile screen
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Details:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Name: $name'),
            Text('Weight: $weight kg'),
            Text('Height: $height cm'),
            Text('Gender: $gender'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToProfile, // Navigate to profile screen
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Controllers to get the text field inputs
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  // Variable to hold selected gender value
  String selectedGender = 'Male';

  // List of gender options
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Weight field
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Height field
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Gender Dropdown
              DropdownButtonFormField<String>(
                value: selectedGender,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: genderOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),

              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Retrieve data from controllers
                    String name = nameController.text;
                    String weight = weightController.text;
                    String height = heightController.text;
                    String gender = selectedGender;

                    // Return data to the HomeScreen
                    Navigator.pop(context, {
                      'name': name,
                      'weight': weight,
                      'height': height,
                      'gender': gender,
                    });
                  },
                  child: Text('Save Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}