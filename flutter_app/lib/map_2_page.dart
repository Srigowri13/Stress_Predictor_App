import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Therapists Near You'),
        backgroundColor: const Color(0xFF652165),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: ListTile(
                  onTap: () async {
                    final uri =
                        Uri.parse('https://maps.app.goo.gl/XmKjyKj3m7VgLeWVA');
                    if (!await launchUrl(uri)) {
                      print('Error launching url');
                    }
                  },
                  title: const Text(
                      'Shree Sanjeevini Psychiatric Rehabilitation Centre'),
                  trailing: const Icon(Icons.directions),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: ListTile(
                  onTap: () async {
                    final uri =
                        Uri.parse('https://maps.app.goo.gl/p16FTbVF1DQCtuau9');
                    if (!await launchUrl(uri)) {
                      print('Error launching url');
                    }
                  },
                  title: const Text(
                      'Saantvana-A Center For Enhancing Pychological Wellbeing'),
                  trailing: const Icon(Icons.directions),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: ListTile(
                  onTap: () async {
                    final uri =
                        Uri.parse('https://maps.app.goo.gl/CaawiDHkD8pDr5YK6');
                    if (!await launchUrl(uri)) {
                      print('Error launching url');
                    }
                  },
                  title: const Text(
                      'Santrupti Family and Children Counselling and Health Clinic'),
                  trailing: const Icon(Icons.directions),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: ListTile(
                  onTap: () async {
                    final uri =
                        Uri.parse('https://jsdl.in/DT-44FKZCKT67W');
                    if (!await launchUrl(uri)) {
                      print('Error launching url');
                    }
                  },
                  title: const Text('Dr Sudharani Naik Psychiatrist'),
                  trailing: const Icon(Icons.directions),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
