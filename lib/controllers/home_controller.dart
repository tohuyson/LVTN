import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/pagination_filter.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/model/slider.dart';
import 'package:get/get.dart';

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
    changePaginationFilter(1, 10);
    scrollController = ScrollController(
      initialScrollOffset: 2, // or whatever offset you wish
      keepScrollOffset: true,
    );
    sliders = List.generate(0, (index) => new Sliders());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void nextPage() => changePaginationFilter(_page + 1, limit);

  void changePaginationFilter(int page, int limit) {
    paginationFilter.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }
}
