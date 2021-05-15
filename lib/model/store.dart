import 'package:fooddelivery/model/food.dart';

class Store {
  int id;
  String name;
  String address;
  List<Food> list;

  Store(
    this.id,
    this.name,
    this.address,
    this.list,
  );
}
