import 'package:chennai_machine_test/service/firebase_auth_user.dart';
import 'package:chennai_machine_test/widgets/commen_text_field.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {


  @override
  Widget build(BuildContext context) {
TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User Login"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Center(
                child: SizedBox(
                  height: width * 0.8,
                  width: width * 0.8,
                  child: Lottie.asset("assets/user login.json"),
                ),
              ),
              CommenTextField(
                  controller: usernameController, hinttext: "user name"),
              const SizedBox(
                height: 20,
              ),
              CommenTextField(
                  controller: passwordController, hinttext: "Password"),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 40),
                      primary: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    onPressed: () async {
                      final String email = usernameController.text.trim();
                      final String password = passwordController.text.trim();
                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar("Oops..", "All field Required",
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      } 
                        if (email.isNotEmpty || password.isNotEmpty ) {

                        await FirebaseAuthUser().userLogin(email, password);
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
