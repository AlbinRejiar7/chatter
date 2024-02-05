import 'package:chatter/controller/auth_controller.dart';
import 'package:chatter/utils/custom_sizedbox.dart';
import 'package:chatter/widgets/auth_screen_widgets/auth_screen_widget.dart';
import 'package:chatter/widgets/global/loading_widget.dart';
import 'package:chatter/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/auth_screen_widgets/custom_auth_button.dart';

class SignUpScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(AuthenticationController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: context.height * 0.15,
        title: CustomTextWidget(
          text: "Create an account",
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Obx(() {
            return LoadingOverlay(
              isLoading: c.isloading.value,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.02,
                    vertical: context.height * 0.02),
                child: SingleChildScrollView(
                    child: context.isPortrait
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await c.openImagePicker();
                                },
                                child: Column(
                                  children: [
                                    Obx(() {
                                      return c.selectedImage?.value != null
                                          ? CircleAvatar(
                                              radius: 70,
                                              backgroundImage: FileImage(
                                                  c.selectedImage!.value!),
                                            )
                                          : const CircleAvatar(
                                              radius: 70,
                                              child: Text("select picture"));
                                    }),
                                    kHeight(8),
                                    TextButton.icon(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red[900],
                                        ),
                                        onPressed: () {
                                          c.removeImage();
                                        },
                                        label: CustomTextWidget(
                                          text: "Remove Picture",
                                          color: Colors.red[900],
                                        ))
                                  ],
                                ),
                              ),
                              userNameWidget(c),
                              emailWidget(c),
                              passwordWidget(c),
                              cPasswordWidget(c),
                              kHeight(context.height * 0.05),
                              CustomAuthButton(
                                title: "Sign up",
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    await c.registerUserWithEmailAndPassword();
                                  } else {
                                    Get.snackbar("Error", "Check all fields");
                                  }
                                },
                              ),
                            ],
                          )
                        : Obx(() {
                            return LoadingOverlay(
                              isLoading: c.isloading.value,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: userNameWidget(c)),
                                      kWidth(10),
                                      Expanded(child: emailWidget(c)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: passwordWidget(c)),
                                      kWidth(10),
                                      Expanded(child: cPasswordWidget(c)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: context.width * 0.3,
                                        height: 50,
                                        child: CustomAuthButton(
                                          title: "Sign up",
                                          onTap: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              await c
                                                  .registerUserWithEmailAndPassword();
                                            } else {
                                              Get.snackbar(
                                                  "Error", "Check all fields");
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          })),
              ),
            );
          })),
    );
  }
}
