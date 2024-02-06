import 'package:chatter/controller/auth_controller.dart';
import 'package:chatter/controller/home_screen_controller.dart';
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
    var userdata = Get.put(HomeScreenController());

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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
              child: context.isPortrait
                  ? Column(
                      children: [
                        emailWidget(c),
                        passwordWidget(c),
                        forgetPasswordWidget(),
                        kHeight(context.height * 0.18),
                        CustomAuthButton(
                          title: "Sign In",
                          onTap: () async {
                            if (formKey1.currentState!.validate()) {
                              await c.signInWithEmailAndPassword();
                            } else {
                              Get.snackbar("Error",
                                  "You need to fill all the fields correctly");
                            }
                          },
                        ),
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
                                child: CustomAuthButton(
                                    onTap: () async {
                                      if (formKey1.currentState!.validate()) {
                                        await c.signInWithEmailAndPassword();
                                        await userdata.getCurrentUserData();
                                      } else {
                                        Get.snackbar("Error",
                                            "You need to fill all the fields correctly");
                                      }
                                    },
                                    title: "Sign In")),
                          ],
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}
