import 'package:fooddelivery/model/pivot_food_image.dart';

class Image {
  int? id;
  String? url;
  int? foodReviewId;
  PivotFoodImage? pivot;

  Image({this.id, this.url, this.foodReviewId, this.pivot});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    foodReviewId = json['food_review_id'];
    pivot = json['pivot'] != null
        ? new PivotFoodImage.fromJson(json['pivot'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['food_review_id'] = this.foodReviewId;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}
