class Category {
  int? id;
  String? name;
  String? image;
  String? description;
  int? restaurantId;

  Category({
    this.id,
    this.name,
    this.image,
    this.description,
    this.restaurantId,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    restaurantId = json['restaurant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['restaurant_id'] = this.restaurantId;
    return data;
  }
}
