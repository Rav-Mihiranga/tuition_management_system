import 'package:flutter/material.dart';
import 'upcoming_item.dart'; // make sure you create this too

class UpcomingSection extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      "icon": Icons.book,
      "title": "Math Class",
      "subtitle": "Today • 10:00 AM"
    },
    {
      "icon": Icons.science,
      "title": "Science Quiz",
      "subtitle": "Tomorrow • 11:30 AM"
    },
    {
      "icon": Icons.event,
      "title": "Parent Meeting",
      "subtitle": "Friday • 2:00 PM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Upcoming",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ...items.map((item) => UpcomingItem(
            icon: item["icon"],
            title: item["title"],
            subtitle: item["subtitle"],
          )),
        ],
      ),
    );
  }
}
