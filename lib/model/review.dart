import 'package:fooddelivery/model/image.dart';
import 'package:fooddelivery/model/users.dart';

class ListReview {
  List<Review>? review;

  ListReview({ this.review});

  ListReview.fromJson(Map<String, dynamic> json) {
    if (json['review'] != null) {
      review = new List.generate(0, (index) => new Review());
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Review {
  int? id;
  String? review;
  String? rate;
  int? restaurantId;
  int? userId;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Image>? image;
  Users? user;

  Review(
      {this.id,
        this.review,
        this.rate,
        this.restaurantId,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.user});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    rate = json['rate'];
    restaurantId = json['restaurant_id'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['image'] != null) {
      image = new List.generate(0, (index) => new Image());
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    user = json['user'] != null ? new Users.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review'] = this.review;
    data['rate'] = this.rate;
    data['restaurant_id'] = this.restaurantId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}