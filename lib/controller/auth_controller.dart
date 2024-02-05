import 'dart:io';

import 'package:chatter/view/authentication_screen/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  TextEditingController emailCtr = TextEditingController();
  TextEditingController userNameCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController cpasswordCtr = TextEditingController();
  var isloading = false.obs;
  var isVisible = false.obs;
  var isCpassVisible = false.obs;

  //--------------------------------------------------------obsecure
  void changeVisibility() {
    isVisible(!isVisible.value);
  }

  //--------------------------------------------------------image picker
  final Rx<File?>? selectedImage = Rx<File?>(null);
  void removeImage() {
    selectedImage!.value = null;
  }

  Future<void> openImagePicker() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage!.value = File(pickedImage.path);
    } else {
      if (kDebugMode) {
        print('Image not Selected');
      }
    }
  }

  //--------------------------------------------------------obsecure
  void changeVisibilityofCPassword() {
    isCpassVisible(!isCpassVisible.value);
  }

  //--------------------------------------------------------validation email
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    final isEmailValid = emailRegex.hasMatch(email ?? "");
    if (!isEmailValid) {
      return "Please enter a valid email";
    } else {
      return null;
    }
  }

  //--------------------------------------------------------validation password
  String? validatePassword(String? password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%*?&_])[A-Za-z\d@#$!%*?&_].{7,}$',
    );
    final isPassword = passwordRegex.hasMatch(password ?? "");
    if (!isPassword) {
      return "Must contain spcl char,caps and small letter,number,";
    } else {
      return null;
    }
  }

  //----------------------------------------------registering user in firebase
  Future<void> registerUserWithEmailAndPassword() async {
    String? imageUrl = "";
    isloading(true);
    try {
      await authInstance.createUserWithEmailAndPassword(
          email: emailCtr.text.toLowerCase().trim(),
          password: passwordCtr.text);
      final uid = authInstance.currentUser!.uid;

      final ref = FirebaseStorage.instance
          .ref()
          .child("profileimage")
          .child("$uid.jpg");
      if (selectedImage?.value != null) {
        await ref.putFile(selectedImage!.value!);
        imageUrl = await ref.getDownloadURL();
        print(imageUrl);
      }

      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "id": uid,
        "name": userNameCtr.text,
        "email": emailCtr.text.toLowerCase(),
        "profileimage": imageUrl,
        "createdAt": Timestamp.now()
      });
      isloading(false);
      Get.snackbar("SUCCESS", "User Created Successfully");
      Get.delete<AuthenticationController>();
      Get.offAll(() => SignInScreen());
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        "Something Messed Up",
        error.code,
      );
    } catch (error) {
      Get.snackbar("ERROR", error.toString());
    } finally {
      isloading(false);
    }
  }

  // https://firebasestorage.googleapis.com/v0/b/chattingapp-4e42e.appspot.com/o/profileimage%2FCmg9M5Bbvoc3De8pqi0v0GMiM6z2.jpg?alt=media&token=https://firebasestorage.googleapis.com/v0/b/chattingapp-4e42e.appspot.com/o/profileimage%2Fdp.jpg?alt=media&token=b20d494f-8620-416d-b2d7-b4bc67c1e556

//-----------------------------------------------------Sign in users
  Future<void> signInWithEmailAndPassword() async {
    isloading(true);
    try {
      await authInstance.signInWithEmailAndPassword(
          email: emailCtr.text.toLowerCase().trim(),
          password: passwordCtr.text.trim());
      isloading(false);

      Get.snackbar("Success", "Login successful");
    } on FirebaseAuthException catch (error) {
      Get.snackbar("Something Messed up", error.code);
    } catch (e) {
      Get.snackbar("Something Messed up", e.toString());
    } finally {
      isloading(false);
    }
  }

  @override
  void onClose() {
    emailCtr.clear();
    userNameCtr.clear();
    passwordCtr.clear();
    super.onClose();
  }
}
