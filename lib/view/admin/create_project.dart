import 'dart:developer';
import 'package:chennai_machine_test/constants/colors.dart';
import 'package:chennai_machine_test/controller/api_controller.dart';
import 'package:chennai_machine_test/service/firebase_auth_admin.dart';
import 'package:chennai_machine_test/service/firebase_auth_user.dart';
import 'package:chennai_machine_test/widgets/commen_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenCreateNewProjectFromAdmin extends StatefulWidget {
  const ScreenCreateNewProjectFromAdmin({Key? key}) : super(key: key);

  @override
  State<ScreenCreateNewProjectFromAdmin> createState() =>
      _ScreenCreateNewProjectFromAdminState();
}

class _ScreenCreateNewProjectFromAdminState
    extends State<ScreenCreateNewProjectFromAdmin> {
  TextEditingController projectController = TextEditingController();
  final adminController = Get.find<FirebaseAuthAdmin>();

  DateTime? value;
  String hintTextCompany = "Select Company name";
  String selectuser = "assing to a user ";
  String? hintTextWebsite;
  String? selectedUserId;
  String? hintGeoLatitude;
  String? hintGeoLongitude;
  String? selectedValue;
  String? userselection;
  final controller = Get.find<ApiController>();
  FirebaseAuthUser usercontroller = Get.put(FirebaseAuthUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [




                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("user")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return DropdownButtonFormField(
                            hint: Text(selectuser),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: textFormfieldColor, width: 2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              filled: true,
                              fillColor: textFormfieldColor,
                            ),
                            dropdownColor: Colors.white,
                            value: userselection == null
                                ? userselection
                                : controller.newuserAssing.value.toString(),
                            onChanged: (String? newValue) {
                              git 
                              
                          
    var data = snapshot.data!.docs.where((items) => (items ["email"] == newValue);


                          
                            },
                            items: snapshot.data!.docs
                                .map<DropdownMenuItem<String>>((items) {
                              return DropdownMenuItem<String>(
                                value: items["email"],
                                child: Text(items["email"] ),
                              );
                            }).toList(),
                          );
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Text(
                          "please wait ..Loading Data",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        );
                      }
                      return const SizedBox();
                    }),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Create New Project",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                CommenTextField(
                    controller: projectController, hinttext: "Project name"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10)),
                        height: 50,
                        width: 300,
                        child: value == null
                            ? const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Project Date",
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
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
                  height: 20,
                ),
                GetBuilder<ApiController>(
                    init: ApiController(),
                    builder: (controller) {
                      return Column(
                        children: [
                          DropdownButtonFormField(
                            hint: Text(hintTextCompany),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: textFormfieldColor, width: 2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              filled: true,
                              fillColor: textFormfieldColor,
                            ),
                            dropdownColor: textFormfieldColor,
                            value: selectedValue == null
                                ? selectedValue
                                : controller.newValueDropdown.value.toString(),
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  log(newValue.toString());
                                  hintTextCompany = newValue!;
                                  for (var i = 0;
                                      i < controller.allCompanyList.length;
                                      i++) {
                                    if (newValue ==
                                        controller
                                            .allCompanyList[i].company.name) {
                                      setState(() {
                                        hintTextWebsite = controller
                                            .allCompanyList[i].website;
                                        hintGeoLatitude = controller
                                            .allCompanyList[i].address.geo.lat;
                                        hintGeoLongitude = controller
                                            .allCompanyList[i].address.geo.lng;
                                        log(hintTextWebsite.toString());
                                        log(hintGeoLongitude.toString());
                                        log(hintGeoLongitude.toString());
                                      });
                                    }
                                  }
                                  controller.update();
                                },
                              );
                            },
                            items: controller.allCompanyList
                                .map<DropdownMenuItem<String>>((items) {
                              return DropdownMenuItem<String>(
                                value: items.company.name,
                                child: Text(items.company.name.toString()),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 60,
                              width: 360,
                              child: hintTextWebsite == null
                                  ? const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "choose website",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "website of Company : ${hintTextWebsite!}",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 60,
                              width: 360,
                              child: hintTextWebsite == null
                                  ? const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "choose location",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Latitude :${hintGeoLatitude!}",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 60,
                              width: 360,
                              child: hintGeoLongitude == null
                                  ? const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "choose location",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Longitude :${hintGeoLongitude!}",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            hint: Text(selectuser),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: textFormfieldColor, width: 2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              filled: true,
                              fillColor: textFormfieldColor,
                            ),
                            dropdownColor: textFormfieldColor,
                            value: userselection == null
                                ? userselection
                                : controller.newuserAssing.value.toString(),
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  log(newValue.toString());
                                  selectuser = newValue!;
                                  for (var i = 0;
                                      i < usercontroller.alluserList.length;
                                      i++) {
                                    if (newValue ==
                                        usercontroller
                                            .alluserList[i].username) {
                                      setState(() {
                                        selectedUserId =
                                            usercontroller.alluserList[i].id;

                                        log(selectedUserId.toString());
                                      });
                                    }
                                  }

                                  controller.update();
                                },
                              );
                            },
                            items: usercontroller.alluserList
                                .map<DropdownMenuItem<String>>((items) {
                              return DropdownMenuItem<String>(
                                value: items.username,
                                child: Text(items.username.toString()),
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                      () => adminController.adminCreatedProject.value == true
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
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                final project = projectController.text.trim();
                                if (project.isEmpty ||
                                    hintTextCompany == "Select Company name" ||
                                    value == null) {
                                  Get.snackbar("Oops..", "All field Required",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white);
                                } else if (project.isNotEmpty ||
                                    hintTextCompany != "Select Company name" ||
                                    value != null) {
                                  await adminController.adminCreateProject(
                                      selectedUserId!,
                                      project,
                                      hintTextCompany,
                                      value.toString(),
                                      hintTextWebsite!,
                                      hintGeoLatitude!,
                                      hintGeoLongitude!);
                                }
                              },
                              child: const Text(
                                "Submit",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//  Obx(
//                     () => adminController.adminCreatedUser.value == true
//                         ? SizedBox(
//                             height: 150,
//                             width: 150,
//                             child: Column(
//                               children: const [
//                                 Center(
//                                   child: CircularProgressIndicator(),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "Please wait...",
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               fixedSize: const Size(200, 40),
//                               primary: const Color.fromARGB(255, 0, 0, 0),
//                             ),
//                             onPressed: () async {
//                               FocusScopeNode currentFocus =
//                                   FocusScope.of(context);

//                               if (!currentFocus.hasPrimaryFocus) {
//                                 currentFocus.unfocus();
//                               }
//                               final String email =
//                                   usernameController.text.trim();
//                               final String password =
//                                   passwordController.text.trim();
//                               if (email.isEmpty || password.isEmpty) {
//                                 Get.snackbar("Oops..", "All field Required",
//                                     backgroundColor: Colors.red,
//                                     colorText: Colors.white);
//                               } else if (email.isNotEmpty ||
//                                   password.isNotEmpty) {
//                                 adminController.adminCreateUsers(
//                                     email, password, value!.toString());
//                               }
//                             },
//                             child: const Text(
//                               "Submit",
//                               style: TextStyle(fontSize: 22),
//                             ),
//                           ),
//                   ),
