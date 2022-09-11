
import 'package:chennai_machine_test/view/admin/create_project.dart';
import 'package:chennai_machine_test/view/admin/create_user.dart';
import 'package:chennai_machine_test/view/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCatagoryAdmin extends StatelessWidget {
  const SelectCatagoryAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
            
              final prefs =  await SharedPreferences.getInstance();
              prefs.clear();
              Get.offAll(()=>const ScreenHomepage());
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
                child: Lottie.asset("assets/choose category admin.json"),
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
                    Get.to(() => const ScreenCreateUserFromAdmin());
                  },
                  child: const Text(
                    "Create User",
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
                    Get.to(() => const ScreenCreateNewProjectFromAdmin());
                  },
                  child: const Text(
                    "Create Project",
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
