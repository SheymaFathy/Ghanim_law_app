import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "about us"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // App Logo
            Image.network(
              'https://ghanimlawfirm.laraeast.com/storage/4/logo.jpeg',
            ),
            const SizedBox(height: 20),

            const Text(
              'Get in Touch',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Row(
                  children: [
                    Icon(Icons.phone),
                    Text('+97450888700'),
                  ],
                ),
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    Text('+97444888700'),
                  ],
                ),
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Row(
                  children: [
                    Icon(Icons.email),
                    Text('info@ghanimlawfirm.com'),
                  ],
                ),
              ),
            ),
            Card(
              child: Row(
                children: [
                  Icon(Icons.email),
                  Text('support@ghanimlawfirm.com'),
                ],
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                    'Address: Head OfficeAl Nasr Tower 2, 1st Floor Office Number 103, West Bay Doha, Qatar'),
              ),
            ),

            const Spacer(),
            const Text(
              'Follow us on social media',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () => launchUrl(Uri.parse('https://twitter.com')),
                ),
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () => launchUrl(Uri.parse('https://twitter.com')),
                ),
                IconButton(
                  icon: const Icon(Icons.snapchat),
                  onPressed: () => launchUrl(Uri.parse('https://twitter.com')),
                ),
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () => launchUrl(Uri.parse('https://twitter.com')),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Ghanim Law Firm',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Copyright © 2024 Ghanim Law Firm All rights reserved.',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
