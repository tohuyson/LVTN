import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/address/address_screen.dart';
import 'package:fooddelivery/screens/home/home_screen.dart';
import 'package:fooddelivery/screens/notify/notify_screen.dart';
import 'package:fooddelivery/screens/order/order_screen.dart';
import 'package:fooddelivery/screens/profile/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;

  BottomNavigation({required this.selectedIndex});

  @override
  State<BottomNavigation> createState() =>
      _BottomNavigation(selectedIndex: selectedIndex);
}

class _BottomNavigation extends State<BottomNavigation> {
  late int selectedIndex;

  _BottomNavigation({required this.selectedIndex});

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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.article),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.location_on),
            label: 'Địa chỉ',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.person),
            label: 'Tôi',
          ),
        ],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: onItemTapped,
      ),
    );
  }
}
