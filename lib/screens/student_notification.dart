import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentNotificationsPage extends StatelessWidget {
  final String studentId;

  const StudentNotificationsPage({super.key, required this.studentId});

  Stream<QuerySnapshot> _notificationsStream() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('type', whereIn: ['broadcast', 'specific'])
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notifications'),
        backgroundColor: const Color(0xFF996BA7),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _notificationsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Print error to debug console
            print('Firebase error: ${snapshot.error}');

            // Display error to user
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 40),
                  const SizedBox(height: 10),
                  const Text('Failed to load notifications.'),
                  const SizedBox(height: 5),
                  Text(
                    '${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            );
          }

          final notifications = snapshot.data?.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['type'] == 'broadcast' || data['recipientId'] == studentId;
          }).toList();

          if (notifications == null || notifications.isEmpty) {
            return const Center(child: Text('No notifications found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index].data() as Map<String, dynamic>;
              final timestamp = notification['timestamp'] as Timestamp?;
              final date = timestamp?.toDate();

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Icon(
                    notification['type'] == 'broadcast' ? Icons.public : Icons.person,
                    color: notification['type'] == 'broadcast' ? Colors.blue : Colors.green,
                  ),
                  title: Text(notification['message'] ?? 'No message'),
                  subtitle: Text(
                    notification['type'] == 'broadcast'
                        ? 'Broadcast'
                        : 'Private message',
                  ),
                  trailing: Text(
                    date != null ? '${date.day}/${date.month}/${date.year}' : '',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

