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
import 'package:fooddelivery/screens/auth/is_signin.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:fooddelivery/splash_screen.dart';
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
        // home: SplashScreen(),
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
  // late Position _currentPosition ;
  RxString address = ''.obs;

  @override
  void initState() {
    super.initState();
    checkPermission();
    // loadData();
    // Timer(
    //     Duration(seconds: 5),
    //     () => Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => MyHomePage())));
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
                  child: Obx(() => Text(
                        address.value != '' ? address.value : 'Loading...',
                        overflow: TextOverflow.ellipsis,
                      )),
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
                  address = 'Vị trí ngƯời dùng không xác định'.obs;
                });
              },
            ),
            new TextButton(
              child: new Text("Đồng ý"),
              onPressed: () {
                Get.back();
                loadData();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      _showDialog();
    }
  }

  Future<void> loadData() async {
    // List<String> a = await getLocation();
    // print(a);
    // String ad = '';
    // if (a.length > 0) {
    //   for (int i = a.length - 1; i >= 0; i--) {
    //     ad = ad + a[i] + ',';
    //   }
    //   print(ad);
    //   address = ad.obs;
    //   Get.to(MyHomePage());
    // }
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showToast('Vui lòng bật vị trí!');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast('Vui lòng cung cấp vị trí!');
      }
    }

    Position position = await getPosition();
    String street = await getStreet(position);
    String locality = await getLocality(position);
    String a = await getAddress(position);
    setState(() {
      address = (street + ', ' + locality + ', ' + a).obs;
      setValue('address', address.value);
    });

    print(address.value);
    Timer(Duration(seconds: 5), () => Get.to(MyHomePage()));
  }

  Future<String> getStreet(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].street!.isNotEmpty) {
        return placemarks[i].street!;
      }
    }
    return '';
  }

  Future<String> getLocality(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].locality!.isNotEmpty) {
        return placemarks[i].locality!;
      }
    }
    return '';
  }

  Future<Position> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    return position;
  }

  Future<String> getAddress(Position position) async {
    // List<String> address = [];
    String address = '';

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
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

  @override
  void initState() {
    super.initState();

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

    ///When the app is in background but opened and user taps
    ///on the notification
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
