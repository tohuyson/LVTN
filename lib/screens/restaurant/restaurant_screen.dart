import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/controllers/restaurant_controller.dart';
import 'package:flutter/rendering.dart';
import 'package:fooddelivery/model/card.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/list_foods.dart';
import 'package:fooddelivery/model/list_restaurant.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/screens/chat/chat.dart';
import 'package:fooddelivery/screens/chat/model/user_chat.dart';
import 'package:fooddelivery/screens/order/order_detail.dart';
import 'package:fooddelivery/screens/order/order_detail_delivered.dart';
import 'package:fooddelivery/screens/restaurant/component/food_restaurant.dart';
import 'package:fooddelivery/screens/search/components/search_widget.dart';
import 'package:fooddelivery/screens/widget/empty_screen.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RestaurantsScreen();
  }
}

class _RestaurantsScreen extends State<RestaurantsScreen> {
  var scrollViewColtroller = new ScrollController();

  late Rx<Restaurant?> restaurant;

  late RxList<Food> food = new RxList<Food>();
  late int restaurant_id;

  late CardModel card;
  late int idRestaurant;

  @override
  void initState() {
    title = iconSearch();
    card = new CardModel();
    idRestaurant = Get.arguments['restaurant_id'];
    // checkResIni();
    super.initState();
  }

