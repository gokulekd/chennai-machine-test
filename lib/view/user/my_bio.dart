
import 'package:chennai_machine_test/model/firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/commen_text_widget.dart';

// ignore: must_be_immutable
class ScreenBioViewUser extends StatelessWidget {
  String uid;
  ScreenBioViewUser({Key? key, required this.uid}) : super(key: key);
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
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final value =
                        FirebaseModel.fromjson(snapshot.data!.data()!);

                    return Column(
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
                        TextwigetCommen(input: value.email!,widgetTitle: "Email ID"),
                        const SizedBox(
                          height: 40,
                        ),
                         TextwigetCommen(input: value.dateofBirth!,widgetTitle: "Date Of Birth"),
                        const SizedBox(
                          height: 40,
                        ),
                         TextwigetCommen(input: value.role!,widgetTitle: "JOb Role"),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(child: CircularProgressIndicator()),
                        Text("please wait..")
                      ],
                    ),
                  );
                }
                return Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(child: CircularProgressIndicator()),
                      Text("please wait..")
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

