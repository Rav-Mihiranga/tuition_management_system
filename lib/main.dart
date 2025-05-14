import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tuition_management_system/Login/before_login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <-- important!
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // <-- wait for Firebase ready
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BeforeLogin(),
    );
  }
}