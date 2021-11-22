import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:flutter/rendering.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/screens/chat/chat.dart';
import 'package:fooddelivery/screens/chat/model/user_chat.dart';
import 'package:fooddelivery/screens/restaurant/list_food_restaurant.dart';
import 'package:fooddelivery/screens/restaurant/review_restaurant.dart';
import 'package:fooddelivery/screens/restaurant/voucher_restautant.dart';
import 'package:fooddelivery/screens/search/components/search_widget.dart';
import 'package:fooddelivery/screens/widget/empty_screen.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'information_restaurant.dart';

class RestaurantsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RestaurantsScreen();
  }
}

class _RestaurantsScreen extends State<RestaurantsScreen>
    with SingleTickerProviderStateMixin {
  var scrollViewColtroller = new ScrollController();

  late Rx<Restaurant?> restaurant;

  late int idRestaurant;

  RxDouble distance = 0.0.obs;

  late RxInt productCounter;

  TabController? tabController;
  int index = 0;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this, initialIndex: index);
    productCounter = 1.obs;
    title = iconSearch();
    idRestaurant = Get.arguments['restaurant_id'];

    restaurant = Rx<Restaurant>(new Restaurant());

    super.initState();
  }

  Widget iconSearch() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.zero,
      child: IconButton(
        onPressed: () {
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
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
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
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        width: 72.w,
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
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        width: 84.w,
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
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
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
    final foods = restaurant.value!.foods!.where((food) {
      final titleLower = food.name!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    this.query = query;
  }

  Future<double> distanceRes() async {
    double startLat;
    double startLong;

    String? latitude = await getValue('latitude');
    String? longitude = await getValue('longitude');

    startLat = double.parse(latitude!);
    startLong = double.parse(longitude!);

    double d = await distanceRestaurant(
        startLat,
        startLong,
        double.parse(restaurant.value!.lattitude!),
        double.parse(restaurant.value!.longtitude!));
    return d;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
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
                                automaticallyImplyLeading: false,
                                backgroundColor: Colors.white,
                                flexibleSpace: Container(
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
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      launch(
                                                          "tel: ${restaurant.value!.phone}");
                                                    },
                                                    icon: Icon(Icons.phone)),
                                                IconButton(
                                                    icon: Icon(
                                                        Icons.chat_outlined),
                                                    onPressed: () async {
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      User? user = FirebaseAuth
                                                          .instance
                                                          .currentUser!;
                                                      if (user != null) {
                                                        final querySnapshotresult =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .where('id',
                                                                    isEqualTo:
                                                                        user.uid)
                                                                .get();
                                                        if (querySnapshotresult
                                                                .docs.length ==
                                                            0) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(user.uid)
                                                              .set({
                                                            'nickname': user
                                                                .displayName,
                                                            'photoUrl':
                                                                user.photoURL,
                                                            'id': user.uid,
                                                            'createdAt': DateTime
                                                                    .now()
                                                                .millisecondsSinceEpoch
                                                                .toString(),
                                                            'chattingWith':
                                                                restaurant
                                                                    .value!
                                                                    .user!
                                                                    .uid,
                                                          });

                                                          await prefs.setString(
                                                              'id', user.uid);
                                                          await prefs.setString(
                                                              'nickname',
                                                              user.displayName ??
                                                                  "");
                                                          await prefs.setString(
                                                              'photoUrl',
                                                              user.photoURL ??
                                                                  "");
                                                        } else {
                                                          DocumentSnapshot
                                                              documentSnapshot =
                                                              querySnapshotresult
                                                                  .docs[0];
                                                          UserChat userChat =
                                                              UserChat.fromDocument(
                                                                  documentSnapshot);
                                                          await prefs.setString(
                                                              'id',
                                                              userChat.id!);
                                                          await prefs.setString(
                                                              'nickname',
                                                              userChat
                                                                  .nickname!);
                                                          await prefs.setString(
                                                              'photoUrl',
                                                              userChat.photoUrl ??
                                                                  "");
                                                        }
                                                        Get.to(Chat(
                                                          peerId: restaurant
                                                              .value!
                                                              .user!
                                                              .uid!,
                                                          peerNickname:
                                                              restaurant
                                                                  .value!
                                                                  .user!
                                                                  .username!,
                                                          peerAvatar: restaurant
                                                                  .value!
                                                                  .user!.avatar != null
                                                              ?Apis
                                                              .baseURL +
                                                              restaurant
                                                                  .value!
                                                                  .user!
                                                                  .avatar!:"",
                                                        ));
                                                      }
                                                    }),
                                              ],
                                            )
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
                                              '${distance}km',
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
                                  width: 414.w,
                                  color: Colors.white,
                                  child: TabBar(
                                    isScrollable: true,
                                    unselectedLabelColor: Colors.black87,
                                    indicatorColor: Colors.blue,
                                    labelColor: Colors.blue,
                                    controller: tabController,
                                    tabs: myTabs,
                                  ),
                                ),
                              ),
                            ];
                          },
                          body: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: tabController,
                            children: [
                              restaurant.value!.foods!.length > 0
                                  ? ListFoodRestaurant(
                                      restaurant: restaurant.value!,
                                      distance: distance.value,
                                    )
                                  : EmptyScreen(
                                      text: 'Nhà hàng chưa có món ăn!'),
                              ReviewRestaurant(
                                restaurantId: restaurant.value!.id!,
                              ),
                              VoucherRestaurant(
                                  restaurantId: restaurant.value!.id!),
                              InformationRestaurant(
                                restaurant: restaurant.value!,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        });
  }

  Future<bool?> fetchRestaurant() async {
    var res = await getRestaurant(idRestaurant);
    if (res != null) {
      restaurant = res.obs;
    }
    double d = await distanceRes();
    distance = d.obs;
    return restaurant.isBlank;
  }

  Future<Restaurant?> getRestaurant(int restaurantId) async {
    Restaurant restaurant;
    String token = (await getToken())!;
    Map<String, String> queryParams = {
      'restaurant_id': restaurantId.toString(),
    };
    String queryString = Uri(queryParameters: queryParams).query;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getRestaurantUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        restaurant = RestaurantJson.fromJson(parsedJson).restaurant!;
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
}
