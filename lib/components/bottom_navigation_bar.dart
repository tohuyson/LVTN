import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/bottom_navigation_bar_controller.dart';
import 'package:fooddelivery/screens/address/address_screen.dart';
import 'package:fooddelivery/screens/home/home_screen.dart';
import 'package:fooddelivery/screens/notify/notify_screen.dart';
import 'package:fooddelivery/screens/order/order_screen.dart';
import 'package:fooddelivery/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatefulWidget {
  late int selectedIndex;

  BottomNavigation({required this.selectedIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigation(selectedIndex: selectedIndex);
}

class _BottomNavigation extends State<BottomNavigation> {
  late int selectedIndex;

  _BottomNavigation({required this.selectedIndex});
  

  // int _selectedIndex = 2;
  static List<Widget> widgetOptions = <Widget>[
    OrderScreen(),
    AddressScreen(),
    HomeScreen(),
    NotifyScreen(),
    ProfileScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
        // child: controller.widgetOptions.elementAt(controller.tabIndex.value),
      ),
      bottomNavigationBar:  BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Địa chỉ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Thông báo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Tôi',
            ),
          ],
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          onTap: onItemTapped,
        ),
    );
  }
}
