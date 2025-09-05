import 'package:flutter/material.dart';

const kDefaultSize = 20.0;
const kPrimaryColour = Color(0XFF8311F9);
const kSecondaryColour = Color(0XFF6215F2);
const kGreyTextColour = Color(0XFF6A6A6A);
const kSecondGreyTextColour = Color(0XFF5D5D5D);
const kThirdGreyTextColour = Color(0XFFE7E7E7);
const kPlaceHolderTextColour = Color(0XFFD1D1D1);

const kAppBorderPadding = EdgeInsets.symmetric(
  horizontal: kDefaultSize - 5,
  vertical: kDefaultSize / 2,
);

const kLoadingIndicatorWithColor = CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColour),
);

const kDropdownFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 8.0),
  hintText: 'Select data',
);

const kLightBorderSide = BorderSide(width: 1.0, color: Color(0XFFD0D5DD));

