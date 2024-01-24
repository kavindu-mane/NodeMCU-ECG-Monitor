import 'package:flutter/material.dart';
import 'package:heart/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart Rate Monitor',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
