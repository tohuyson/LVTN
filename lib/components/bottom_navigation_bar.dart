import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/bottom_navigation_bar_controller.dart';
import 'package:fooddelivery/screens/address/address_screen.dart';
import 'package:fooddelivery/screens/home/home_screen.dart';
import 'package:fooddelivery/screens/notify/notify_screen.dart';
import 'package:fooddelivery/screens/order/order_screen.dart';
import 'package:fooddelivery/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavigation> createState() => _MyStatefulWidgetState();
// }

class BottomNavigation extends GetView<BottomNavigationBarController> {
  BottomNavigationBarController controller =
      Get.put(BottomNavigationBarController());

  // int _selectedIndex = 2;
  // static List<Widget> _widgetOptions = <Widget>[
  //   OrderScreen(),
  //   AddressScreen(),
  //   HomeScreen(),
  //   NotifyScreen(),
  //   ProfileScreen(),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          // child: widgetOptions.elementAt(_selectedIndex),
          child: controller.widgetOptions.elementAt(controller.tabIndex.value),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
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
          currentIndex: controller.tabIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          onTap: controller.setPage,
        ),
      ),
    );
  }
}
