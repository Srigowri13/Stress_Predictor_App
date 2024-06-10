import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'form_page.dart';
import 'result_page.dart';
import 'map_page.dart'; // Import the new Map page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind Metrics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(),
      routes: {
        '/form': (context) => const FormPage(),
        '/result': (context) => const ResultPage(stressLevel: 0, stressCategory: ''),
        '/map': (context) => const MapPage(), // Add the Map page route
      },
    );
  }
}
