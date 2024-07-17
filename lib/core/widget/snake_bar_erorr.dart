import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

snackBarErorr(String erorrMessage, String erorrAnyse) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: erorrAnyse,
        message: erorrMessage,
        contentType: ContentType.failure,
      ),
    );
