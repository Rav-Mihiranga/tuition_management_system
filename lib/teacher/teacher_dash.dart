import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  // For Firestore and QuerySnapshot
import 'package:tuition_management_system/components/bottom_nav_bar.dart';
// import 'package:mobile_e_learning_app/components/course_card.dart';  // Make sure to import your CourseCard widget
import 'package:tuition_management_system/components/top_header.dart';
import '../components/teacher_feature_icons_row.dart';

import 'package:tuition_management_system/components/upcoming_section.dart';
// import 'package:mobile_e_learning_app/services/course_service.dart';  // Import CourseService

class TeacherDash extends StatefulWidget {
  const TeacherDash({super.key});

  @override
  State<TeacherDash> createState() => _TeacherDashState();
}

class _TeacherDashState extends State<TeacherDash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final CourseService courseService = CourseService();  // kept for future use

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Harshani Dissanayake', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: const Text('HarshaniDissanayake@gmail.com'),
              currentAccountPicture: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('My Courses'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Notifications'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // handle logout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Logout', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),  // Assuming BottomNavBar is defined elsewhere
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(
                onMenuPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
              TeacherFeatureIconsRow(),  // Corrected by calling the widget with parentheses
              UpcomingSection(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class TeacherFeatureIconsRow extends StatelessWidget {
  // final CourseService courseService = CourseService();  // Keep for future use

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured Courses',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          // StreamBuilder<QuerySnapshot>(
            // stream: courseService.getFeaturedCourses(),  // Ensure this function is returning the correct stream
            // builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const Center(child: CircularProgressIndicator());
              // }
              // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              //   return const Center(child: Text('No featured courses available.'));
              // }

              // final courses = snapshot.data!.docs;

              // return Column(
              //   children: courses.map((course) {
              //     return CourseCard(  // Assuming you have a CourseCard widget defined
              //       title: course['title'],
              //       author: course['teacher'],
              //       imageUrl: course['imageUrl'],
              //       color: Colors.blue[100]!, // Customize the color or make it dynamic
              //     );
              //   }).toList(),
              // );
            // },
          // ),
        ],
      ),
    );
  }
}
