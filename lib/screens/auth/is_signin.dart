import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/controllers/auth_controller.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class IsSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkIsSign(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data == true ? BottomNavigation(selectedIndex: 2,) : SignIn();
          } else {
            return Container();
          }
        });
  }

  Future<bool> checkIsSign() async {
    String token = (await getToken())!;
    return token.isNotEmpty;
  }
}
