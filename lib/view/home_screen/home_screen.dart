// ignore_for_file: prefer_const_constructors

import 'package:chatter/controller/home_screen_controller.dart';
import 'package:chatter/utils/custom_sizedbox.dart';
import 'package:chatter/view/profile_page/profile_page.dart';
import 'package:chatter/widgets/auth_screen_widgets/custom_text_field.dart';
import 'package:chatter/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(HomeScreenController());

    return Scaffold(
        appBar: AppBar(
          leading: Obx(() {
            return c.currentUserData.value.profileImage != null
                ? CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage(c.currentUserData.value.profileImage!),
                  )
                : CircularProgressIndicator();
          }),
          centerTitle: true,
          title: Obx(() {
            return CustomTextWidget(
              text: "${c.currentUserData.value.name} Chats",
              fontWeight: FontWeight.bold,
              fontSize: 17,
            );
          }),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => ProfileScreen());
                },
                icon: const Icon(
                  color: Colors.blueAccent,
                  Icons.person_2,
                  size: 30,
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(context.width * 0.02,
              context.width * 0.05, context.width * 0.02, 0),
          child: Column(
            children: [
              CustomTextFormField(
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.name,
                  controller: c.searchController,
                  hintText: "Search"),
              StreamBuilder(
                  stream: c.convertStream(FirebaseFirestore.instance
                      .collection("users")
                      .snapshots()),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Get.snackbar("Error", snapshot.error.toString());
                      return Center(child: Text("something goes wrong"));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      if (snapshot.hasData) {
                        return Flexible(
                          child: ListView.separated(
                              separatorBuilder: (context, index) => kHeight(10),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(snapshot
                                                    .data![index]
                                                    .profileImage ==
                                                null ||
                                            snapshot.data![index]
                                                    .profileImage ==
                                                ""
                                        ? "https://firebasestorage.googleapis.com/v0/b/chattingapp-4e42e.appspot.com/o/profileimage%2FCmg9M5Bbvoc3De8pqi0v0GMiM6z2.jpg?alt=media&token=https://firebasestorage.googleapis.com/v0/b/chattingapp-4e42e.appspot.com/o/profileimage%2Fdp.jpg?alt=media&token=b20d494f-8620-416d-b2d7-b4bc67c1e556"
                                        : snapshot.data![index].profileImage!),
                                  ),
                                  title: Text(
                                    snapshot.data?[index].name ?? "loading..",
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                  subtitle: Text(
                                    snapshot.data?[index].email ?? "loading..",
                                    style: TextStyle(color: Colors.teal),
                                  ),
                                );
                              }),
                        );
                      } else {
                        return Center(child: Text("U HAVE NO CONTACTS"));
                      }
                    }
                  }),
            ],
          ),
        ));
  }
}
