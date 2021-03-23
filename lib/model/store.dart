import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/model/food.dart';

class Store {
  int id;
  String name;
  String address;
  List<Food> list;
  Store(
      @required this.id,
      @required this.name,
      @required this.address,
      this.list,
      );
}