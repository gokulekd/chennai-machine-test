
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_projects_detailed_view.dart';

class ScreenMyProjectListViewsUser extends StatelessWidget {
  const ScreenMyProjectListViewsUser ({Key? key}) : super(key: key);

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
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ScreenMyProjectDetailedView());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: const ListTile(
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      title: Text("Project Name"),
                      subtitle: Text("Company Name"),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
