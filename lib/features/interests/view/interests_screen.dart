import 'dart:convert';

import '../../../core/services/networking/user_api.dart';
import '../../../core/services/secure_storage/secure_storage.dart';
import '../../../core/utils/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/components/custom_text_button.dart';
import '../../../core/components/custom_text_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/components/custom_text.dart';
import '../../blog/viewmodel/categories_provider.dart';
import '../../dashboard/view/dashboard_screen.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  static const String id = "/interest_screen";

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  bool _isLoading = false;
  final List<dynamic> _selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    final storedCategories = context.watch<Categories>().items;
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: _isLoading,
          progressIndicator: kLoadingIndicatorWithColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: BackButton(onPressed: () => context.pop()),
              ),
              Expanded(
                child: Padding(
                  padding: kAppBorderPadding,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/svg/breach-logo.svg"),
                        SizedBox(height: kDefaultSize * 3),
                        Image.asset(
                          "assets/images/circle-bby.png",
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(height: kDefaultSize / 2),
                        CustomText(
                          text: "What are your interests?",
                          textSize: 24,
                          fontWeight: FontWeight.w700,
                          alignText: TextAlign.center,
                        ),
                        SizedBox(height: kDefaultSize / 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultSize,
                          ),
                          child: CustomText(
                            text:
                                "Select your interests and I'll recommend some series I'm certain you'll enjoy!",
                            textSize: 14,
                            alignText: TextAlign.center,
                            textColor: Color(0XFF181818),
                          ),
                        ),
                        SizedBox(height: kDefaultSize),
                        Wrap(
                          spacing: kDefaultSize - 5,
                          runSpacing: kDefaultSize / 2,
                          alignment: WrapAlignment.spaceAround,
                          children: storedCategories.asMap().entries.map((
                            entry,
                          ) {
                            final index = entry.key;
                            final category = entry.value;
                            final isSelected = _selectedInterests.contains(
                              index,
                            );
                            return CustomTextButtonWithIcon(
                              label: category.name ?? '',
                              buttonBackgroundColour: isSelected
                                  ? kPrimaryColour
                                  : Colors.transparent,
                              buttonForegroundColour: isSelected
                                  ? Colors.white
                                  : Color(0XFF181818),
                              textColour: isSelected
                                  ? Colors.white
                                  : Color(0XFF181818),
                              borderColour: isSelected
                                  ? Colors.transparent
                                  : Color(0XFFC7C4BC),
                              buttonIcon: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: EdgeInsets.only(left: 3),
                                child: CustomText(
                                  text: category.icon ?? "",
                                  alignText: TextAlign.center,
                                  textSize: 16,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isSelected) {
                                    _selectedInterests.remove(index);
                                    return;
                                  }
                                  _selectedInterests.add(index);
                                });
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: kDefaultSize * 2),
                        Center(
                          child: CustomTextButton(
                            backgroundColour: Color(0XFF181818),
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 30,
                            ),
                            textColour: Colors.white,
                            text: "Next",
                            borderColour: Colors.transparent,
                            onPressed: () async => _addInterests(context),
                          ),
                        ),
                        SizedBox(height: kDefaultSize),
                        InkWell(
                          onTap: () => context.go(DashboardScreen.id),
                          child: CustomText(
                            text: "Skip for later",
                            textSize: 14,
                            alignText: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addInterests(BuildContext context) async {
    if (_selectedInterests.isNotEmpty) {
      try {
        _makeLoadingTrue();
        final userToken = await SecureStorage.readUserToken();
        final userId = await SecureStorage.readUserId();
        final res = await UserApi.addUserInterests(
          userToken: userToken!,
          userId: userId!,
          selectedInterests: _selectedInterests,
        );
        if (!context.mounted) return;
        if (res.statusCode == 200 || res.statusCode == 201) {
          _makeLoadingFalse();
          context.go(DashboardScreen.id);
          return;
        }
        _makeLoadingFalse();
        final addInterestsResponse = jsonDecode(res.body);
        displaySnackbar(context, addInterestsResponse['message']);
      } catch (e) {
        if (kDebugMode) {
          print("Error: $e");
        }
      }
      _makeLoadingFalse();
      return;
    }
    displaySnackbar(context, "Select at least one category!");
  }

  _makeLoadingFalse() {
    setState(() {
      _isLoading = false;
    });
  }

  _makeLoadingTrue() {
    setState(() {
      _isLoading = true;
    });
  }
}
