class Address {
  int? id;
  String? address;
  String? longtitude;
  String? lattitude;
  int? userId;
  String? status;

  Address(
      {this.id,
      this.address,
      this.longtitude,
      this.lattitude,
      this.userId,
      this.status});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    longtitude = json['longtitude'];
    lattitude = json['lattitude'];
    userId = json['user_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['longtitude'] = this.longtitude;
    data['lattitude'] = this.lattitude;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    return data;
  }
}
