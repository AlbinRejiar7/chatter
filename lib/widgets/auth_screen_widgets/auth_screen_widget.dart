import 'package:chatter/controller/auth_controller.dart';
import 'package:chatter/utils/custom_sizedbox.dart';
import 'package:chatter/widgets/auth_screen_widgets/custom_text_field.dart';
import 'package:chatter/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/authentication_screen/sign_up_screen.dart';

Column cPasswordWidget(AuthenticationController c) {
  return Column(
    children: [
      Row(
        children: [
          CustomTextWidget(text: "Confirm Password"),
        ],
      ),
      kHeight(8),
      Obx(() {
        return CustomTextFormField(
            validator: (pass) =>
                pass != c.passwordCtr.text ? "password mis match" : null,
            suffixIcon: IconButton(
                onPressed: () {
                  c.changeVisibilityofCPassword();
                },
                icon: c.isCpassVisible.value
                    ? const Icon(
                        Icons.visibility,
                        color: Color.fromARGB(255, 255, 17, 0),
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: Color.fromARGB(255, 13, 196, 19),
                      )),
            obscureText: !c.isCpassVisible.value,
            hintText: "Your Password",
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            controller: c.cpasswordCtr);
      }),
    ],
  );
}

Column userNameWidget(AuthenticationController c) {
  return Column(
    children: [
      Row(
        children: [
          CustomTextWidget(text: "Username"),
        ],
      ),
      kHeight(8),
      CustomTextFormField(
          validator: (username) {
            return username!.length < 4
                ? "Username must be greater than 4"
                : null;
          },
          hintText: "Your Username",
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          controller: c.userNameCtr),
    ],
  );
}

Row signUpNewAccountWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      CustomTextWidget(
        text: "Dont Have an account sign Up!",
      ),
      TextButton.icon(
          onPressed: () {
            Get.offAll(() => SignUpScreen());
            Get.delete<AuthenticationController>();
          },
          icon: const Icon(Icons.login),
          label: CustomTextWidget(
            text: "Sign up",
          )),
    ],
  );
}

Row forgetPasswordWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [CustomTextWidget(text: "Forgot password?")],
  );
}

Column passwordWidget(AuthenticationController c) {
  return Column(
    children: [
      Row(
        children: [
          CustomTextWidget(text: "Password"),
        ],
      ),
      kHeight(8),
      Obx(() {
        return CustomTextFormField(
            validator: (pass) {
              return c.validatePassword(pass);
            },
            suffixIcon: IconButton(
                onPressed: () {
                  c.changeVisibility();
                },
                icon: c.isVisible.value
                    ? const Icon(
                        Icons.visibility,
                        color: Color.fromARGB(255, 255, 17, 0),
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: Color.fromARGB(255, 13, 196, 19),
                      )),
            obscureText: !c.isVisible.value,
            hintText: "Your Password",
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            controller: c.passwordCtr);
      }),
    ],
  );
}

Column emailWidget(AuthenticationController c) {
  return Column(
    children: [
      Row(
        children: [
          CustomTextWidget(text: "Email"),
        ],
      ),
      kHeight(8),
      CustomTextFormField(
          validator: (email) {
            return c.validateEmail(email);
          },
          hintText: "Your Email",
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          controller: c.emailCtr),
    ],
  );
}
