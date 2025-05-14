import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // Ensure Firebase initialized
    Firebase.initializeApp();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      _showMessage('Please enter both username and password');
      return;
    }

    setState(() => _loading = true);
    try {
      // Query Firestore for matching user
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .where('role', isEqualTo: widget.role)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        _showMessage('No ${widget.role} found with that username');
      } else {
        final data = query.docs.first.data();
        final storedPassword = data['password'] as String;
        if (storedPassword == password) {
          // Successful login
          final docId = query.docs.first.id; 
          switch (widget.role) {
            case 'admin':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AdminDashboard()),
              );
              break;
            case 'student':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen(
                  studentId: docId,
                )),
              );
              break;
            case 'teacher':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const TeacherDash()),
              );
              break;
          }
        } else {
          _showMessage('Incorrect password');
        }
      }
    } catch (e) {
      _showMessage('Login failed: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF996BA7),
        title: const Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: isDesktop
            ? [IconButton(icon: const Icon(Icons.menu), onPressed: () {})]
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
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/user.jpg'),
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
                          child: Text('Username', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.credit_card),
                            hintText: 'NIC Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'At least 6 digits',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF996BA7)),
                            onPressed: _loading ? null : _login,
                            child: _loading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Don't have an account yet?", style: TextStyle(color: Colors.red)),
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