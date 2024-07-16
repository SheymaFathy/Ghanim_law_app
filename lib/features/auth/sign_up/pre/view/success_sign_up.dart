import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SuccessSignUpSnackBar extends StatelessWidget {
  const SuccessSignUpSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child:  const Text('Show Error SnackBar'),
              onPressed: () {

                // for error
                final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'رسالة خطأ',
                    message:
                    'خطأ في تسجيل الدخول حاول مرة اخرى !',
                    contentType: ContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);

              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Show success Material Banner'),

              // for success sign up
              onPressed: () {
                final materialBanner = MaterialBanner(

                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  forceActionsBelow: true,
                  content: AwesomeSnackbarContent(
                    title: 'مبروك',
                    message:
                    'تم انشاء الحساب بنجاح',
                    contentType: ContentType.success,
                    inMaterialBanner: true,
                  ),
                  actions: const [SizedBox.shrink()],
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showMaterialBanner(materialBanner);
              },
            ),
          ],
        ),
      ),
    );
  }
}
