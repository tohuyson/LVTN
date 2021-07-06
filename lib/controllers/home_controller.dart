import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/list_sliders.dart';
import 'package:fooddelivery/model/sliders.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  late List<Sliders> list;

  var listSliders = List?.generate(0, (index) => new Sliders()).obs;

  @override
  void onInit() {
    list = List.generate(0, (index) => new Sliders());
    fetchSliders();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // getSliders();
  }

  void fetchSliders() async {
    var sliders = await getSliders();
    if (sliders != null) {
      listSliders.value = sliders;
    }
  }

  Future<List<Sliders>?> getSliders() async {
    print('vao daya l');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = (await _prefs.getString('token'))!;
    print(token);
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getSlidersUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListSliders.fromJson(parsedJson).listSliders!;
        return list;
        print(list);
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
