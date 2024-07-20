import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

AppBar myAppBar(BuildContext context, String title, {Widget? actionWidget}) {
  return AppBar(
    backgroundColor: AppColors.backgroundColor,
    elevation: 0.0,
    actions: actionWidget != null ? [actionWidget] : null,
    foregroundColor: Colors.black,
    title: Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: AppColors.grey, fontSize: 15),
    ),
    centerTitle: true,
  );
}
