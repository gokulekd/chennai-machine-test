import 'dart:developer';
import 'package:chennai_machine_test/view/admin/admin_login.dart';
import 'package:chennai_machine_test/view/admin/select_category_admin.dart';
import 'package:chennai_machine_test/view/user/select_category_user.dart';
import 'package:chennai_machine_test/view/user/user_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHomepage extends StatelessWidget {


  const ScreenHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox(),
        title: const Text("Select Category"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Center(
                child: SizedBox(
                  height: width * 0.9,
                  width: width * 0.9,
                  child: Lottie.asset("assets/category.json"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 30, 77, 233),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    Get.to(
                      () => StreamBuilder<User?>(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(snapshot.data!.uid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    final user = snapshot.data!.data();

                                    if (user!['role'] == "user") {
                                      var userUid = FirebaseAuth
                                          .instance.currentUser!.uid;
                                          log(userUid.toString());
                                      log("Home screen User auth check in stream Builder ..User  Inside Category.... User  Inside Category.....");
                                      return  SelectCatagoryUser(useruid: userUid,);
                                    }  else {
                                      return const UserLogin();
                                    }
                                  }
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  log("Home screen User auth check in stream Builder ..User logged in.... user logged in.....");
                                  return Scaffold(
                                    body: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Center(
                                            child: CircularProgressIndicator()),
                                        Text("please wait..")
                                      ],
                                    ),
                                  );
                                }
                                return Scaffold(
                                  body: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Center(
                                          child: CircularProgressIndicator()),
                                      Text("please wait..")
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            log("Home screen User auth check in stream Builder .. No User .... No User....");
                            return const UserLogin();
                          }
                        },
                      ),
                    );
                  },
                  child: const Text("User"),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final isLogged = prefs.getBool("flag");
                    if (isLogged == true) {
                      Get.to(() => const SelectCatagoryAdmin());
                    } else {
                      Get.to(() => const AdminLogin());
                    }
                  },
                  child: const Text("admin"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