  Widget iconSearch() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.zero,
      child: IconButton(
        onPressed: () {
          print('search');
        },
        icon: Icon(
          Icons.search,
          size: 30.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Container(
        width: 60.w,
        child: Text(
          'Đặt đơn',
          style: TextStyle(color: Colors.black, fontSize: 16.sp),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70.w,
        child: Text(
          'Bình luận',
          style: TextStyle(color: Colors.black, fontSize: 16.sp),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 90.w,
        child: Text(
          'Khuyến mãi',
          style: TextStyle(color: Colors.black, fontSize: 16.sp),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70.w,
        child: Text(
          'Thông tin',
          style: TextStyle(color: Colors.black, fontSize: 16.sp),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ];

  Widget? title;

  String query = '';

  Widget buildSearch() => SearchWidget(
        text: query,
        focus: false,
        hintText: 'Tìm nhà hàng món ăn',
        onChanged: searchFood,
      );

  void searchFood(String query) {
    print(query);
    final foods = restaurant.value!.foods!.where((food) {
      final titleLower = food.name!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    this.query = query;
  }

  Future<void> checkResIni() async {
    await fetchRestaurant(idRestaurant);
    await fetchFood(idRestaurant);

    await fetchCard(idRestaurant);

    print('render card $card');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkResIni(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else {
            if (snapshot.hasError) {
              return Container();
            } else {
              return Scaffold(
                body: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      Container(
                        height: 896.h,
                        child: NestedScrollView(
                          controller: scrollViewColtroller,
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverAppBar(
                                elevation: 0,
                                expandedHeight: 220.h,
                                pinned: true,
                                title: title,
                                flexibleSpace: new FlexibleSpaceBar(
                                  background: Obx(
                                    () => Image.network(
                                      Apis.baseURL + restaurant.value!.image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                actions: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: IconButton(
                                      onPressed: () {
                                        print('...');
                                      },
                                      icon: Icon(
                                        Icons.keyboard_control,
                                        size: 30.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SliverAppBar(
                                // expandedHeight: 72.h,
                                automaticallyImplyLeading: false,
                                backgroundColor: Colors.white,
                                flexibleSpace: Container(
                                  // padding: EdgeInsets.all(10.w),
                                  width: 414.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 392.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(
                                              () => Text(
                                                restaurant.value!.name!,
                                                style: TextStyle(
                                                    fontSize: 22.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            IconButton(
                                                icon: Icon(Icons.chat_outlined),
                                                onPressed: () async {
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  print('chát');
                                                  User? user = FirebaseAuth
                                                      .instance.currentUser!;
                                                  print(user);
                                                  if (user != null) {
                                                    // Check is already sign up
                                                    final querySnapshotresult =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .where('id',
                                                                isEqualTo:
                                                                    user.uid)
                                                            .get();
                                                    print(querySnapshotresult
                                                        .docs);
                                                    // final List<DocumentSnapshot>documents = result.docs;
                                                    if (querySnapshotresult
                                                            .docs.length ==
                                                        0) {
                                                      // Update data to server if new user
                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(user.uid)
                                                          .set({
                                                        'nickname':
                                                            user.displayName,
                                                        'photoUrl':
                                                            user.photoURL,
                                                        'id': user.uid,
                                                        'createdAt': DateTime
                                                                .now()
                                                            .millisecondsSinceEpoch
                                                            .toString(),
                                                        'chattingWith':
                                                            restaurant.value!
                                                                .user!.uid,
                                                      });

                                                      // Write data to local
                                                      // currentUser = user;
                                                      // print(currentUser.uid);
                                                      await prefs.setString(
                                                          'id', user.uid);
                                                      await prefs.setString(
                                                          'nickname',
                                                          user.displayName ??
                                                              "");
                                                      await prefs.setString(
                                                          'photoUrl',
                                                          user.photoURL ?? "");
                                                    } else {
                                                      DocumentSnapshot
                                                          documentSnapshot =
                                                          querySnapshotresult
                                                              .docs[0];
                                                      UserChat userChat =
                                                          UserChat.fromDocument(
                                                              documentSnapshot);
                                                      // Write data to local
                                                      print(userChat.id);
                                                      await prefs.setString(
                                                          'id', userChat.id!);
                                                      await prefs.setString(
                                                          'nickname',
                                                          userChat.nickname!);
                                                      await prefs.setString(
                                                          'photoUrl',
                                                          userChat.photoUrl ??
                                                              "");
                                                    }
                                                    String avatar =
                                                        Apis.baseURL +
                                                            restaurant.value!
                                                                .user!.avatar!;
                                                    Get.to(Chat(
                                                      peerId: restaurant
                                                          .value!.user!.uid!,
                                                      peerAvatar: avatar,
                                                    ));
                                                  }
                                                })
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 392.w,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 22.sp,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Obx(
                                              () => Text(
                                                restaurant.value!.rating!,
                                                style:
                                                    TextStyle(fontSize: 14.sp),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              '-',
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              '2.5km',
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SliverAppBar(
                                pinned: true,
                                automaticallyImplyLeading: false,
                                backgroundColor: Colors.white,
                                elevation: 0,
                                toolbarHeight: 20,
                                flexibleSpace: Container(
                                  padding:
                                      EdgeInsets.only(top: 8.h, bottom: 8.h),
                                  child: TabBar(
                                    isScrollable: true,
                                    unselectedLabelColor: Colors.black,
                                    tabs: myTabs,
                                  ),
                                ),
                              ),
                            ];
                          },
                          body: TabBarView(
                            children: [
                              food.isNotEmpty == true
                                  ? ListView.builder(
                                      itemCount: food.length,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          padding: EdgeInsets.only(
                                            left: 12.w,
                                            right: 12.w,
                                            top: 10.h,
                                            bottom: 12.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color:
                                                      kPrimaryColorBackground),
                                            ),
                                          ),
                                          height: 102.h,
                                          child: Row(
                                            children: [
                                              Image.network(
                                                Apis.baseURL +
                                                    food[i].images![0].url!,
                                                fit: BoxFit.cover,
                                                width: 80,
                                                height: 80,
                                              ),
                                              Container(
                                                width: 300.w,
                                                padding:
                                                    EdgeInsets.only(left: 12.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      food[i].name!,
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      '10+ đã bán',
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color:
                                                              Colors.black38),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          food[i]
                                                                  .price
                                                                  .toString() +
                                                              'đ',
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            print('add');
                                                            var result =
                                                                await Get.to(
                                                                    FoodDetail(
                                                              food: food[i],
                                                            ));
                                                            setState(() {
                                                              if (result !=
                                                                  null) {
                                                                CardModel c =
                                                                    result;
                                                                fetchCard(c
                                                                    .restaurantId!);
                                                              }
                                                            });
                                                            // showPicker(context, food![i]!);
                                                          },
                                                          child: Icon(
                                                            Icons.add_circle,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                  // FoodRestaurant(
                                  //         food: food,
                                  //       )
                                  : EmptyScreen(
                                      text: 'Nhà hàng chưa có món ăn!'),
                              // Text('2'),
                              Text('2'),
                              Text('3'),
                              Text('4'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: card.id != null
                    ? FloatingActionButton.extended(
                        onPressed: () {},
                        label: Container(
                          height: 76.h,
                          width: 414.w,
                          color: Colors.white,
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 16.h,
                                  left: 16.w,
                                  right: 16.w),
                              height: 50.h,
                              width: 382.w,
                              decoration: BoxDecoration(
                                  // color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100.w,
                                    padding: EdgeInsets.only(left: 12.w),
                                    child: Text(
                                      '${card.cardOrder!.length} món',
                                      style: TextStyle(
                                          fontSize: 16.sp, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: 100.w,
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: Text(
                                      '${card.sumPrice}đ',
                                      style: TextStyle(
                                          fontSize: 16.sp, color:  Colors.black),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(OrderDetail(),
                                          arguments: {'card_id': card.id});
                                    },
                                    child: Container(
                                      height: 46.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: Center(
                                        child: Text(
                                          'Đặt hàng',
                                          style: TextStyle(
                                              color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      )
                    : Container(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
              );
            }
          }
        });
  }
  void _modalBottomSheetMenu(){
      showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
          ),
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return DraggableScrollableSheet(
                      expand: false,
                      builder:
                          (BuildContext context, ScrollController scrollController) {
                        return Column(children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(children: <Widget>[
                                Expanded(
                                    child: TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(8),
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(15.0),
                                            borderSide: new BorderSide(),
                                          ),
                                          prefixIcon: Icon(Icons.search),
                                        ),
                                        onChanged: (value) {
                                        })),
                                IconButton(
                                    icon: Icon(Icons.close),
                                    color: Color(0xFF1F91E7),
                                    onPressed: () {

                                    }),
                              ])),
                          // Expanded(
                          //   child: ListView.separated(
                          //       controller: scrollController,
                          //       //5
                          //       itemCount: (_tempListOfCities != null &&
                          //           _tempListOfCities.length > 0)
                          //           ? _tempListOfCities.length
                          //           : _listOfCities.length,
                          //       separatorBuilder: (context, int) {
                          //         return Divider();
                          //       },
                          //       itemBuilder: (context, index) {
                          //         return InkWell(
                          //
                          //           //6
                          //             child: (_tempListOfCities != null &&
                          //                 _tempListOfCities.length > 0)
                          //                 ? _showBottomSheetWithSearch(
                          //                 index, _tempListOfCities)
                          //                 : _showBottomSheetWithSearch(
                          //                 index, _listOfCities),
                          //             onTap: () {
                          //               //7
                          //               _scaffoldKey.currentState.showSnackBar(
                          //                   SnackBar(
                          //                       behavior: SnackBarBehavior.floating,
                          //                       content: Text((_tempListOfCities !=
                          //                           null &&
                          //                           _tempListOfCities.length > 0)
                          //                           ? _tempListOfCities[index]
                          //                           : _listOfCities[index])));
                          //
                          //               Navigator.of(context).pop();
                          //             });
                          //       }),
                          // )
                        ]);
                      });
                });
          });
  }

  Future<void> fetchRestaurant(int idRestaurant) async {
    var res = await getRestaurant(idRestaurant);
    print(res);
    if (res != null) {
      restaurant = res.obs;
      restaurant.refresh();
    }
  }

  Future<Restaurant?> getRestaurant(int restaurantId) async {
    Restaurant restaurant;
    String token = (await getToken())!;
    Map<String, String> queryParams = {
      'restaurant_id': restaurantId.toString(),
    };
    String queryString = Uri(queryParameters: queryParams).query;
    try {
      // EasyLoading.show(status: 'Loading...');
      http.Response response = await http.get(
        Uri.parse(Apis.getRestaurantUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        // EasyLoading.dismiss();
        print(response.body);
        var parsedJson = jsonDecode(response.body);
        print(parsedJson['restaurants']);
        restaurant = RestaurantJson.fromJson(parsedJson).restaurant!;
        print(restaurant);
        return restaurant;
      }
      if (response.statusCode == 401) {
        showToast("Tải dữ liệu thất bại");
      }
      if (response.statusCode == 500) {
        showToast("Hệ thống bị lỗi, Vui lòng quay lại sau!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }

  Future<void> fetchFood(int idRestaurant) async {
    var f = await getFood(idRestaurant);
    print(f);
    if (f != null) {
      food.assignAll(f);
      food.refresh();
    }
  }

  Future<List<Food>?> getFood(int restaurantId) async {
    List<Food> listFood;
    String token = (await getToken())!;
    Map<String, String> queryParams = {
      'restaurant_id': restaurantId.toString(),
    };
    String queryString = Uri(queryParameters: queryParams).query;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getFoodUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        // EasyLoading.dismiss();
        print(response.body);
        var parsedJson = jsonDecode(response.body);
        print(parsedJson['restaurants']);
        listFood = ListFoods.fromJson(parsedJson).listFood!;
        print(listFood);
        return listFood;
      }
      if (response.statusCode == 401) {
        showToast("Tải dữ liệu thất bại");
      }
      if (response.statusCode == 500) {
        showToast("Hệ thống bị lỗi, Vui lòng quay lại sau!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }

  Future<void> fetchCard(int restaurant_id) async {
    print('chayj ddaay vaayj  banj ');
    var c = await getCard(restaurant_id);
    print(c);
    if (c != null) {
      card = c;
    }
    print('card $card');
  }

  Future<CardModel?> getCard(int restaurant_id) async {
    var token = await getToken();
    Map<String, String> queryParams = {
      'restaurant_id': restaurant_id.toString(),
    };
    String queryString = Uri(queryParameters: queryParams).query;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getCardUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // EasyLoading.dismiss();
        print(response.body);
        var parsedJson = jsonDecode(response.body);
        // print(parsedJson['card']);
        CardModel card = CardJson.fromJson(parsedJson).card!;
        print(card);
        return card;
      }
      if (response.statusCode == 401) {
        return null;
      }
      if (response.statusCode == 500) {
        showToast("Hệ thống bị lỗi, Vui lòng quay lại sau!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }
}
