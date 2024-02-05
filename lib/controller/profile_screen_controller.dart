import 'package:chatter/constants/color_constant.dart';
import 'package:chatter/controller/auth_controller.dart';
import 'package:chatter/controller/home_screen_controller.dart';
import 'package:chatter/utils/custom_sizedbox.dart';
import 'package:chatter/view/authentication_screen/login_or_signup_screen.dart';
import 'package:chatter/widgets/auth_screen_widgets/custom_text_field.dart';
import 'package:chatter/widgets/global/firebase_constant.dart';
import 'package:chatter/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController newPasswordCtr = TextEditingController();
  TextEditingController currentPasswordCtr = TextEditingController();
  TextEditingController reEnterPasswordCtr = TextEditingController();
  var refreshData = Get.put(HomeScreenController());
  var validation = Get.put(AuthenticationController());

  var isloading = false.obs;

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        Get.snackbar("Success", "Logout successful");

        Get.offAll(() => const LoginOrSignUpScreen());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.code);
    }
  }

  void changePassword(String currentPassword, String newPassword) async {
    User user = authInstance.currentUser!;
    final cred = EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        Get.snackbar("SUCCESSFULL", 'succesfull');
      }).catchError((error) {
        Get.snackbar("SUCCESSFULL", '$error');
      });
    }).catchError((err) {});
  }

  void openDialogUpdateUserName(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    Get.dialog(Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              autovalidateMode: AutovalidateMode.always,
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Enter your New Username"),
                      CloseButton(
                        onPressed: () {
                          nameCtr.clear();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  kHeight(10),
                  CustomTextFormField(
                      validator: (name) {
                        if (name!.length > 4) {
                          return null;
                        } else {
                          return "Enter valid username";
                        }
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      controller: nameCtr,
                      hintText: "Enter new Usename"),
                  const Divider(
                    color: Colors.amberAccent,
                    thickness: 1,
                  ),
                  isloading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: customPink),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              isloading(true);
                              try {
                                User user = authInstance.currentUser!;
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user.uid)
                                    .update({"name": nameCtr.text});
                                isloading(false);
                                Get.snackbar(
                                    "SUCCESSFULL", "Username Updated ");
                                refreshData
                                    .getCurrentUserData()
                                    .then((value) => Navigator.pop(context));
                              } on FirebaseException catch (e) {
                                Get.snackbar("ERROR", e.code);
                              } finally {
                                isloading(false);
                              }
                            } else {
                              Get.snackbar("ERROR", "invalid");
                            }
                          },
                          child: CustomTextWidget(text: "Update UserName"))
                ],
              ),
            );
          }),
        ),
      ),
    ));
  }

  void openDialogeUpdatePassword() async {
    Get.dialog(Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Center(
                    child: Text("Update Password"),
                  ),
                  CloseButton(),
                ],
              ),
              kHeight(10),
              CustomTextFormField(
                  validator: (pass) {
                    return validation.validatePassword(pass);
                  },
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  controller: currentPasswordCtr,
                  hintText: "Enter Current Password"),
              kHeight(10),
              CustomTextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  controller: newPasswordCtr,
                  hintText: "Enter New Password"),
              const Divider(
                color: Colors.amberAccent,
                thickness: 1,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: customPink),
                  onPressed: () async {
                    changePassword(
                        currentPasswordCtr.text, newPasswordCtr.text);
                  },
                  child: CustomTextWidget(text: "Update Password"))
            ],
          ),
        ),
      ),
    ));
  }
}
