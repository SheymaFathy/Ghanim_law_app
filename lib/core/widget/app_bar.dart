import 'package:flutter/material.dart';

AppBar myAppBar(BuildContext context, String title, {Widget? actionWidget}) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.surface,
    elevation: 0.0,
    actions: actionWidget != null ? [actionWidget] : null,
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 15),
    ),
    centerTitle: true,
  );
}
