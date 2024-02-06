// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatter/constants/color_constant.dart';
import 'package:chatter/controller/home_screen_controller.dart';
import 'package:chatter/controller/profile_screen_controller.dart';
import 'package:chatter/utils/custom_sizedbox.dart';
import 'package:chatter/widgets/auth_screen_widgets/custom_auth_button.dart';
import 'package:chatter/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(HomeScreenController());
    var proCtr = Get.put(ProfileScreenController());

    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(text: "Profile settings"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(c
                                    .currentUserData.value.profileImage ==
                                "" ||
                            c.currentUserData.value.profileImage == null
                        ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
                        : c.currentUserData.value.profileImage!),
                  ),
                ),
                kHeight(context.height * 0.02),
                CustomTextWidget(
                  text: c.currentUserData.value.name ?? "loading...",
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                CustomTextWidget(
                  text: c.currentUserData.value.email ?? "loading...",
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                kHeight(context.height * 0.05),
                //------------------------------------editing sections NAME
                CustomProfileContainer(
                    onPressed: () {
                      proCtr.openDialogUpdateUserName(context);
                    },
                    title: c.currentUserData.value.name ?? "loading...",
                    icon: Icon(Icons.person_outlined)),
                kHeight(context.height * 0.05),
                //----------------------------------------------------------Password
                CustomProfileContainer(
                    onPressed: () {
                      proCtr.openDialogeUpdatePassword();
                    },
                    title: "Change Password",
                    icon: Icon(Icons.password)),
                kHeight(context.height * 0.05),
                CustomAuthButton(
                  title: "Logout",
                  onTap: () async {
                    await proCtr.signOut();
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CustomProfileContainer extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Icon icon;
  const CustomProfileContainer({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.07,
      width: context.width,
      decoration: BoxDecoration(
          color: customGrey, borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(backgroundColor: customPurple, child: icon),
            CustomTextWidget(text: title),
            IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.edit,
                  color: customPurple,
                ))
          ],
        ),
      ),
    );
  }
}
