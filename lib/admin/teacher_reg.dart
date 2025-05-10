import 'package:flutter/material.dart';

class TeacherReg extends StatefulWidget {
  const TeacherReg({super.key});

  @override
  State<TeacherReg> createState() => _TeacherRegState();
}

class _TeacherRegState extends State<TeacherReg> {
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

                        _buildTextField(label: "Full Name"),
                        const SizedBox(height: 15),

                        _buildTextField(label: "Email"),
                        const SizedBox(height: 15),

                        _buildTextField(label: "Phone Number"),
                        const SizedBox(height: 15),

                        _buildTextField(label: "Address"),
                        const SizedBox(height: 15),

                        _buildTextField(label: "Username"),
                        const SizedBox(height: 15),

                        _buildTextField(label: "Password", isPassword: true),
                        const SizedBox(height: 15),

                        _buildTextField(label: "Confirm Password", isPassword: true),
                        const SizedBox(height: 25),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle registration
                            },
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
                            // Navigate back to login
                          },
                          child: const Text(
                            "Back to Login",
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
  
  Widget _buildTextField({required String label, bool isPassword = false}) {
    return TextField(
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
}