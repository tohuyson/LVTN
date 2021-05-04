import 'package:flutter/cupertino.dart';

class Food {
  int id;
  String name;
  String image;
  String rating;
  String numberOfRating;
  int price;
  String slug;

  Food(
      {@required this.id,
      @required this.name,
      @required this.image,
      @required this.rating,
      @required this.numberOfRating,
      @required this.price,
      @required this.slug});
}
