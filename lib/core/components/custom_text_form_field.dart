import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.placeholder,
    required this.keyboardType,
    required this.inputAction,
    this.validate,
    this.enabled,
    this.textCapitalization,
    this.onKeyUp,
    this.fillFieldWithColour,
    this.filledFieldWColour,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
    this.borderSide,
    this.obscureText,
    this.onEditingComplete,
    this.onPressed,
  });

  final TextEditingController controller;
  final String? placeholder;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final FormFieldValidator<String>? validate;
  final bool? enabled, obscureText;
  final TextCapitalization? textCapitalization;
  final Function(String)? onKeyUp;
  final bool? fillFieldWithColour;
  final Color? filledFieldWColour;
  final Widget? prefixIcon, suffixIcon;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final VoidCallback? onEditingComplete, onPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      textInputAction: inputAction,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: fillFieldWithColour,
        fillColor: filledFieldWColour,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        hintText: placeholder,
        hintStyle: const TextStyle(color: kPlaceHolderTextColour),
        border: OutlineInputBorder(
          borderSide:
              borderSide ?? kLightBorderSide.copyWith(color: kPrimaryColour),
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      enabled: enabled,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      onChanged: onKeyUp,
      onEditingComplete: onEditingComplete,
    );
  }
}
