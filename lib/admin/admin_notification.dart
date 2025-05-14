import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminNotificationPage extends StatefulWidget {
  const AdminNotificationPage({super.key});

  @override
  State<AdminNotificationPage> createState() => _AdminNotificationPageState();
}

class _AdminNotificationPageState extends State<AdminNotificationPage> {
  final TextEditingController _messageController = TextEditingController();
  String _notificationType = 'broadcast'; // or 'specific'
  String? _selectedStudentId;
  bool _loading = false;
  List<Map<String, dynamic>> _students = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    try {
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'student')
          .get();

      setState(() {
        _students = query.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
      });
    } catch (e) {
      _showMessage('Failed to load students: $e');
    }
  }

  Future<void> _sendNotification() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      _showMessage('Please enter a message.');
      return;
    }

    if (_notificationType == 'specific' && _selectedStudentId == null) {
      _showMessage('Please select a student.');
      return;
    }

    setState(() => _loading = true);

    try {
      await FirebaseFirestore.instance.collection('notifications').add({
        'message': message,
        'type': _notificationType,
        'timestamp': FieldValue.serverTimestamp(),
        'recipientId': _notificationType == 'specific' ? _selectedStudentId : null,
      });

      _messageController.clear();
      setState(() => _selectedStudentId = null);
      _showMessage('Notification sent successfully');
    } catch (e) {
      _showMessage('Failed to send notification: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification'),
        backgroundColor: const Color(0xFF996BA7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Notification Type:', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio(
                  value: 'broadcast',
                  groupValue: _notificationType,
                  onChanged: (value) {
                    setState(() => _notificationType = value!);
                  },
                ),
                const Text('Broadcast'),
                Radio(
                  value: 'specific',
                  groupValue: _notificationType,
                  onChanged: (value) {
                    setState(() => _notificationType = value!);
                  },
                ),
                const Text('Specific Student'),
              ],
            ),
            if (_notificationType == 'specific')
              DropdownButtonFormField<String>(
                value: _selectedStudentId,
                decoration: const InputDecoration(labelText: 'Select Student'),
                items: _students.map<DropdownMenuItem<String>>((student) {
                  return DropdownMenuItem<String>(
                    value: student['id'] as String,
                    child: Text(student['username'] ?? 'Unknown'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedStudentId = value);
                },
              ),
            const SizedBox(height: 16),
            TextField(
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Message',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _loading ? null : _sendNotification,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF996BA7)),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Send', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
