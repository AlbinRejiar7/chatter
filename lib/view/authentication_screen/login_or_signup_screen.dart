import 'dart:ui';

import 'package:chatter/constants/color_constant.dart';
import 'package:chatter/utils/custom_sizedbox.dart';
import 'package:chatter/view/authentication_screen/sign_in_screen.dart';
import 'package:chatter/view/authentication_screen/sign_up_screen.dart';
import 'package:chatter/widgets/auth_screen_widgets/custom_auth_button.dart';
import 'package:chatter/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOrSignUpScreen extends StatelessWidget {
  const LoginOrSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://i.pinimg.com/originals/1d/8c/2a/1d8c2ab646cf2e5493d78dd76676ddfd.jpg"))),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: context.height * 0.5,
                  width: context.width,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12)),
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                        child: Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: customWhite.withOpacity(0.13)),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  customWhite.withOpacity(0.15),
                                  customWhite.withOpacity(0.05),
                                ])),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.cover,
                                child: CustomTextWidget(
                                  text: "Hello!",
                                  fontSize: 50,
                                  color: customWhite,
                                ),
                              ),
                              CustomTextWidget(
                                text:
                                    "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor incididunt",
                                color: customWhite,
                              ),
                              kHeight(context.height * 0.03),
                              CustomAuthButton(
                                onTap: () {
                                  Get.to(() => SignInScreen());
                                },
                                title: "SIGN IN",
                                color: customGreen,
                              ),
                              kHeight(context.height * 0.03),
                              CustomAuthButton(
                                onTap: () {
                                  Get.to(() => SignUpScreen());
                                },
                                title: "SIGN UP",
                                color: customWhite.withOpacity(0.2),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
