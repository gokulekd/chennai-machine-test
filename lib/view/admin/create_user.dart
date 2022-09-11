import 'dart:developer';

import 'package:chennai_machine_test/service/firebase_auth_admin.dart';

import 'package:chennai_machine_test/widgets/commen_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ScreenCreateUserFromAdmin extends StatefulWidget {
  const ScreenCreateUserFromAdmin({Key? key}) : super(key: key);

  @override
  State<ScreenCreateUserFromAdmin> createState() =>
      _ScreenCreateUserFromAdminState();
}

class _ScreenCreateUserFromAdminState extends State<ScreenCreateUserFromAdmin> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  DateTime? value;
  final adminController = Get.find<FirebaseAuthAdmin>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 150,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Create New User",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: 300,
                      child: Center(
                        child: value == null
                            ? const Text(
                                "Select Date of Birth",
                                style: TextStyle(fontSize: 15),
                              )
                            : Text(
                                '${value!.day}/${value!.month}/${value!.year}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        final initial = DateTime.now();
                        final DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: initial,
                          firstDate: DateTime(DateTime.now().year - 5),
                          lastDate: DateTime(DateTime.now().year + 5),
                        );

                        if (newDate == null) return;
                        setState(() {
                          value = newDate;
                        });
                      },
                      icon: const Icon(Icons.calendar_month))
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => adminController.adminCreatedUser.value == true
                        ? SizedBox(
                            height: 150,
                            width: 150,
                            child: Column(
                              children: const [
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Please wait...",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                              var date =
                                  DateTime.parse(value!.toString());
                              var formattedDate =
                                  "${date.day}-${date.month}-${date.year}";

                              log(formattedDate);
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
                                adminController.adminCreateUsers(
                                    email, password, formattedDate.toString());
                              }
                            },
                            child: const Text(
                              "Submit",
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
