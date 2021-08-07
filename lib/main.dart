import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/authservice.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/screens/auth/is_signin.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

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
        // home: SignIn(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
