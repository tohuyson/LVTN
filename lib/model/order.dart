import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/restaurants.dart';
import 'package:fooddelivery/model/users.dart';

class Order {
  final int id;
  final Users user;
  final Restaurants restaurant;
  final String category;
  final Map<int,Food> listFood;
  final double price;
  final String method;
  final bool status;

  Order(
      {this.id,
      this.user,
      this.restaurant,
      this.category,
      this.listFood,
      this.price,
      this.method,
      this.status});
}
