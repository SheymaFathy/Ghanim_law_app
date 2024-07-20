import 'package:flutter/material.dart';

customSnackBarWidget(String erorrMessage, Color backgroundColor) => SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: backgroundColor,
    content: Text(erorrMessage));
