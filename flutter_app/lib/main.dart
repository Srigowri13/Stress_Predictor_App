import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'form_page.dart';
import 'result_page.dart';
import 'map_page.dart';

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
        primarySwatch: Colors.pink,
      ),
      home: const LandingPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/form': (context) => const FormPage(),
        '/result': (context) => const ResultPage(stressLevel: 0, stressCategory: ''),
        '/map': (context) => const MapPage(),
      },
    );
  }
}
