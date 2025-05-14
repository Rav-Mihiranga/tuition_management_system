import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentReg extends StatefulWidget {
  const StudentReg({super.key});

  @override
  State<StudentReg> createState() => _StudentRegState();
}

class _StudentRegState extends State<StudentReg> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Student Registration",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9C60AE),
                ),
              ),
              const SizedBox(height: 20),

              _buildTextField(controller: _fullNameController, label: "Full Name"),
              const SizedBox(height: 15),
              _buildTextField(controller: _emailController, label: "Email"),
              const SizedBox(height: 15),
              _buildTextField(controller: _phoneController, label: "Phone Number"),
              const SizedBox(height: 15),
              _buildTextField(controller: _usernameController, label: "Username"),
              const SizedBox(height: 15),
              _buildTextField(controller: _passwordController, label: "Password", isPassword: true),
              const SizedBox(height: 15),
              _buildTextField(controller: _confirmPasswordController, label: "Confirm Password", isPassword: true),
              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _registerStudent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF996BA7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
    );
  }

  // Helper method to build the text fields
  Widget _buildTextField({required TextEditingController controller, required String label, bool isPassword = false}) {
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

  // Method to handle student registration and send data to Firestore
  Future<void> _registerStudent() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      // Show error if passwords don't match
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      // Add the student data to Firestore
      await FirebaseFirestore.instance.collection('users').add({
        'full_name': _fullNameController.text,
        'email': _emailController.text,
        'phone_number': _phoneController.text,
        'username': _usernameController.text,
        'role': 'student', 
        'password': _passwordController.text, // In a real app, you should hash the password
      });

      // Optionally, show success message and clear fields
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration successful")));
      
      // Optionally, navigate to another screen after successful registration
      // Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}

