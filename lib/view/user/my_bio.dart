
import 'dart:developer';

import 'package:chennai_machine_test/service/firebase_auth_user.dart';
import 'package:chennai_machine_test/widgets/commen_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class ScreenBioViewUser extends StatelessWidget {
  ScreenBioViewUser({Key? key}) : super(key: key);
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Bio",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<FirebaseAuthUser>(
            stream:FirebaseAuthUser().personalDataUser(FirebaseAuth.instance.currentUser!.uid) ,
            builder: (context, snapshot) {
              log(FirebaseAuthUser().personalData.toString());
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset("assets/User-Icon.png"),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CommenTextField(
                      controller: usernameController, hinttext: "user name"),
                  const SizedBox(
                    height: 40,
                  ),
                  CommenTextField(
                      controller: passwordController, hinttext: "Password"),
                  const SizedBox(
                    height: 40,
                  ),
                  CommenTextField(
                      controller: passwordController, hinttext: "Date of Birth"),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
