import 'package:flutter/material.dart';

class TeacherFeatureIconsRow extends StatelessWidget {
  final List<Map<String, dynamic>> features = [
    {
      "icon": Icons.menu_book_rounded,
      "label": "Upload Lessons",
      "gradient": LinearGradient(colors: [Colors.purple, Colors.deepPurple]),
    },
    {
      "icon": Icons.person_rounded,
      "label": "Attendance",
      "gradient": LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
    },
    {
      "icon": Icons.article_rounded,
      "label": "Exams",
      "gradient": LinearGradient(colors: [Colors.green, Colors.teal]),
    },
    {
      "icon": Icons.account_circle_rounded,
      "label": "Profile",
      "gradient": LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent]),
    },
  ];

  TeacherFeatureIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: features.map((item) {
          return Column(
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  gradient: item["gradient"], // Use gradient!
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    item["icon"],
                    color: Colors.white,
                    size: 34,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                item["label"],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
