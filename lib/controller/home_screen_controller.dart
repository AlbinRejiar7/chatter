import 'package:chatter/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  var currentUserData = UserModel().obs;

  Future<void> getCurrentUserData() async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(authInstance.currentUser!.uid)
          .get();
      currentUserData(UserModel(
        createdAt: userDoc.get("createdAt"),
        email: userDoc.get("email"),
        id: userDoc.get("id"),
        name: userDoc.get("name"),
        profileImage: userDoc.get("profileimage"),
      ));
    } on FirebaseException catch (e) {
      Get.snackbar("Execption", e.code);
    }
  }

  Stream<List<UserModel>> convertStream(
      Stream<QuerySnapshot<Map<String, dynamic>>> stream) {
    return stream.map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .where(
              (doc) => doc.data()["email"] != authInstance.currentUser!.email)
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return UserModel.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  void onInit() async {
    await getCurrentUserData();
    super.onInit();
  }
}
