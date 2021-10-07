class PivotFoodImage {
  int? foodId;
  int? imageId;

  PivotFoodImage({this.foodId, this.imageId});

  PivotFoodImage.fromJson(Map<String, dynamic> json) {
    foodId = json['food_id'];
    imageId = json['image_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_id'] = this.foodId;
    data['image_id'] = this.imageId;
    return data;
  }
}
