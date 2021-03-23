import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/food_detail.dart';
import 'package:fooddelivery/animation/ScaleRoute.dart';
import 'package:fooddelivery/screens/food_listview.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.cyan,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: SafeArea(
            child: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                "Hello, Sơn!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      print("Thông báo");
                    })
              ],
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 5,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.filter_alt,
                            color: Colors.black,
                          ),
                          hintStyle: new TextStyle(
                              color: Color(0xFFd0cece), fontSize: 16),
                          hintText: "What would your like to eat?",
                          contentPadding: EdgeInsets.all(15)),
                    ),
                  )),
            ),
          )),
      body: FoodListView(),
    );
  }
}
