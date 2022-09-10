import 'package:chennai_machine_test/controller/api_controller.dart';
import 'package:chennai_machine_test/service/firebase_auth_user.dart';
import 'package:chennai_machine_test/view/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../service/firebase_auth_admin.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  ApiController controller = Get.put(ApiController());
  FirebaseAuthAdmin adminController = Get.put(FirebaseAuthAdmin());
  FirebaseAuthUser userControler = Get.put(FirebaseAuthUser());
  @override
  Widget build(BuildContext context) {
    controller.fetchdata();
    navigation();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: Lottie.asset("assets/loading.json"),
          ),
        ),
      ),
    );
  }
}

navigation() async {
  await Future.delayed(const Duration(seconds: 3));
  Get.off(() => const ScreenHomepage());
}
