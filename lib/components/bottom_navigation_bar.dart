import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/order.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:fooddelivery/screens/address.dart';
import 'package:fooddelivery/screens/notify.dart';
import 'package:fooddelivery/screens/profile.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigationBar();
}

class _NavigationBar extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 2;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        new TabController(length: 5, vsync: this, initialIndex: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new TabBarView(
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Order(selectedIndex),
          Address(selectedIndex),
          HomeScreen(selectedIndex),
          Notify(selectedIndex),
          Profile(selectedIndex),
        ],
      ),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.transparent,
          selectedItemBackgroundColor: Colors.blueAccent,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
          showSelectedItemShadow: false,
          selectedItemTextStyle: TextStyle(fontSize: 12),
          unselectedItemTextStyle: TextStyle(fontSize: 11),
          barHeight: 50
          ,
        ),
        onSelectTab: (int index) {
          setState(() {
            selectedIndex = index;
            tabController.index = index;
          });
        },
        selectedIndex: selectedIndex,
        // onSelectTab: (int index) {
        //   setState(() {
        //   selectedIndex = index;
        //   // tabController.index = index;
        //   });
        // },
        // onSelectTab: (index) {
        //   // setState(() {
        //   selectedIndex = index;
        //   // });
        // },
        items: [
          FFNavigationBarItem(
            iconData: Icons.article_outlined,
            label: 'Đơn hàng',
          ),
          FFNavigationBarItem(
            iconData: Icons.location_on,
            label: 'Địa chỉ',
          ),
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Trang chủ',
          ),
          FFNavigationBarItem(
            iconData: Icons.notifications,
            label: 'Thông báo',
          ),
          FFNavigationBarItem(
            iconData: Icons.person,
            label: 'Tôi',
          ),
        ],
      ),
    );
  }
}
