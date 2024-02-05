import 'package:chatter/controller/auth_controller.dart';
import 'package:chatter/utils/custom_sizedbox.dart';
import 'package:chatter/widgets/auth_screen_widgets/custom_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/auth_screen_widgets/auth_screen_widget.dart';
import '../../widgets/text_widget.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(AuthenticationController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: context.height * 0.15,
        title: CustomTextWidget(
          text: "Sign In",
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.02, vertical: context.height * 0.02),
        child: Form(
          key: formKey1,
          child: SingleChildScrollView(
              child: context.isPortrait
                  ? Column(
                      children: [
                        emailWidget(c),
                        passwordWidget(c),
                        forgetPasswordWidget(),
                        kHeight(context.height * 0.18),
                        const CustomAuthButton(title: "Sign In"),
                        signUpNewAccountWidget()
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: emailWidget(c)),
                            kWidth(context.width * 0.015),
                            Expanded(child: passwordWidget(c)),
                          ],
                        ),
                        forgetPasswordWidget(),
                        kHeight(context.height * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                                width: context.width * 0.3,
                                height: 50,
                                child:
                                    const CustomAuthButton(title: "Sign In")),
                          ],
                        ),
                        signUpNewAccountWidget()
                      ],
                    )),
        ),
      ),
    );
  }
}
