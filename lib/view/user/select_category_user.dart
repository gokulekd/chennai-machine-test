import 'package:chennai_machine_test/view/screen_home.dart';
import 'package:chennai_machine_test/view/user/my_project_List_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'my_bio.dart';

class SelectCatagoryUser extends StatelessWidget {
    final String useruid;
  const SelectCatagoryUser({Key? key,required this.useruid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(() => const ScreenHomepage());
              },
              icon: const Icon(Icons.logout))
        ],
        leading: const SizedBox(),
        centerTitle: true,
        title: const Text("Select Category"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: SizedBox(
                height: width * 0.9,
                width: width * 0.9,
                child: Lottie.asset("assets/choose category user.json"),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 50),
                    primary: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    Get.to(() => ScreenBioViewUser(uid:useruid ,));
                  },
                  child: const Text(
                    "My Bio",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 50),
                    primary: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    Get.to(() => const ScreenMyProjectListViewsUser());
                  },
                  child: const Text(
                    "My Project",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
