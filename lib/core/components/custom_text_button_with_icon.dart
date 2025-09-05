import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import 'custom_text.dart';

class CustomTextButtonWithIcon extends StatelessWidget {
  const CustomTextButtonWithIcon({
    super.key,
    required this.label,
    required this.buttonBackgroundColour,
    required this.buttonForegroundColour,
    this.textColour,
    required this.buttonIcon,
    required this.onPressed,
    this.borderColour,
  });

  final String label;
  final Color buttonBackgroundColour, buttonForegroundColour;
  final Color? textColour, borderColour;
  final Widget buttonIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: buttonBackgroundColour,
        foregroundColor: buttonForegroundColour,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        side: kLightBorderSide.copyWith(color: borderColour),
        // padding: const EdgeInsets.symmetric(vertical: 18,horizontal: ),
      ),
      onPressed: onPressed,
      icon: buttonIcon,
      label: CustomText(
        text: label,
        textSize: 16,
        fontWeight: FontWeight.w600,
        textColor: textColour ?? Colors.white,
      ),
    );
  }
}
