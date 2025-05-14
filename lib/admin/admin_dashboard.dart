import 'package:flutter/material.dart';
import 'package:tuition_management_system/admin/payment.dart';
import 'package:tuition_management_system/admin/student_reg.dart';
import 'package:tuition_management_system/admin/teacher_reg.dart';
import 'package:tuition_management_system/teacher/teachers.dart';
import 'package:tuition_management_system/admin/admin_notification.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9C60AE),
      flexibleSpace: Center(
  child: Padding(
    padding: const EdgeInsets.only(top:60), // Adjust the value as needed
    child: Align(
      alignment: Alignment.topCenter, // Aligns the text to the top center
      child: Text(
        'Admin Dashboard',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  ),
),

      ),

      body: SingleChildScrollView(
        // Enables scrolling
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Top Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _dashboardTile(Icons.person, 'Students'),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Teachers(),
                        ),
                      );
                    },
                    child: _dashboardTile(Icons.school, 'Teachers'),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Payment()),
                      );
                    },
                    child: _dashboardTile(Icons.payment, 'Payments'),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Background Image Container
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/dashboard.png',
                    ), // Make sure this image exists in your assets folder
                    fit:
                        BoxFit
                            .cover, // Ensures the image covers the entire container
                  ),
                ),
                alignment: Alignment.center,
              ),

              SizedBox(height: 20),

              // Statistics Section
              _statBox('Number of Students', '2000', Colors.red),
              SizedBox(height: 10),
              _statBox(
                'Number of Teachers',
                '20',
                const Color.from(alpha: 1, red: 0.027, green: 0.055, blue: 0.447),
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TeacherReg()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF996BA7),
                        borderRadius: BorderRadius.circular(
                          70,
                        ),
                      ),
                      height:
                          80, 
                      width: 170, 
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center, 
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ), 
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Register Teacher",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ), 
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                    GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentReg()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF996BA7),
                        borderRadius: BorderRadius.circular(
                          70,
                        ),
                      ),
                      height:
                          80, 
                      width: 170, 
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center, 
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ), 
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Register Student",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ), 
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminNotificationPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF996BA7),
                        borderRadius: BorderRadius.circular(
                          70,
                        ),
                      ),
                      height:
                          80, 
                      width: 170, 
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center, 
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ), 
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Send Notification",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ), 
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dashboardTile(IconData icon, String label) {
    return Column(children: [Icon(icon, size: 50), Text(label)]);
  }

  Widget _statBox(String label, String count, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      color: color,
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontSize: 18)),
          Text(count, style: TextStyle(color: Colors.white, fontSize: 24)),
        ],
      ),
    );
  }

}
