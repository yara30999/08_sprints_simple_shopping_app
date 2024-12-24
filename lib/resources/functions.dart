import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void changeLocale(BuildContext context) {
  context.locale == Locale('en', 'US')
      ? context.setLocale(Locale('ar', 'EG'))
      : context.setLocale(Locale('en', 'US'));
}

void showErrorSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}
