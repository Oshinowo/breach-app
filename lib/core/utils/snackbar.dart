import 'package:flutter/material.dart';

import '../components/custom_text.dart';

void displaySnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: CustomText(text: message, textSize: 14)));
}
