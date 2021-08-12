import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/authservice.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/screens/auth/is_signin.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:fooddelivery/testzalo.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'local_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.dark, //navigation bar icons' color
    ));
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => GetMaterialApp(
        title: 'Food Delivery',
        theme: ThemeData(
          primaryColor: Color(0xFF0992E8),
        ),
        debugShowCheckedModeBanner: false,
        home: AuthService().handleAuth(),
        // home: IsSignIn(),
        //  home: MyHomePage(),
        // home: SignIn(),
//        home: Home('zalo'),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({required this.title});

  // final String title;

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
