import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  bool isValidName(String name) {
    // Validate if the name contains only alphabets
    return RegExp(r'^[a-zA-Z]+$').hasMatch(name);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    // Validate if the phone number contains only digits and has a length of 10
    return RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ujudebug', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Login Form',
                textAlign: TextAlign.center,
                textScaleFactor: 2,
                style: TextStyle(color: Colors.teal),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Enter your name',
                  prefixIcon: const Icon(Icons.person, color: Colors.teal),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Enter your phone number',
                  prefixIcon: const Icon(Icons.contact_phone, color: Colors.teal),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: ElevatedButton(
                  onPressed: () {
                    // Get the input from the text fields
                    String name = nameController.text;
                    String phoneNumber = phoneNumberController.text;

                    // Validate the inputs
                    if (isValidName(name) && isValidPhoneNumber(phoneNumber)) {
                      // Navigate to the result page and pass the values
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            name: name,
                            phoneNumber: phoneNumber,
                          ),
                        ),
                      );
                    } else {
                      // Show an error message or handle the validation failure
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Validation Error'),
                            content: const Text(
                              'Please enter a valid name (alphabets only) and a 10-digit phone number (digits only).',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String name;
  final String phoneNumber;

  const ResultPage({
    Key? key,
    required this.name,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Page'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
              style: const TextStyle(color: Colors.teal),
            ),
            const SizedBox(height: 20),
            Text(
              'Phone Number: $phoneNumber',
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
              style: const TextStyle(color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
