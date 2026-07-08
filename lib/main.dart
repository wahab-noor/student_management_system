import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/provider/student_provider.dart';
import 'package:student_management_system/views/splash_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StudentProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'StudentSphere',

      theme: ThemeData(
        primarySwatch: Colors.deepPurple,

        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
      ),

      home: const SplashScreen(),
    );
  }
}