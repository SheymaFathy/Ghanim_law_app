import 'package:flutter/material.dart';

TextDirection isRTL(String text) {
  if (text.contains(RegExp(r'[\u0600-\u06FF]'))) {
    return TextDirection.rtl;
  }
  return TextDirection.ltr; // Arabic characters range
}
