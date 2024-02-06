// ignore_for_file: prefer_const_constructors

import 'package:chatter/controller/home_screen_controller.dart';
import 'package:chatter/utils/custom_sizedbox.dart';
import 'package:chatter/view/chat_screen/chat_screen.dart';
import 'package:chatter/view/profile_page/profile_page.dart';
import 'package:chatter/widgets/auth_screen_widgets/custom_text_field.dart';
import 'package:chatter/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Durations.short4, () async {
      var controller = Get.put(HomeScreenController());
      await controller.getCurrentUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(HomeScreenController());

    return Scaffold(
        appBar: AppBar(
          leading: Obx(() {
            return CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(c
                              .currentUserData.value.profileImage ==
                          "" ||
                      c.currentUserData.value.profileImage == null
                  ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
                  : c.currentUserData.value.profileImage!),
            );
          }),
          centerTitle: true,
          title: CustomTextWidget(
            text: "Chats",
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
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
                                  onTap: () {
                                    Get.to(() => MyChatScreen(), arguments: {
                                      "current_user_img":
                                          snapshot.data![index].profileImage,
                                      "username": snapshot.data![index].name,
                                      "otherUserId": snapshot.data![index].id,
                                    });
                                  },
                                  leading: Hero(
                                    tag:
                                        'hero-tag-${snapshot.data![index].name}',
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(snapshot
                                                      .data![index]
                                                      .profileImage ==
                                                  null ||
                                              snapshot.data![index]
                                                      .profileImage ==
                                                  ""
                                          ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
                                          : snapshot
                                              .data![index].profileImage!),
                                    ),
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
