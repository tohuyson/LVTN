class Payment {
  int? id;
  int? price;
  String? description;
  int? userId;
  String? method;
  String? status;

  Payment({
    this.id,
    this.price,
    this.description,
    this.userId,
    this.method,
    this.status,
  });

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    description = json['description'];
    userId = json['user_id'];
    method = json['method'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['method'] = this.method;
    data['status'] = this.status;
    return data;
  }
}
