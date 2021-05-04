import 'package:flutter/material.dart';
import 'package:fooddelivery/model/FakeData.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/screens/food_item.dart';

class FoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      child: Column(
        children: <Widget>[
          FoodItemTitle(),
          Expanded(
              child: FoodItem(
            store: store,
          ))
        ],
      ),
    );
  }
}
