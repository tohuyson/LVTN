import 'package:flutter/material.dart';
import 'package:fooddelivery/model/FakeData.dart';
import 'package:fooddelivery/screens/food_item.dart';

class FoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FoodItem(store: store,);
  }
}
