import 'package:flutter/material.dart';
import 'package:flutter_app/map_2_page.dart';
import 'package:flutter_app/map_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatefulWidget {
  final int stressLevel;
  final String stressCategory;

  const ResultPage(
      {Key? key, required this.stressLevel, required this.stressCategory})
      : super(key: key);

  @override
  State<ResultPage> createState() => ResultPageState();
}

class ResultPageState extends State<ResultPage> {
  String _resultText = '';

  @override
  void initState() {
    super.initState();
    if (widget.stressLevel < 4) {
      _fetchRandomThoughts();
    }
  }

  Future<void> _fetchRandomThoughts() async {
    final response =
        await http.get(Uri.parse('https://api.quotable.io/random'));

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
        backgroundColor: widget.stressLevel < 4
            ? const Color.fromARGB(255, 142, 224, 144)
            : const Color.fromRGBO(255, 135, 126, 1),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: widget.stressLevel < 4
              ? const Color.fromARGB(255, 142, 224, 144)
              : const Color.fromRGBO(255, 135, 126, 1),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Stress Level: ${widget.stressLevel}',
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Category: ${widget.stressCategory}',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              if (_resultText.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      _resultText,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              if (widget.stressLevel >= 4)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewMapScreen(),
                      ));
                    },
                    label: const Text('Visit Nearest Therapist'),
                    icon: const Icon(Icons.local_hospital),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
