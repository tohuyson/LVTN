import 'package:fooddelivery/model/category.dart';
import 'package:fooddelivery/model/image.dart';
import 'package:fooddelivery/model/restaurant.dart';

class Food {
  int? id;
  String? name;
  String? size;
  int? price;
  int? weight;
  String? ingredients;
  String? status;
  String? note;
  int? restaurantId;
  int? categoryId;
  List<Image>? image;
  Restaurant? restaurant;
  Category? category;

  Food(
      {this.id,
      this.name,
      this.size,
      this.price,
      this.weight,
      this.ingredients,
      this.status,
      this.note,
      this.restaurantId,
      this.categoryId,
      this.image,
      this.restaurant,
      this.category});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    size = json['size'];
    price = json['price'];
    weight = json['weight'];
    ingredients = json['ingredients'];
    status = json['status'];
    note = json['note'];
    restaurantId = json['restaurant_id'];
    categoryId = json['category_id'];
    if (json['image'] != null) {
      image = new List.generate(0, (index) => new Image());
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['ingredients'] = this.ingredients;
    data['status'] = this.status;
    data['note'] = this.note;
    data['restaurant_id'] = this.restaurantId;
    data['category_id'] = this.categoryId;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}
