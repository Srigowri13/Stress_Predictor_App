import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultPage extends StatefulWidget {
  final int stressLevel;
  final String stressCategory;

  const ResultPage({super.key, required this.stressLevel, required this.stressCategory});

  @override
  State<ResultPage> createState() => ResultPageState();
}

class ResultPageState extends State<ResultPage> {
  String _resultText = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.stressLevel < 4) {
        _fetchRandomThoughts();
      } else {
        Navigator.pushNamed(context, '/map'); // Navigate to MapPage to show nearby therapists
      }
    });
  }

  Future<void> _fetchRandomThoughts() async {
    final response = await http.get(Uri.parse('https://api.quotable.io/random'));

    if (response.statusCode == 200) {
  final data = json.decode(response.body);
  setState(() {
    _resultText = data['content'];
  });
} else {
  setState(() {
    _resultText = 'Failed to load random thoughts.';
  });
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stress Result'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: widget.stressLevel < 4 ? Colors.green : Colors.red,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Stress Level: ${widget.stressLevel}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Category: ${widget.stressCategory}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _resultText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
