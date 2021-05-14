import 'package:flutter/material.dart';
import 'package:fooddelivery/components/food_card.dart';
import 'package:fooddelivery/components/list_food.dart';
import 'package:fooddelivery/model/FakeData.dart';
import 'package:fooddelivery/model/store.dart';

class LatestFeeds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      // height: 270,
      // constraints: BoxConstraints(
      //   minHeight: 150,
      //   // maxHeight: 464,
      // ),
      child: Column(
        children: [
          LatestFeedsTitle(),
          FoodCard(food: store.list[3]),
          FoodCard(food: store.list[3]),

        ],
      ),
    );
  }
}

class LatestFeedsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Thức ăn phổ biến",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
