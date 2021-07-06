import 'package:fooddelivery/controllers/auth_controller.dart';
import 'package:fooddelivery/controllers/home_controller.dart';
import 'package:fooddelivery/controllers/sign_in_controller.dart';
import 'package:get/get.dart';

class InstanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
