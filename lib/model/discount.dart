class Discount {
  int? id;
  String? name;
  String? code;
  int? percent;
  String? image;
  String? status;
  String? startDate;
  String? endDate;
  int? restaurantId;
  int? typeDiscountId;

  Discount(
      {this.id,
        this.name,
        this.code,
        this.percent,
        this.image,
        this.status,
        this.startDate,
        this.endDate,
        this.restaurantId,
        this.typeDiscountId,
       });

  Discount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    percent = json['percent'];
    image = json['image'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    restaurantId = json['restaurant_id'];
    typeDiscountId = json['type_discount_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['percent'] = this.percent;
    data['image'] = this.image;
    data['status'] = this.status;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['restaurant_id'] = this.restaurantId;
    data['type_discount_id'] = this.typeDiscountId;
    return data;
  }
}
class ListDiscount {
  List<Discount>? discounts;

  ListDiscount({this.discounts});

  ListDiscount.fromJson(Map<String, dynamic> json) {
    if (json['discounts'] != null) {
      discounts = new List.generate(0, (index) => new Discount());
      json['discounts'].forEach((v) {
        discounts!.add(new Discount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.discounts != null) {
      data['discounts'] = this.discounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
