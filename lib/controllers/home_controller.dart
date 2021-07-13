import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/list_foods.dart';
import 'package:fooddelivery/model/list_restaurant.dart';
import 'package:fooddelivery/model/list_sliders.dart';
import 'package:fooddelivery/model/pagination_filter.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/model/slider.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  late List<Sliders> sliders;

  late List<Food> foods;

  late List<Restaurant> restaurants;

  var listSliders = List?.generate(0, (index) => new Sliders()).obs;

  var listFoods = List?.generate(0, (index) => new Food()).obs;

  var listRestaurants = List?.generate(0, (index) => new Restaurant()).obs;

  late ScrollController scrollController;

  final paginationFilter = PaginationFilter().obs;

  int get limit => paginationFilter.value.limit;

  int get _page => paginationFilter.value.page;
  final _lastPage = false.obs;

  bool get lastPage => _lastPage.value;

  @override
  void onInit() {
    ever(paginationFilter, (_) => getRestaurants());
    changePaginationFilter(1, 10);
    scrollController = ScrollController(
      initialScrollOffset: 2, // or whatever offset you wish
      keepScrollOffset: true,
    );
    sliders = List.generate(0, (index) => new Sliders());
    fetchSliders();
    // fetchFoods();
    // getFood();
    fetchRestaurants();
    super.onInit();
  }

  @override
  void onReady() {
    // getFood();
    // getRestaurants();
    super.onReady();
  }

  void fetchSliders() async {
    var sliders = await getSliders();
    if (sliders != null) {
      listSliders.value = sliders;
    }
  }

  Future<List<Sliders>?> getSliders() async {
    String token = (await getToken())!;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getSlidersUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        sliders = ListSliders.fromJson(parsedJson).listSliders!;
        print(sliders);
        return sliders;
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

  Future<void> fetchFoods() async {
    var foods = await getFood();
    if (foods != null) {
      listFoods.value = foods;
      print(listFoods);
    }
  }

  Future<List<Food>?> getFood() async {
    String token = (await getToken())!;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getFoodsUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        foods = ListFoods.fromJson(parsedJson).listFood!;
        print(parsedJson['foods']);
        return foods;
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

  Future<void> fetchRestaurants() async {
    var restaurants = await getRestaurants();
    if (restaurants != null) {
      listRestaurants.value = restaurants;
      print(listRestaurants.length);
      print(listRestaurants);
    }
  }

  Future<List<Restaurant>?> getRestaurants() async {
    String token = (await getToken())!;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getRestaurantsUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print('_findUsers $paginationFilter');
        var parsedJson = jsonDecode(response.body);
        print(parsedJson['restaurants']);
        restaurants = ListRestaurants.fromJson(parsedJson).listRestaurants!;
        restaurants.sort((a, b) => (b.id!.compareTo(a.id!)));
        return restaurants;
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

  void nextPage() => changePaginationFilter(_page + 1, limit);

  void changePaginationFilter(int page, int limit) {
    paginationFilter.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }
}
