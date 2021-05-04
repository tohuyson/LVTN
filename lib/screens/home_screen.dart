import 'package:flutter/material.dart';
import 'package:fooddelivery/components/food_card.dart';
import 'package:fooddelivery/components/list_food.dart';
import 'package:fooddelivery/components/menus.dart';
import 'package:fooddelivery/model/FakeData.dart';
import 'package:fooddelivery/screens/food_detail.dart';
import 'package:fooddelivery/screens/food_listview.dart';
import 'package:flutter/services.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';

import 'bottom_navbar_widgetstate.dart';
import 'latest_feeds.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      // backgroundColor: Colors.cyan,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: SafeArea(
            child: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                "Hôm nay, bạn ăn gì?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.card_giftcard_sharp,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      print("Thông báo");
                    }),
              ],
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              width: 5,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          // prefixIcon: Icon(
                          //   Icons.search,
                          //   color: Colors.black,
                          // ),
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintStyle: new TextStyle(
                              color: Color(0xFF485148), fontSize: 16),
                          hintText: "Tìm quán ăn, món ăn",
                          contentPadding: EdgeInsets.all(15)),
                    ),
                  )),
            ),
          )),
      body: Column(
        children: [
          Menu(),
          // Menu(),
          Expanded(
            child: LatestFeeds(),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
