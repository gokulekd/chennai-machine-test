import 'dart:async';
import 'dart:developer';

import 'package:chennai_machine_test/model/create_project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../widgets/commen_text_widget.dart';

// ignore: must_be_immutable
class ScreenMyProjectDetailedView extends StatelessWidget {
  int newIndex;
  ScreenMyProjectDetailedView({Key? key, required this.newIndex})
      : super(key: key);
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("NewProject")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("projectID")
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && snapshot.data != null) {
                  final value = CreateProject.fromJson(
                      snapshot.data!.docs[newIndex].data());
                  double latitude = double.parse(value.latitude!);
                  double longitude = double.parse(value.longitude!);
                  log(">>>>>>>>>> $latitude>>>>>>>>>>>  $longitude >>>>>>>>");
                  return ListView(
                    children: [
                      TextwigetCommen(
                          input: value.projectName!,
                          widgetTitle: "Project Name"),
                      TextwigetCommen(
                          input: value.date!, widgetTitle: "statring Date "),
                      TextwigetCommen(
                          input: value.companyName!,
                          widgetTitle: "copanany Name"),
                      TextwigetCommen(
                          input: value.website!,
                          widgetTitle: "copanany Website"),
                      MapSample(
                        latitude: latitude,
                        longitude: longitude,
                      )
                    ],
                  );
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
            },
          ),
        ),
      ),
    );
  }
}

class MapSample extends StatelessWidget {
  final double longitude;
  final double latitude;
  MapSample({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();

  static const Marker markerGoogleMap = Marker(
    markerId: MarkerId("marker"),
    infoWindow: InfoWindow(title: "Project Location"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(9.292490, 76.554810),
  );

  @override
  Widget build(BuildContext context) {
    CameraPosition googleLocation = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 10.4746,
    );

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 204, 181, 181),width: 0.5),borderRadius: BorderRadius.circular(15)),
     
    
      height: h * 0.57,
      width: w * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            const Align(
                 alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Job Location", maxLines: 1,
                  style: TextStyle(
                    
                       overflow: TextOverflow.ellipsis,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              height: h * 0.5,
              width: w * 0.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GoogleMap(
                  mapType: MapType.normal,
                  markers: {markerGoogleMap},
                  initialCameraPosition: googleLocation,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
