// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:fooddelivery/apis.dart';
// import 'package:fooddelivery/model/food.dart';
// import 'package:fooddelivery/model/list_restaurant.dart';
// import 'package:fooddelivery/model/restaurant.dart';
// import 'package:fooddelivery/model/topping.dart';
// import 'package:fooddelivery/model/users.dart';
// import 'package:fooddelivery/screens/search/components/search_widget.dart';
// import 'package:fooddelivery/utils.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class RestaurantController extends GetxController {
//   late Rx<Restaurant?>? restaurant;
//
//   final List<Tab> myTabs = <Tab>[
//     Tab(
//       child: Container(
//         width: 60.w,
//         child: Text(
//           'Đặt đơn',
//           style: TextStyle(color: Colors.black, fontSize: 16.sp),
//           maxLines: 1,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     ),
//     Tab(
//       child: Container(
//         width: 70.w,
//         child: Text(
//           'Bình luận',
//           style: TextStyle(color: Colors.black, fontSize: 16.sp),
//           maxLines: 1,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     ),
//     Tab(
//       child: Container(
//         width: 90.w,
//         child: Text(
//           'Khuyến mãi',
//           style: TextStyle(color: Colors.black, fontSize: 16.sp),
//           maxLines: 1,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     ),
//     Tab(
//       child: Container(
//         width: 70.w,
//         child: Text(
//           'Thông tin',
//           style: TextStyle(color: Colors.black, fontSize: 16.sp),
//           maxLines: 1,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     ),
//   ];
//
//   var scrollViewColtroller = new ScrollController();
//
//   Widget? title;
//
//   Widget iconSearch() {
//     return Container(
//       alignment: Alignment.centerRight,
//       padding: EdgeInsets.zero,
//       child: IconButton(
//         onPressed: () {
//           print('search');
//         },
//         icon: Icon(
//           Icons.search,
//           size: 30.sp,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   String query = '';
//
//   Widget buildSearch() => SearchWidget(
//         text: query,
//         focus: false,
//         hintText: 'Tìm nhà hàng món ăn',
//         // onChanged: searchFood,
//       );
//
//   // void searchFood(String query) {
//   //   print(query);
//   //   final foods = restaurant!.value!.foods!.where((food) {
//   //     final titleLower = food.name!.toLowerCase();
//   //     final searchLower = query.toLowerCase();
//   //
//   //     return titleLower.contains(searchLower);
//   //   }).toList();
//   //
//   //   this.query = query;
//   //   // this.foods = foods;
//   // }
//
//   bool checkScroll() {
//     if (scrollViewColtroller.position.userScrollDirection ==
//         ScrollDirection.reverse) {
//       print('User is going down');
//       title = iconSearch();
//       update();
//       return true;
//     } else {
//       if (scrollViewColtroller.position.userScrollDirection ==
//           ScrollDirection.forward) {
//         print('User is going up');
//         title = buildSearch();
//         update();
//         return false;
//       }
//     }
//     return false;
//   }
//
//   late Rx<List<Food>?> food;
//
//   RxBool isChecked = false.obs;
//
//   late RxList<Topping> listToppings;
//
//   @override
//   void onInit() {
//     Restaurant re = Get.arguments['restaurant'];
//     print(re.foods![0].toppings![0].name);
//     food = re.foods.obs;
//     // print(food.value![0].toppings![0].name);
//     restaurant = re.obs;
//     title = iconSearch();
//
//     // food = re.foods![0];
//     // print(food);
//     super.onInit();
//   }
//
//   Future<void> getFoods() async {
//     int idRestaurant = Get.arguments['id'];
//     var list = await getFoodRes();
//     // print(list);
//     print(list!.length);
//     for (int i = 0; i < list.length; i++) {
//       if (list[i].id == idRestaurant) {
//         print(list[i].name);
//         restaurant = list[i].obs;
//       }
//     }
//   }
//
//   Future<List<Restaurant>?> getFoodRes() async {
//     List<Restaurant>? listRestaurant;
//     String token = (await getToken())!;
//     try {
//       http.Response response = await http.get(
//         Uri.parse(Apis.getFoodResUrl),
//         headers: <String, String>{
//           "Accept": "application/json",
//           "Authorization": "Bearer $token",
//         },
//       );
//
//       if (response.statusCode == 200) {
//         print(response.body);
//         var parsedJson = jsonDecode(response.body);
//         print(parsedJson['restaurants']);
//         listRestaurant = ListRestaurants.fromJson(parsedJson).listRestaurants!;
//         print(listRestaurant);
//         return listRestaurant;
//       }
//       if (response.statusCode == 401) {
//         showToast("Load failed");
//       }
//       if (response.statusCode == 500) {
//         showToast("Server error, please try again later!");
//       }
//     } on TimeoutException catch (e) {
//       showError(e.toString());
//     } on SocketException catch (e) {
//       showError(e.toString());
//     }
//   }
// }
