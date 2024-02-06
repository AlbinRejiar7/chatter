import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String senderEmail;
  final String message;
  final String receiverId;
  final Timestamp timestamp;
  MessageModel({
    required this.senderId,
    required this.senderEmail,
    required this.message,
    required this.receiverId,
    required this.timestamp,
  });
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
