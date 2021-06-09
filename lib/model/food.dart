import 'package:fooddelivery/model/sizes.dart';
import 'package:fooddelivery/model/toppings.dart';

class Food {
  final int id;
  final String name;
  final String image;
  final double price;
  final int restaurantId;
  final List<Topping> listTopping;
  final Size size;

  Food(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.restaurantId,
      this.listTopping,
      this.size});
}
