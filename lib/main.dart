import 'package:flutter/material.dart';
import 'package:heart/common/splash_screen.dart';
import 'package:heart/common/utils.dart';
import 'package:heart/screens/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart Rate Monitor',
      navigatorKey: navigatorKey,
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (context) => const SplashScreen(
              child: Dashboard(),
            ),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
