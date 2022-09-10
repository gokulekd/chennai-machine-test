import 'dart:developer';
import 'dart:math';
import 'package:chennai_machine_test/model/create_project.dart';
import 'package:chennai_machine_test/view/admin/select_category_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthAdmin extends GetxController {
  RxBool adminLoggedIn = false.obs;
  RxBool adminCreatedUser = false.obs;
  RxBool adminCreatedProject = false.obs;
  final _firebaseAuth = FirebaseAuth.instance;
  Future<User?> adminLogin(String email, String password) async {
    adminLoggedIn(true);
    try {
      if (email == "admin@kssmart.co" && password == "123456") {
        UserCredential userCredential = await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool("flag", true);
          adminLoggedIn(false);

          Get.to(() => const SelectCatagoryAdmin());
          return value;
        });

        Get.snackbar("Message", "Admin Sucsses",
            backgroundColor: Colors.green, colorText: Colors.white);

        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Firebase Error", e.message.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      print(e.toString());
    } finally {
      adminLoggedIn(false);
    }
    return null;
  }

  Future<User?> adminCreateUsers(
      String email, String password, String date) async {
    try {
      adminCreatedUser(true);
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance.collection("user").doc(user!.uid).set({
          'uid': user.uid,
          'email': email,
          'password': password,
          'DateofBirth': date,
          'role': "user"
        });
        adminCreatedUser(false);
        Get.off(() => const SelectCatagoryAdmin());
        return value;
      });
      Get.snackbar("Message", "Created User Sucssesfully",
          backgroundColor: Colors.green, colorText: Colors.white);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Firebase Error", e.message.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } on FirebaseFirestore catch (e) {
      Get.snackbar("Firebase Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      print(e.toString());
    } finally {
      adminCreatedUser(false);
    }
    return null;
  }

  Future adminCreateProject(
    String id,
    String projectName,
    String companyname,
    String date,
    String website,
    String latitude,
    String longitude,
  ) async {
    try {
      Random random2 = Random.secure();
      var randomNumber = random2.nextInt(856868);
      var addNewProject = CreateProject(
              id: id,
              projectName: projectName,
              companyName: companyname,
              date: date,
              website: website,
              latitude: latitude,
              longitude: longitude)
          .tojson();
      adminCreatedProject(true);
      await FirebaseFirestore.instance
          .collection("AssinedProject")
          .doc(id)
          .collection(randomNumber.toString())
          .add(addNewProject)
          .then((value) async {
        Get.snackbar("Message", "project assined to  User Sucssesfully",
            backgroundColor: Colors.green, colorText: Colors.white);
        adminCreatedProject(false);
        Get.off(() => const SelectCatagoryAdmin());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Firebase Error", e.message.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } on FirebaseFirestore catch (e) {
      Get.snackbar("Firebase Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      print(e.toString()) ;
    } finally {
      adminCreatedProject(false);
    }
    return null;
  }
}
