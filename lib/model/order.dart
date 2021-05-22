import 'package:fooddelivery/model/food.dart';

class Order{
  final String category;
  final Food namefood;
  final String address;
  final double price;
  final String method;

  Order({this.category, this.namefood, this.address, this.price, this.method});

}