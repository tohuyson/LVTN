import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/authservice.dart';
import 'package:fooddelivery/controllers/profile_controllor.dart';
import 'package:fooddelivery/model/item_profile.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/chat/home.dart';
import 'package:fooddelivery/screens/delivery/delivery_screen.dart';
import 'package:fooddelivery/screens/delivery/history_delivery_screen.dart';
import 'package:fooddelivery/screens/delivery/received_screen.dart';
import 'package:fooddelivery/screens/home/home_screen.dart';
import 'package:fooddelivery/screens/profile/information_user.dart';
import 'package:fooddelivery/screens/profile/item_profile.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreen();
  }
}

late Rx<Users?> lu;
// late Rx<>Users? lu;

class _ProfileScreen extends State<ProfileScreen> {
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUsers(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text('Tôi'),
              ),
              body: FutureBuilder(
                  future: fetchUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loading();
                    } else {
                      // return buildLoading();
                      return RefreshIndicator(
                        onRefresh: () => fetch(),
                        child: ListView(
                          children: [
                            Container(
                              color: Color(0xFFFFFFFF),
                              padding: EdgeInsets.only(top: 40.h),
                              height: 210.h,
                              child: InkWell(
                                onTap: () async {
                                  await Get.to(InformationUser());
                                  print('voo ddaay nafo');
                                  // await Get.to(PersonInformation());
                                  setState(() {
                                    fetchUsers();
                                  });
                                },
                                child: Column(children: [
                                  Container(
                                    width: 90.w,
                                    height: 90.h,
                                    // padding: EdgeInsets.only(
                                    //     right: 12.w, bottom: 12.h, left: 12.w, top: 12.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: Colors.black12),
                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                    ),
                                    child: lu.value!.avatar == null
                                        ? Image.asset(
                                      "assets/images/user.png",
                                      fit: BoxFit.cover,
                                      color: Colors.black26,
                                    )
                                        : ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                      child: Image.network(
                                        Apis.baseURL + lu.value!.avatar!,
                                        height: 200.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    // padding: EdgeInsets.only(top: 20.h),
                                    child: Text(
                                      lu.value!.username!,
                                      style: TextStyle(
                                          fontSize: 22.sp, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.h),
                              color: Color(0xFFFFFFFF),
                              child: Column(
                                children: [
                                  // ItemProfile(
                                  //   itemProfile: ItemProfileModel(
                                  //     title: 'Thanh toán',
                                  //     description: '',
                                  //     page: HomeScreen(),
                                  //   ),
                                  // ),
                                  // ItemProfile(
                                  //   itemProfile: ItemProfileModel(
                                  //     title: 'Địa chỉ',
                                  //     description: '',
                                  //     page: HomeScreen(),
                                  //   ),
                                  // ),
                                  // ItemProfile(
                                  //   itemProfile: ItemProfileModel(
                                  //     title: 'Người giao hàng',
                                  //     description: '',
                                  //     page: DeliveryScreen(),
                                  //   ),
                                  // ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15.w, right: 10.w),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.3, color: Colors.black12))),
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // LineDecoration(),
                                        Container(
                                          child: Text(
                                            'Người giao hàng',
                                            style: TextStyle(fontSize: 17.sp),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                '',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    print(order.value.id);
                                                    order.value.id == null
                                                        ? Get.to(DeliveryScreen(),
                                                        arguments: {'userId': lu.value!.id})
                                                        : Get.to(ReceivedScreen(),arguments: {'userId': lu.value!.id});
                                                  },
                                                  icon: Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 14,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // ItemProfile(
                                  //   itemProfile: ItemProfileModel(
                                  //     title: 'Lịch sử giao hàng',
                                  //     description: '',
                                  //     page: HistoryDeliveryScreen(),
                                  //   ),
                                  // ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15.w, right: 10.w),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.3, color: Colors.black12))),
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // LineDecoration(),
                                        Container(
                                          child: Text(
                                            'Lịch sử giao hàng',
                                            style: TextStyle(fontSize: 17.sp),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                '',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    print(order.value.id);
                                                         Get.to(HistoryDeliveryScreen(),
                                                        arguments: {'userId': lu.value!.id});
                                                  },
                                                  icon: Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 14,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // ItemProfile(
                                  //   itemProfile: ItemProfileModel(
                                  //     title: 'Đơn hàng của tôi',
                                  //     description: '',
                                  //     page: HomeScreen(),
                                  //   ),
                                  // ),
                                  ItemProfile(
                                    itemProfile: ItemProfileModel(
                                      title: 'Tin nhắn',
                                      description: '',
                                      page: ChatHomeScreen(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Container(
                            //   margin: EdgeInsets.only(top: 10.h),
                            //   color: Color(0xFFFFFFFF),
                            //   child: Column(
                            //     children: [
                            //       // ColorLineBottom(),
                            //       ItemProfile(
                            //         itemProfile: ItemProfileModel(
                            //           title: 'Trung tâm hỗ trợ',
                            //           description: '',
                            //           page: HomeScreen(),
                            //         ),
                            //       ),
                            //       ItemProfile(
                            //         itemProfile: ItemProfileModel(
                            //           title: 'Chính sách và quy định',
                            //           description: '',
                            //           page: HomeScreen(),
                            //         ),
                            //       ),
                            //       ItemProfile(
                            //         itemProfile: ItemProfileModel(
                            //           title: 'Cài đặt',
                            //           description: '',
                            //           page: HomeScreen(),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            InkWell(
                              onTap: () {
                                controller.logout();
                                AuthService().signOut();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 30.h, bottom: 10.h, left: 12.w, right: 12.w),
                                height: 45.h,
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.all(Radius.circular(5))),
                                child: Center(
                                  child: Text(
                                    'Đăng xuất'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
              )

            );
          } else {
            return Container();
          }
        });
  }

  late Rx<Order> order;

  @override
  void initState() {
    lu= new Rx<Users>(new Users());
    fetchUsers();
    order = new Rx<Order>(new Order());
    // fetch();
    super.initState();
  }

  Future<bool?> fetchUsers() async {
    var u = await getUser();
    print(u);
    if (u != null) {
      // user = u.obs;
      lu = u.obs;
      print(lu.value!.avatar);
      // print(lu!.username);
    }
    fetch();
    // var o = await isDelivery();
    // print(o);
    // // print(' vao ddaay ce ${o!.userDeliveryId}o');
    // if (o != null) {
    //   order = o.obs;
    //   order.refresh();
    // }
    // print(order.value.price);
    return lu.isBlank;
  }

  Future<bool?> fetch() async {
    var o = await isDelivery();
    print(' vao ddaay ce $o');
    if (o != null) {
      order = o.obs;
    }
    return o.isBlank;
  }

  Future<Users?> getUser() async {
    Users? users;
    String? token = (await getToken());
    try {
      print(Apis.getUsersUrl);
      http.Response response = await http.get(
        Uri.parse(Apis.getUsersUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        print(parsedJson['users']);
        users = UsersJson.fromJson(parsedJson).users;
        print(users);
        return users;
      }
      if (response.statusCode == 401) {
        showToast("Loading faild");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
      print(e.toString());
    }
    return null;
  }

  Future<Order?> isDelivery() async {
    Order? order;
    String? token = (await getToken());
    Map<String, String> queryParams = {
      'userId': lu.value!.id.toString(),
    };

    String queryString = Uri(queryParameters: queryParams).query;
    try {
      print(Apis.isDeliveryUrl);
      http.Response response = await http.get(
        Uri.parse(Apis.isDeliveryUrl + '?' + queryString),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        print(parsedJson['users']);
        order = OrderJson.fromJson(parsedJson).order;
        // print(users);
        return order;
      }
      if (response.statusCode == 401) {
        showToast("Loading faild");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
      print(e.toString());
    }
    return null;
  }
}
