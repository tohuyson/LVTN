class Address {
  int? id;
  String? detail;
  String? address;
  String? longtitude;
  String? lattitude;
  int? userId;
  int? status;

  Address(
      {this.id,
        this.detail,
      this.address,
      this.longtitude,
      this.lattitude,
      this.userId,
      this.status});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    detail = json['detail'];
    address = json['address'];
    longtitude = json['longtitude'];
    lattitude = json['lattitude'];
    userId = json['user_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['detail'] = this.detail;
    data['address'] = this.address;
    data['longtitude'] = this.longtitude;
    data['lattitude'] = this.lattitude;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    return data;
  }
}

class AddressJson {
  Address? address;

  AddressJson({this.address});

  AddressJson.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}
