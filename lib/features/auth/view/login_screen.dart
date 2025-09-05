import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../core/services/networking/auth_api.dart';
import '../../../core/services/secure_storage/secure_storage.dart';
import '../../../core/utils/snackbar.dart';
import '../../dashboard/view/dashboard_screen.dart';
import 'signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/components/custom_text_button.dart';
import '../../../core/components/custom_text_form_field.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String id = "/login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  bool _enableButton = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SvgPicture.asset("assets/svg/breach-logo.svg"),
                        SizedBox(height: kDefaultSize * 3),
                        CustomText(
                          text: "Welcome Back",
                          textSize: 32,
                          fontWeight: FontWeight.w600,
                          alignText: TextAlign.center,
                        ),
                        SizedBox(height: kDefaultSize / 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultSize + 10,
                          ),
                          child: CustomText(
                            text:
                                "Break through the noise and discover content that matters to you in under 3 minutes.",
                            textSize: 14,
                            alignText: TextAlign.center,
                            textColor: Color(0XFF181818),
                          ),
                        ),
                        SizedBox(height: kDefaultSize * 3),
                        CustomText(text: "Email", textSize: 12),
                        SizedBox(height: 3),
                        CustomTextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          validate: kEmailValidator.call,
                          onKeyUp: (value) {
                            if (value != "" && _passwordController.text != "") {
                              setState(() => _enableButton = true);
                              return;
                            }
                            setState(() => _enableButton = false);
                          },
                        ),
                        const SizedBox(height: kDefaultSize / 2),
                        const CustomText(text: "Password", textSize: 14),
                        const SizedBox(height: 3),
                        CustomTextFormField(
                          obscureText: _isPasswordVisible,
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          inputAction: TextInputAction.next,
                          validate: kPasswordValidator.call,
                          onKeyUp: (value) {
                            if (value != "" && _emailController.text != "") {
                              setState(() => _enableButton = true);
                              return;
                            }
                            setState(() => _enableButton = false);
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        const SizedBox(height: kDefaultSize),
                        CustomTextButton(
                          backgroundColour: _enableButton
                              ? Color(0XFF181818)
                              // ? kPrimaryColour
                              : Color(0XFFD6D6D6),
                          textColour: Colors.white,
                          text: "Continue",
                          borderColour: Colors.transparent,
                          onPressed: _enableButton
                              ? () async => await _loginUser(context)
                              : null,
                          padding: EdgeInsets.symmetric(
                            vertical: kDefaultSize - 5,
                          ),
                        ),
                        SizedBox(height: kDefaultSize + 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Don't have an account? ",
                              textSize: 14,
                              alignText: TextAlign.center,
                            ),
                            InkWell(
                              onTap: () =>
                                  context.pushReplacement(SignupScreen.id),
                              child: CustomText(
                                text: "Sign Up",
                                textSize: 14,
                                textColor: kPrimaryColour,
                                alignText: TextAlign.center,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: kDefaultSize * 3),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              CustomText(
                                text: "By signing up, you agree to Breach’s ",
                                textSize: 14,
                              ),
                              InkWell(
                                onTap: () {},
                                child: CustomText(
                                  text: "Terms",
                                  textSize: 14,
                                  textColor: kPrimaryColour,
                                ),
                              ),
                              CustomText(text: " & ", textSize: 14),
                              InkWell(
                                onTap: () {},
                                child: CustomText(
                                  text: "Privacy Policy",
                                  textSize: 14,
                                  textColor: kPrimaryColour,
                                ),
                              ),
                            ],
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

  Future<void> _loginUser(BuildContext context) async {
    if (_loginFormKey.currentState!.validate()) {
      try {
        _makeLoadingTrue();
        final res = await AuthApi.loginUser(
          userEmail: _emailController.text,
          userPassword: _passwordController.text,
        );
        final loginUserResponse = jsonDecode(res.body);
        if (!context.mounted) return;
        if (res.statusCode == 200 || res.statusCode == 201) {
          // log("$userToken");
          SecureStorage.setUserToken(loginUserResponse['token']);
          SecureStorage.setUserId("${loginUserResponse['userId']}");
          _makeLoadingFalse();
          context.go(DashboardScreen.id);
          return;
        }
        _makeLoadingFalse();
        displaySnackbar(context, "${loginUserResponse['message']}");
      } catch (e) {
        if (kDebugMode) {
          print("Error: $e");
        }
      }
      _makeLoadingFalse();
    }
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
