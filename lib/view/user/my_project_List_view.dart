import 'package:chennai_machine_test/model/create_project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_projects_detailed_view.dart';

class ScreenMyProjectListViewsUser extends StatelessWidget {
  const ScreenMyProjectListViewsUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Projects List"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("NewProject")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("projectID")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final products = CreateProject.fromJson(
                          snapshot.data!.docs[index].data());

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ScreenMyProjectDetailedView(
                                  newIndex: index,
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            child: ListTile(
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_outlined),
                              title: Text(products.companyName!.toString()),
                              subtitle: Text(products.date!.toString()),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(child: Text("No Projcts for you"));
              }),
        ),
      ),
    );
  }
}
