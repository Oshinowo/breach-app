import '../../../core/constants/app_constants.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/custom_text_button.dart';
import '../../interests/view/interests_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String id = "/welcome_screen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kAppBorderPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset("assets/svg/breach-logo.svg"),
              SizedBox(height: kDefaultSize * 3),
              Stack(
                children: [
                  Image.asset("assets/images/baby.png"),
                  Positioned(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        margin: EdgeInsets.only(bottom: kDefaultSize * 2),
                        decoration: BoxDecoration(
                          color: kPrimaryColour,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                        child: CustomText(
                          text:
                              "Hi! I'm Bev. I'm here to help you get the best out of Breach.",
                          textSize: 16,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: kDefaultSize),
              CustomText(
                text: "Welcome to Breach 🥳",
                textSize: 30,
                fontWeight: FontWeight.w700,
                alignText: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultSize,
                  vertical: kDefaultSize,
                ),
                child: CustomText(
                  text:
                      "Just a few quick questions to help personalise your Breach experience. Are you ready?",
                  textSize: 14,
                  alignText: TextAlign.center,
                  textColor: Color(0XFF181818),
                ),
              ),
              SizedBox(height: kDefaultSize * 2.5),
              Center(
                child: CustomTextButton(
                  backgroundColour: Color(0XFF181818),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  textColour: Colors.white,
                  text: "Let’s begin!",
                  borderColour: Colors.transparent,
                  onPressed: () => context.push(InterestsScreen.id),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
