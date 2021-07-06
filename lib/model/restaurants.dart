import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/images.dart';

class Restaurants {
  final int? id;
  final String? name;
  final List<Images>? listImage;
  final List<Food>? listFood;
  final String? address;
  final double? long;
  final double? lat;

  Restaurants(
      {this.id,
      this.listFood,
      this.name,
      this.listImage,
      this.address,
      this.long,
      this.lat});
}
