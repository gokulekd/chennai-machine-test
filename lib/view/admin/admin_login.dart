import 'package:chennai_machine_test/service/firebase_auth_admin.dart';
import 'package:chennai_machine_test/widgets/commen_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
final adminController = Get.find<FirebaseAuthAdmin>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Admin Login"),
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
                  child: Lottie.asset("assets/admin_login_amination.json"),
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
                  Obx(
                    () => adminController.adminLoggedIn.value == true
                        ? SizedBox(
                            height: 100,
                            width: 150,
                            child: Column(
                              children: const [
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Please wait...",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(200, 40),
                              primary: const Color.fromARGB(255, 0, 0, 0),
                            ),
                            onPressed: () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              final String email =
                                  usernameController.text.trim();
                              final String password =
                                  passwordController.text.trim();
                              if (email.isEmpty || password.isEmpty) {
                                Get.snackbar("Oops..", "All field Required",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              } else if (email.isNotEmpty ||
                                  password.isNotEmpty) {
                                adminController.adminLogin(email, password);
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
