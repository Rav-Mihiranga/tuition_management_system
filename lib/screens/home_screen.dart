import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/top_header.dart';
import '../components/feature_icons_row.dart';
import '../components/course_card.dart';
import '../components/bottom_nav_bar.dart';
import '../components/upcoming_section.dart';
import '../services/course_service.dart';



class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CourseService courseService = CourseService(); // <-- added

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              // decoration: BoxDecoration(
              //   color: Colors.blueAccent,
              // ),
              accountName: Text('Achini Perera', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text('Achiniperera@gmail.com'),
              currentAccountPicture:CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/images/profile.jpg"),
                        ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('My Courses'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Notifications'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text('Logout', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(onMenuPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              }),
              FeatureIconsRow(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text('Featured Courses', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: courseService.getFeaturedCourses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No featured courses available.'));
                  }

                  final courses = snapshot.data!.docs;

                  return Column(
                    children: courses.map((course) {
                      return CourseCard(
                        title: course['title'],
                        author: course['teacher'],
                        imageUrl: course['imageUrl'],
                        color: Colors.blue[100]!, // randomize later maybe
                      );
                    }).toList(),
                  );
                },
              ),
              UpcomingSection(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}