import 'package:flutter/material.dart';
import 'package:fooddelivery/components/food_card.dart';
import 'package:fooddelivery/model/FakeData.dart';
import 'package:fooddelivery/model/store.dart';

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
