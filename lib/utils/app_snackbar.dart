import 'package:flutter/material.dart';

class AppSnackbar {
  static showSnackbar({required BuildContext context, required String title, required Color bgColor, int duration = 2}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title), duration: Duration(seconds: duration), backgroundColor: bgColor));
}
