import 'package:flutter/material.dart';
import 'package:memify/view/mainScreen.dart';
import 'package:memify/view/splashScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

bool showSplash = true;
  
showSplashScreen() {
  
  Future.delayed(const Duration(seconds: 5), () {
    setState(() {
      showSplash = false;
    });
  });
}

  @override
  void initState() {
    showSplashScreen();
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memify',
      home: showSplash ? SplashScreen() : MainScreen(),
    );
  }
}
