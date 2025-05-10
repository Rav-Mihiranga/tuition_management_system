import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DocumentsPage(),
    );
  }
}

class DocumentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documents'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          DocumentCard(
            name: 'Priyantha Gunawardhana',
            subject: 'Physics',
            lesson: 'Lesson 1',
          ),
          SizedBox(height: 16.0),
          DocumentCard(
            name: 'Harshani Dessanayake',
            subject: 'Bio',
            lesson: 'Lesson 2',
          ),
        ],
      ),
    );
  }
}

class DocumentCard extends StatelessWidget {
  final String name;
  final String subject;
  final String lesson;

  DocumentCard({required this.name, required this.subject, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_placeholder.png'), // Replace with actual image asset
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(subject),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(lesson, style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 16.0),
            Center(
              child: Column(
                children: [
                  Icon(Icons.picture_as_pdf, size: 50.0, color: Colors.red),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle download button press
                    },
                    child: Text('Download'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
