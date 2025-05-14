import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeacherReg extends StatefulWidget {
  const TeacherReg({super.key});

  @override
  State<TeacherReg> createState() => _TeacherRegState();
}

class _TeacherRegState extends State<TeacherReg> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 700;
          return Row(
            children: [
              if (isDesktop)
                Expanded(
                  child: Container(
                    color: Colors.blue[100],
                    child: Center(
                      child: Image.asset(
                        'assets/register.png', // Your registration illustration here
                        height: 300,
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: 2,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9C60AE),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                            controller: _fullNameController,
                            label: "Full Name"),
                        const SizedBox(height: 15),
                        _buildTextField(
                            controller: _emailController, label: "Email"),
                        const SizedBox(height: 15),
                        _buildTextField(
                            controller: _phoneController,
                            label: "Phone Number"),
                        const SizedBox(height: 15),
                        _buildTextField(
                            controller: _addressController, label: "Address"),
                        const SizedBox(height: 15),
                        _buildTextField(
                            controller: _usernameController, label: "Username"),
                        const SizedBox(height: 15),
                        _buildTextField(
                            controller: _passwordController,
                            label: "Password",
                            isPassword: true),
                        const SizedBox(height: 15),
                        _buildTextField(
                            controller: _confirmPasswordController,
                            label: "Confirm Password",
                            isPassword: true),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _registerUser();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF996BA7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Register",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back",
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Method to register user and send data to Firestore
  Future<void> _registerUser() async {
    // Validate form fields if necessary
    if (_passwordController.text != _confirmPasswordController.text) {
      // Show error if passwords don't match
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords do not match")));
      return;
    }

    // Create a user document in Firestore
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'full_name': _fullNameController.text,
        'email': _emailController.text,
        'phone_number': _phoneController.text,
        'address': _addressController.text,
        'username': _usernameController.text,
        'role': 'teacher',
        'password':
            _passwordController.text, // Note: Password is not encrypted here
      });

      // Optionally navigate to another page, like a success screen
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Registration successful")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}
