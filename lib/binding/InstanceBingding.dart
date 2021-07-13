import 'package:fooddelivery/controllers/address_controller.dart';
import 'package:fooddelivery/controllers/auth_controller.dart';
import 'package:fooddelivery/controllers/home_controller.dart';
import 'package:fooddelivery/controllers/order_controller.dart';
import 'package:fooddelivery/controllers/profile_controllor.dart';
import 'package:fooddelivery/controllers/restaurant_controller.dart';
import 'package:fooddelivery/controllers/sign_in_controller.dart';
import 'package:get/get.dart';

class InstanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AddressController>(() => AddressController());
    Get.lazyPut<OrderController>(() => OrderController());
    Get.lazyPut<RestaurantController>(() => RestaurantController());
  }
}
