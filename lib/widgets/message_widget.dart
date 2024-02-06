// ignore_for_file: prefer_const_constructors

import 'package:chatter/constants/color_constant.dart';
import 'package:chatter/widgets/global/firebase_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget messageItem(DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  bool isUser = (data['senderId'] == authInstance.currentUser!.uid);
  var alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;

  return Container(
    padding: EdgeInsets.all(8),
    alignment: alignment,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Color.fromARGB(141, 19, 216, 124),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(!isUser ? 0 : 10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(isUser ? 0 : 10),
              )),
          child: Text(
            data['message'],
            style: TextStyle(color: customWhite),
          ),
        ),
      ],
    ),
  );
}
