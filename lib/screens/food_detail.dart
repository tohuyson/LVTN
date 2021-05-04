import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/model/food.dart';

class FoodDetail extends StatelessWidget {
  final Food food;

  FoodDetail({ this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Card(
          margin: EdgeInsets.zero,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset('assets/images/' + food.image),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
        ),
      ),
      body: Container(
        child: Text(food.name),
      ),
    );
  }
}
