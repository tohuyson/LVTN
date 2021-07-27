import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/address/address_screen.dart';
import 'package:fooddelivery/screens/home/home_screen.dart';
import 'package:fooddelivery/screens/notify/notify_screen.dart';
import 'package:fooddelivery/screens/order/order_screen.dart';
import 'package:fooddelivery/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  final Rx<int> tabIndex = 2.obs;
  List<Widget> widgetOptions = <Widget>[
    OrderScreen(),
    AddressScreen(),
    HomeScreen(),
    NotifyScreen(),
    ProfileScreen(),
  ];

  void setPage(int index) {
    tabIndex.value = index;

    // tabIndex(index);
  }
}
