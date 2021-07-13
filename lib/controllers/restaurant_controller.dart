import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/list_restaurant.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RestaurantController extends GetxController {
  late List<Restaurant> listRestaurant;

  @override
  void onInit() {
    super.onInit();
    listRestaurant = new List.generate(0, (index) => new Restaurant()).obs;
    getFoodRes();
  }

  Future<void> getFoodRes() async {
    String token = (await getToken())!;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getFoodResUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        listRestaurant =
            ListRestaurants.fromJson(parsedJson).listRestaurants!.obs;
        print(listRestaurant);
      }
      if (response.statusCode == 401) {
        showToast("Load failed");
      }
      if (response.statusCode == 500) {
        showToast("Server error, please try again later!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }
}
