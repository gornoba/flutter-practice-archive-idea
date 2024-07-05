import 'package:business_card/screen/main/main-screen.dart';
import 'package:business_card/screen/splash/splach-screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Archive Idea',
      debugShowCheckedModeBanner: false, // Remove Debug Banner,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}
