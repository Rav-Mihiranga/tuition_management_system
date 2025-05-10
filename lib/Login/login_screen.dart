import 'package:flutter/material.dart';
import 'package:tuition_management_system/admin/admin_dashboard.dart';
import 'package:tuition_management_system/screens/home_screen.dart';
import 'package:tuition_management_system/teacher/teacher_dash.dart';

class LoginScreen extends StatefulWidget {
  final String role;
  const LoginScreen({required this.role, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  @override
  Widget build(BuildContext context) {
    
    final isDesktop = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF996BA7),
        title: const Text('Login',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        centerTitle: true,
        actions: isDesktop
            ? [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ]
            : null,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 400 : double.infinity),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/user.jpg'), // Replace with your own asset
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Username',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.credit_card),
                            hintText: 'NIC Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'At least 6 digits',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF996BA7),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            if(widget.role=="admin"){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminDashboard()));
                            }
                            else if(widget.role=="student"){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            }
                            else if(widget.role=="teacher"){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherDash()));
                            }
                          },
                          child: const Text('Login', style: TextStyle(fontSize: 18 , color: Color.fromARGB(255, 251, 251, 251) )),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {

                          },
                          child: const Text(
                            "Don't have an account yet?",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}