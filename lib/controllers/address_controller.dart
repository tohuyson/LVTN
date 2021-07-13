import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/list_address.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  late List<Address> address;
  late Rx<Users> users;
  var listAddress = List?.generate(0, (index) => new Address()).obs;

  @override
  void onInit() {
    // fetchAddress();
    getAddress();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // Future<void> fetchAddress() async {
  //   var address = await getAddress();
  //   if (address != null) {
  //     listAddress.value = address;
  //   }
  // }

  Future<void> getAddress() async {
    String token = (await getToken())!;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getAddressUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        listAddress.value = ListAddress.fromJson(parsedJson).listAddress!;
        users = UsersJson.fromJson(parsedJson).users!.obs;
        print(listAddress);
        print(users);
        // return address;
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
    return null;
  }
}
