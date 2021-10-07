import 'package:fooddelivery/model/address.dart';

class ListAddress {
  List<Address>? listAddress;

  ListAddress({this.listAddress});

  ListAddress.fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      listAddress = List.generate(0, (index) => new Address());
      json['address'].forEach((v) {
        listAddress!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listAddress != null) {
      data['address'] = this.listAddress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
