import 'package:flutter/material.dart';

class Teachers extends StatefulWidget {
  const Teachers({super.key});

  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  final List<Map<String, String>> teachers = [
    {'name': 'Priyantha Gunawardhana', 'subject': 'Physics', 'image': 'assets/images/physicste.jpg'},
    {'name': 'Kelum Alwis', 'subject': 'Maths', 'image': 'assets/images/maths.jpg'},
    {'name': 'Vindya Ekanayake', 'subject': 'Chemistry', 'image': 'assets/images/chemistry.jpg'},
    {'name': 'Dayal Withanage', 'subject': 'ICT', 'image': 'assets/images/ICT.jpg'},
    {'name': 'Prasad Siriwardhana', 'subject': 'ICT', 'image': 'assets/images/teacher5.png'},
    {'name': 'Harshani Dessanayake', 'subject': 'Bio', 'image': 'assets/images/teacher6.png'},
    {'name': 'Devinda Viswajith', 'subject': 'English', 'image': 'assets/images/teacher7.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // ✅ Handle back button to pop the screen
          },
        ),
      ),
      body: ListView.builder(
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(teachers[index]['image']!),
            ),
            title: Text(teachers[index]['name']!),
            subtitle: Text(teachers[index]['subject']!),
          );
        },
      ),
    );
  }
}
