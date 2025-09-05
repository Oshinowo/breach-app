import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import 'custom_text.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.backgroundColour,
    required this.textColour,
    required this.text,
    this.onPressed,
    required this.borderColour,
    this.padding, this.enabled,
  });

  final Color backgroundColour, textColour, borderColour;
  final String text;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,

      style: TextButton.styleFrom(
        enableFeedback: enabled,
        foregroundColor: textColour,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        side: kLightBorderSide.copyWith(color: borderColour),
        backgroundColor: backgroundColour,
      ),
      child: CustomText(
        text: text,
        textSize: 14,
        fontWeight: FontWeight.w600,
        textColor: textColour,
      ),
    );
  }
}
