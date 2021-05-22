import 'package:flutter/material.dart';
import 'file:///D:/flutter/LVTN/lib/screens/home/food_card.dart';
import 'package:fooddelivery/model/FakeData.dart';

class ListFood extends StatelessWidget {
  // Store store;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // scrollDirection: Axis.vertical,
        itemCount: store.list.length,
        itemBuilder: (context, index) {
          final fooditem = store.list[index];
          return FoodCard(
            food: fooditem,
          );
        });

  }
}
