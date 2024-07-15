import 'package:flutter/material.dart';

import '../../../core/constants/image_assets.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        AppImageAsset.logo,
        width: double.infinity,
        height: 100,
      ),
    );
  }
}
