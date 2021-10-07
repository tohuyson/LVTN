import 'package:fooddelivery/model/restaurant.dart';

class ListRestaurants {
  List<Restaurant>? listRestaurants;

  ListRestaurants({this.listRestaurants});

  ListRestaurants.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      listRestaurants = new List<Restaurant>.generate(
          0, (index) => new Restaurant(),
          growable: true);
      json['restaurants'].forEach((v) {
        listRestaurants!.add(new Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listRestaurants != null) {
      data['restaurants'] =
          this.listRestaurants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
