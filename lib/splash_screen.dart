import 'package:flutter/material.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'main.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return SplashScreenState();
//   }
// }
//
// class SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     handleSplashscreen();
//   }
//
//   void handleSplashscreen() async {
//     // Wait for async to complete
//     await someAsyncFunction();
//     // Open Main page
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => MyHomePage()));
//   }
//
//   Future<List<String>> someAsyncFunction() async {
//     List<String> address = [];
//     Position position = await Geolocator.getCurrentPosition();
//     // print(position);
//
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     for (int i = 0; i < placemarks.length; i++) {
//       print(placemarks[i]);
//       if (placemarks[i].administrativeArea!.isNotEmpty &&
//           placemarks[i].subAdministrativeArea!.isNotEmpty &&
//           placemarks[i].locality!.isNotEmpty) {
//         print(placemarks[i]);
//         address.add(placemarks[i].administrativeArea!);
//         address.add(placemarks[i].subAdministrativeArea!);
//         address.add(placemarks[i].locality!);
//       }
//     }
//     return address;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(child: Text("Loading...")),
//     );
//   }
// }
// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             "Initialization",
//             style: TextStyle(
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 20),
//           CircularProgressIndicator()
//         ],
//       ),
//     );
//   }
// }
//
// class Init {
//   static Future initialize() async {
//     await _registerServices();
//     await _loadSettings();
//   }
//
//   static _registerServices() async {
//     List<String> address = [];
//     Position position = await Geolocator.getCurrentPosition();
//     // print(position);
//
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     for (int i = 0; i < placemarks.length; i++) {
//       print(placemarks[i]);
//       if (placemarks[i].administrativeArea!.isNotEmpty &&
//           placemarks[i].subAdministrativeArea!.isNotEmpty &&
//           placemarks[i].locality!.isNotEmpty) {
//         print(placemarks[i]);
//         address.add(placemarks[i].administrativeArea!);
//         address.add(placemarks[i].subAdministrativeArea!);
//         address.add(placemarks[i].locality!);
//       }
//     }
//   }
//
//   static _loadSettings() async {}
//
//   Future<List<String>> getLocation() async {
//     List<String> address = [];
//     Position position = await Geolocator.getCurrentPosition();
//     // print(position);
//
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     for (int i = 0; i < placemarks.length; i++) {
//       print(placemarks[i]);
//       if (placemarks[i].administrativeArea!.isNotEmpty &&
//           placemarks[i].subAdministrativeArea!.isNotEmpty &&
//           placemarks[i].locality!.isNotEmpty) {
//         print(placemarks[i]);
//         address.add(placemarks[i].administrativeArea!);
//         address.add(placemarks[i].subAdministrativeArea!);
//         address.add(placemarks[i].locality!);
//       }
//     }
//     return address;
//   }
// }
