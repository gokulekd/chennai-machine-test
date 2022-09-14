import 'package:chennai_machine_test/controller/new_api_controller.dart';
import 'package:chennai_machine_test/service/new_api_services.dart';

import 'package:flutter/material.dart';

class ScreenNewScreen extends StatelessWidget {
  const ScreenNewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            NewApiService().getdata();
          },
          child: Icon(Icons.add)),
      body: FutureBuilder(
      
          future: NewApiControll().fetchdata(),
          builder: (context,AsyncSnapshot<Object?> snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData && snapshot.hasData != null) {
                return ListView.builder(itemBuilder: (context, index) {
                  return Row(children: [Text("")],);
                },);
              
               
              }
            }

            return Container(
              height: 200,
              color: Colors.green,
              child: Text("zdxcfgasdg"),
            );
          }),
    );
  }
}
