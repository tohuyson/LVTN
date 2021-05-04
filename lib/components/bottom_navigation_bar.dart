import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  int selectedIndex=2;

  @override
  Widget build(BuildContext context) {
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        barBackgroundColor: Colors.white,
        selectedItemBorderColor: Colors.transparent,
        selectedItemBackgroundColor: Colors.blueAccent,
        selectedItemIconColor: Colors.white,
        selectedItemLabelColor: Colors.black,
        showSelectedItemShadow: false,
        selectedItemTextStyle: TextStyle(fontSize: 12.5),
        unselectedItemTextStyle: TextStyle(fontSize: 11),
        barHeight: 52,
      ),
      selectedIndex: selectedIndex,
      // onSelectTab: (index) {
      //   setState(() {
      //     selectedIndex = index;
      //     // tabController.index = index;
      //   });
      // },
      onSelectTab: (index) {
        // setState(() {
        selectedIndex = index;
        // });
      },
      items: [
        FFNavigationBarItem(
          iconData: Icons.article_outlined,
          label: 'Menu',
        ),
        FFNavigationBarItem(
          iconData: Icons.location_on,
          label: 'Map',
        ),
        FFNavigationBarItem(
          iconData: Icons.home,
          label: 'Home',
        ),
        FFNavigationBarItem(
          iconData: Icons.notifications,
          label: 'Notify',
        ),
        FFNavigationBarItem(
          iconData: Icons.person,
          label: 'Person',
        ),
      ],
    );
  }

}