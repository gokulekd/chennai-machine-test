import 'package:chennai_machine_test/widgets/commen_text_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScreenMyProjectDetailedView extends StatelessWidget {
   ScreenMyProjectDetailedView({Key? key}) : super(key: key);
TextEditingController  usernameController = TextEditingController();
TextEditingController  passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: const Text("Project View"),
  centerTitle: true,

),
body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              CommenTextField(
                  controller: usernameController, hinttext: "Project name"),
              const SizedBox(
                height: 28,
              ),
              CommenTextField(
                  controller: passwordController, hinttext: "Date"),
              const SizedBox(
                height: 28,
              ),
              CommenTextField(
                  controller: passwordController, hinttext: "Company Name"),
              const SizedBox(
                height: 28,
              ),
                 CommenTextField(
                  controller: passwordController, hinttext: "Website"),
              const SizedBox(
                height: 28,
              ),
                 CommenTextField(
                  controller: passwordController, hinttext: "Location"),
              const SizedBox(
                height: 28,
              ),
                 CommenTextField(
                  controller: passwordController, hinttext: "Assign User"),
              const SizedBox(
                height: 28,
              ),
           
            ],
          ),
        ),
      ),
    );
    
  }
}