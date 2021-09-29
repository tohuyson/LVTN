import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/authservice.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/networking.dart';
import 'package:fooddelivery/screens/auth/is_signin.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:fooddelivery/testzalo.dart';
import 'package:fooddelivery/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

import 'local_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.white, // navigation bar color
    //   statusBarColor: Colors.transparent, // status bar color
    //   statusBarIconBrightness: Brightness.dark, // status bar icons' color
    //   systemNavigationBarIconBrightness:
    //       Brightness.dark, //navigation bar icons' color
    // ));
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => GetMaterialApp(
        title: 'Food Delivery',
        theme: ThemeData(
          primaryColor: Color(0xFF0992E8),
        ),
        debugShowCheckedModeBanner: false,
        // home: AuthService().handleAuth(),
        // home: IsSignIn(),
        // home: MyHomePage(),
        home: MyHome(),
        // home: SignIn(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHome> {
  RxString address = ''.obs;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: FutureBuilder(
      //   future: loadData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return Stack(
      //         children: [
      //           Positioned(
      //             top: 250.h,
      //             height: 896.h,
      //             width: 414.w,
      //             child: Container(
      //                 child: Column(
      //               children: [
      //                 Image.asset(
      //                   'assets/images/placeholder.png',
      //                   width: 100,
      //                   height: 100,
      //                 ),
      //                 Text(addres),
      //               ],
      //             )),
      //           ),
      //         ],
      //       );
      //     } else
      //       return Stack(
      //         children: [
      //           Positioned(
      //             top: 250.h,
      //             height: 896.h,
      //             width: 414.w,
      //             child: Container(
      //                 child: Column(
      //               children: [
      //                 Image.asset(
      //                   'assets/images/placeholder.png',
      //                   width: 100,
      //                   height: 100,
      //                 ),
      //               ],
      //             )),
      //           ),
      //         ],
      //       );
      //   },
      // ),
      body: Stack(
        children: [
          Positioned(
            top: 250.h,
            height: 896.h,
            width: 414.w,
            child: Container(
                child: Column(
              children: [
                Image.asset(
                  'assets/images/placeholder.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Obx(
                    () => Text(
                      address.value != '' ? address.value : 'Loading...',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Vị trí"),
          content: new Text(
              "Bạn đang tắt quyền truy cập vị trí\n\nViệc cho phép truy cập vị trí sẽ giúp định vị đúng vị trí để giao  hàng chính xác hơn."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Hủy"),
              onPressed: () {
                Get.back();
                setState(() {
                  address = 'Vị trí người dùng không xác định'.obs;
                });
                Timer(Duration(seconds: 5), () => Get.offAll(MyHomePage()));
              },
            ),
            new TextButton(
              child: new Text("Đồng ý"),
              onPressed: () async {
                Get.back();
                await loadData();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showToast('Vui lòng bật vị trí!');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      _showDialog();
    } else {
      loadData();
    }
  }

  String latitude = '';
  String longitude = '';

  Future<void> loadData() async {
    List<Placemark> placemark = await getPosition();
    String street = await getStreet(placemark);
    String locality = await getLocality(placemark);
    String a = await getAddress(placemark);
    String add = locality + ', ' + a;
    setState(() {
      address = (street + ', ' + locality + ', ' + a).obs;
    });
    await setValue('street', street);
    await setValue('address', add);
    await setValue('latitude', latitude);
    await setValue('longitude', longitude);

    print(address.value);
    Timer(Duration(seconds: 3), () => Get.to(MyHomePage()));
  }

  Future<String> getStreet(List<Placemark> placemarks) async {
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].street!.isNotEmpty) {
        return placemarks[i].street!;
      }
    }
    return '';
  }

  Future<String> getLocality(List<Placemark> placemarks) async {
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].locality!.isNotEmpty) {
        return placemarks[i].locality!;
      }
    }
    return '';
  }

  Future<String> getAddress(List<Placemark> placemarks) async {
    // List<String> address = [];
    String address = '';

    for (int i = 0; i < placemarks.length; i++) {
      print(placemarks[i]);
      if (placemarks[i].administrativeArea!.isNotEmpty &&
          placemarks[i].subAdministrativeArea!.isNotEmpty &&
          placemarks[i].country!.isNotEmpty) {
        print('vào dât đi bạn');
        // address.add(placemarks[i].administrativeArea!);
        // address.add(placemarks[i].subAdministrativeArea!);
        // address.add(placemarks[i].locality!);
        address = placemarks[i].subAdministrativeArea! +
            ', ' +
            placemarks[i].administrativeArea! +
            ', ' +
            placemarks[i].country!;
      }
    }
    return address;
  }

  Future<List<Placemark>> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        // desiredAccuracy: LocationAccuracy.low,
        // forceAndroidLocationManager: true
        );
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks;
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? user = FirebaseAuth.instance.currentUser;

  _registerOnFirebase() {
    FirebaseMessaging.instance.subscribeToTopic(user!.uid);
    FirebaseMessaging.instance.getToken().then((token) => print(token));
  }

  Future<void> checkPermision() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermision();
    if (user != null) {
      _registerOnFirebase();
    }

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthService().handleAuth(),
    );
  }
}
