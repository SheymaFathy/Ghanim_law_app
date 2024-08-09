import 'package:flutter/material.dart';

import '../../../core/constants/styles.dart';

class CustomTextSignUpOrLogIn extends StatelessWidget {
  final String textone;
  final String texttwo;
  final void Function() onTap;
  const CustomTextSignUpOrLogIn(
      {super.key,
      required this.textone,
      required this.texttwo,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          textone == '' ? CrossAxisAlignment.end : CrossAxisAlignment.center,
      children: [
        if (textone != '')
          Text(
            textone,
            style: Styles.textStyle16.copyWith(fontSize: 13),
          ),
        InkWell(
          onTap: onTap,
          child: Text(texttwo,
              style: Styles.textStyle16.copyWith(
                  // color: AppColors.grey,
                  fontSize: 13)),
        ),
      ],
    );
  }
}
