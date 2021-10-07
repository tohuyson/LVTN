class PivotFoodTopping {
  int? foodId;
  int? toppingId;

  PivotFoodTopping({this.foodId, this.toppingId});

  PivotFoodTopping.fromJson(Map<String, dynamic> json) {
    foodId = json['food_id'];
    toppingId = json['topping_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_id'] = this.foodId;
    data['topping_id'] = this.toppingId;
    return data;
  }
}
