// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatter/constants/color_constant.dart';
import 'package:chatter/controller/chat_controller.dart';
import 'package:chatter/widgets/auth_screen_widgets/custom_text_field.dart';
import 'package:chatter/widgets/global/firebase_constant.dart';
import 'package:chatter/widgets/global/transparent_container.dart';
import 'package:chatter/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyChatScreen extends StatelessWidget {
  const MyChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var chatc = Get.put(ChatController());
    String userImage = Get.arguments['current_user_img'];
    String userName = Get.arguments['username'];
    String receiverId = Get.arguments['otherUserId'];
    FocusNode focusNode = FocusNode();

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 100.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: SafeArea(
            child: FrostedGlassBox(
                theWidth: context.width,
                theHeight: 100.0,
                theChild: Row(
                  children: [
                    BackButton(
                      color: customWhite,
                    ),
                    Expanded(
                      child: ListTile(
                        subtitle: Text(
                          "Online",
                          style: TextStyle(color: customWhite, fontSize: 10),
                        ),
                        leading: Hero(
                          tag: 'hero-tag-$userName',
                          child: CircleAvatar(
                            radius: context.width * 0.07,
                            backgroundImage: NetworkImage(userImage),
                          ),
                        ),
                        title: Text(
                          userName,
                          style: TextStyle(color: customWhite),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            if (focusNode.hasFocus) {
              focusNode.unfocus();
            }
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bgchatscreen.jpg'))),
            child: Column(
              children: [
                Expanded(
                  child: Builder(builder: (context) {
                    return StreamBuilder(
                      stream: chatc.getMessage(
                          authInstance.currentUser!.uid, receiverId),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text("Error${snapshot.error.toString()}"));
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Text("Loading..."),
                          );
                        } else {
                          return ListView(
                              shrinkWrap: true,
                              reverse: true,
                              children: snapshot.data!.docs
                                  .map((e) => messageItem(e))
                                  .toList()
                                  .reversed
                                  .toList());
                        }
                      },
                    );
                  }),
                ),
                CustomTextFormField(
                  fillColor: Color.fromARGB(141, 19, 216, 124),
                  focusNode: focusNode,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        if (chatc.sendMessageController.text.isNotEmpty) {
                          await chatc.sendMessage(
                              receiverId, chatc.sendMessageController.text);
                          chatc.sendMessageController.clear();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.blueAccent,
                      )),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  controller: chatc.sendMessageController,
                  hintText: "Send a message",
                  hintStyleColor: customWhite.withOpacity(0.5),
                  textColor: customWhite,
                )
              ],
            ),
          ),
        ));
  }
}
