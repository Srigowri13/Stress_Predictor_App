import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'result_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _q1 = 1; // Sleep Quality
  int _q2 = 1; // Headaches
  int _q3 = 1; // Academic Performance
  int _q4 = 1; // Study Load
  int _q5 = 1; // Extracurricular Activities

Future<void> _submitForm() async {
  if (_formKey.currentState!.validate()) {
    final Map<String, dynamic> formData = {
      'q1': _q1,
      'q2': _q2,
      'q3': _q3,
      'q4': _q4,
      'q5': _q5,
    };
      print('0');
    final String jsonData = jsonEncode(formData);

    try {
      final response = await http.post(
        Uri.parse('https://heroic-falcon-prompt.ngrok-free.app/predict'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );
      if (mounted) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> result = jsonDecode(response.body);
          final int stressLevel = result['stress_level'];
          final String stressCategory = result['stress_category'];
          print('3');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                stressLevel: stressLevel,
                stressCategory: stressCategory,
              ),
            ),
          );
        } else {
          throw Exception('Failed to load data');
        }
      }
    } catch (e) {
      //
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE6E6),
        title: Text(
          'Mind Metrics',
          style: GoogleFonts.nunito(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF652165),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFFFE6E6),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'Please rate each factor on a scale from 1 to 5:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Sleep Quality',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      value: _q1,
                      onChanged: (int? newValue) {
                        setState(() {
                          _q1 = newValue!;
                        });
                      },
                      items: List.generate(5, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value <= 0) {
                          return 'Please select a value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Headaches',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      value: _q2,
                      onChanged: (int? newValue) {
                        setState(() {
                          _q2 = newValue!;
                        });
                      },
                      items: List.generate(5, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value <= 0) {
                          return 'Please select a value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Academic Performance',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      value: _q3,
                      onChanged: (int? newValue) {
                        setState(() {
                          _q3 = newValue!;
                        });
                      },
                      items: List.generate(5, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value <= 0) {
                          return 'Please select a value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Study Load',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      value: _q4,
                      onChanged: (int? newValue) {
                        setState(() {
                          _q4 = newValue!;
                        });
                      },
                      items: List.generate(5, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value <= 0) {
                          return 'Please select a value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height:10),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Extracurricular Activities',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      value: _q5,
                      onChanged: (int? newValue) {
                        setState(() {
                          _q5 = newValue!;
                        });
                      },
                      items: List.generate(5, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value <= 0) {
                          return 'Please select a value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                        backgroundColor: const Color(0xFF652165),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

