import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/app_constants.dart';

class CustomStreamCard extends StatelessWidget {
  const CustomStreamCard({
    super.key,
    required this.title,
    required this.excerpt,
    required this.author,
    required this.date,
    this.onPressed,
  });

  final String title, excerpt, author, date;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomText(text: title, textSize: 16, fontWeight: FontWeight.w700),
          SizedBox(height: 4),
          CustomText(text: excerpt, textSize: 13, textColor: kGreyTextColour),
          SizedBox(height: 12),
          Row(
            children: [
              CustomText(
                text: author,
                textSize: 12,
                // textColor: kGreyTextColour,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 12),
              CustomText(text: date, textSize: 12, textColor: kGreyTextColour),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
