import 'package:chatter/model/message.dart';
import 'package:chatter/widgets/global/firebase_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController sendMessageController = TextEditingController();

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = authInstance.currentUser!.uid;
    final String currentUserEmail = authInstance.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        message: message,
        receiverId: receiverId,
        timestamp: timestamp);
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
