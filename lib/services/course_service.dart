import 'package:cloud_firestore/cloud_firestore.dart';
class CourseService {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getFeaturedCourses() {
    return _firestore
        .collection('courses')
        .where('featured', isEqualTo: true)
        .snapshots();
  }
}
