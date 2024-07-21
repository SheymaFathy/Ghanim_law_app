import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "about us"),
      body: const Text("About Us"),
    );
  }
}
