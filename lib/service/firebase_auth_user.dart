
import 'dart:developer';
import 'package:chennai_machine_test/view/user/select_category_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseAuthUser extends GetxController {
 
  List personalData = [];

  final _firebaseAuth = FirebaseAuth.instance;
  userLogin(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password,)
          .then((value) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user!.uid ==
            FirebaseFirestore.instance
                .collection("user")
                .doc(user.uid)
                .toString()) {
          Get.to(() =>  SelectCatagoryUser(  useruid: _firebaseAuth.currentUser!.uid));
        }
        return value;
      });

      Get.snackbar("Message", "user login Sucsses",
          backgroundColor: Colors.green, colorText: Colors.white);

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Firebase Error", e.message.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }



  personalDataUser(String uid) async {
    var result =
        FirebaseFirestore.instance.collection('user').doc("uid").snapshots();
    personalData = result as List;
    update();
    log(">>>>>>>>>>>>>>personal data$result.toString()");
    return result;
  }


}