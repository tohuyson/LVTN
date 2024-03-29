import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/chat/chat.dart';
import 'package:fooddelivery/screens/chat/model/user_chat.dart';
import 'package:fooddelivery/screens/delivery/received_screen.dart';
import 'package:fooddelivery/screens/widget/empty_screen.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apis.dart';
import '../../utils.dart';

class DeliveryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DeliveryScreen();
  }
}

class _DeliveryScreen extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nhận đơn'),
      ),
      body: Container(
        child: FutureBuilder(
            future: fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else {
                if (snapshot.hasError) {
                  return EmptyScreen(text: 'Bạn chưa có đơn hàng nào.');
                } else {
                  // return buildLoading();
                  return RefreshIndicator(
                    onRefresh: () => fetch(),
                    child: Obx(
                      () => listOrder.length == 0
                          ? EmptyScreen(
                              text: "Bạn chưa có đơn hàng nào",
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: listOrder.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: FractionalOffset.topCenter,
                                  margin: new EdgeInsets.only(top: 1.h),
                                  child: Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 2.h,
                                            left: 10.h,
                                          ),
                                          height: 70.h,
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  //img user
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.black12),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50)),
                                                      ),
                                                      //image
                                                      child: Container(
                                                          width: 50.w,
                                                          height: 50.h,
                                                          child: listOrder[
                                                                          index]
                                                                      .user!
                                                                      .avatar ==
                                                                  null
                                                              ? Container(
                                                                  padding: EdgeInsets.only(
                                                                      right:
                                                                          10.w,
                                                                      bottom:
                                                                          10.h,
                                                                      left:
                                                                          10.w,
                                                                      top:
                                                                          10.h),
                                                                  child:
                                                                      ClipRRect(
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/user.png',
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                )
                                                              : ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.all(Radius
                                                                          .circular(
                                                                              50)),
                                                                  child: Image
                                                                      .network(
                                                                    Apis.baseURL +
                                                                        listOrder[index]
                                                                            .user!
                                                                            .avatar!,
                                                                    width:
                                                                        100.w,
                                                                    height:
                                                                        100.h,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )))),
                                                  //user name
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10.w),
                                                    child: Text(
                                                      listOrder[index]
                                                          .user!
                                                          .username!,
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          launch(
                                                              "tel: ${listOrder[index].user!.phone}");
                                                        },
                                                        icon: Icon(
                                                          Icons.call,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        )),
                                                    IconButton(
                                                        onPressed: () async {
                                                          SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          print('chát');
                                                          User? user =
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!;
                                                          print(user);
                                                          if (user != null) {
                                                            // Check is already sign up
                                                            final querySnapshotresult =
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .where('id',
                                                                        isEqualTo:
                                                                            user.uid)
                                                                    .get();
                                                            print(
                                                                querySnapshotresult
                                                                    .docs);
                                                            // final List<DocumentSnapshot>documents = result.docs;
                                                            if (querySnapshotresult
                                                                    .docs
                                                                    .length ==
                                                                0) {
                                                              // Update data to server if new user
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(user.uid)
                                                                  .set({
                                                                'nickname': user
                                                                    .displayName,
                                                                'photoUrl': user
                                                                    .photoURL,
                                                                'id': user.uid,
                                                                'createdAt': DateTime
                                                                        .now()
                                                                    .millisecondsSinceEpoch
                                                                    .toString(),
                                                                'chattingWith':
                                                                    listOrder[
                                                                            index]
                                                                        .user!
                                                                        .uid,
                                                              });

                                                              // Write data to local
                                                              // currentUser = user;
                                                              // print(currentUser.uid);
                                                              await prefs
                                                                  .setString(
                                                                      'id',
                                                                      user.uid);
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
                                                              UserChat
                                                                  userChat =
                                                                  UserChat.fromDocument(
                                                                      documentSnapshot);
                                                              // Write data to local
                                                              print(
                                                                  userChat.id);
                                                              await prefs
                                                                  .setString(
                                                                      'id',
                                                                      userChat
                                                                          .id!);
                                                              await prefs.setString(
                                                                  'nickname',
                                                                  userChat
                                                                      .nickname!);
                                                              await prefs.setString(
                                                                  'photoUrl',
                                                                  userChat.photoUrl ??
                                                                      "");
                                                            }
                                                            String avatar = Apis
                                                                    .baseURL +
                                                                listOrder[index]
                                                                    .user!
                                                                    .avatar!;
                                                            Get.to(Chat(
                                                              peerId: listOrder[
                                                                      index]
                                                                  .user!
                                                                  .uid!,
                                                              peerNickname:
                                                                  listOrder[
                                                                          index]
                                                                      .user!
                                                                      .username!,
                                                              peerAvatar:
                                                                  avatar,
                                                            ));
                                                          }
                                                        },
                                                        icon: Icon(
                                                            Icons.message,
                                                            size: 20,
                                                            color:
                                                                Colors.grey)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 0.5,
                                                        color: Colors.grey)))),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10.w,
                                              right: 10.w,
                                              bottom: 1.w,
                                              top: 10.h),
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: 8.w,
                                                    top: 8.h,
                                                    bottom: 8.w),
                                                child: Column(
                                                  children: [
                                                    ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            listOrder[index]
                                                                .foodOrder!
                                                                .length,
                                                        itemBuilder:
                                                            (context, ind) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 24.w,
                                                                child: Text(listOrder[
                                                                            index]
                                                                        .foodOrder![
                                                                            ind]
                                                                        .quantity
                                                                        .toString() +
                                                                    ' x'),
                                                              ),
                                                              Container(
                                                                width: 230.w,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      listOrder[
                                                                              index]
                                                                          .foodOrder![
                                                                              ind]
                                                                          .food!
                                                                          .name!,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18.sp),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          230.w,
                                                                      child: ListView.builder(
                                                                          shrinkWrap: true,
                                                                          itemCount: listOrder[index].foodOrder![ind].toppings!.length,
                                                                          itemBuilder: (context, i) {
                                                                            return Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  "+ " + '${listOrder[index].foodOrder![ind].toppings![i].name!}: ' + ' ${listOrder[index].foodOrder![ind].toppings![i].price!}',
                                                                                  style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 1.h,
                                                                                )
                                                                              ],
                                                                            );
                                                                          }),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          5.h,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 90.w,
                                                                child: Text(
                                                                  NumberFormat.currency(
                                                                          locale:
                                                                              'vi')
                                                                      .format(listOrder[
                                                                              index]
                                                                          .foodOrder![
                                                                              ind]
                                                                          .price),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      padding:
                                                          EdgeInsets.all(10.sp),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.sp)),
                                                        color: Colors.grey[100],
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            child: Text(
                                                              'Ghi chú của khách hàng:',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp),
                                                            ),
                                                          ),
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            child: Text(
                                                              listOrder[index]
                                                                          .note ==
                                                                      null
                                                                  ? "Chưa có"
                                                                  : listOrder[
                                                                          index]
                                                                      .note!,
                                                              softWrap: true,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 7.w),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text('Tổng: ' +
                                                          NumberFormat.currency(
                                                                  locale: 'vi')
                                                              .format(listOrder[
                                                                      index]
                                                                  .price)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 0.5,
                                                        color: Colors
                                                            .grey.shade300)))),
                                        Container(
                                          height: 55.h,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 45.h,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                  title: Text(
                                                                      'Nhận đơn hàng'),
                                                                  content: SingleChildScrollView(
                                                                      child: Text(
                                                                          'Bạn có muốn nhận đơn hàng không?')),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Get.back(),
                                                                      child:
                                                                          const Text(
                                                                        'Hủy',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        await received(
                                                                            listOrder[index].id);
                                                                        Get.back();
                                                                        // bool isNotify =
                                                                        await notification(
                                                                            listOrder[index].foodOrder![0].food!.restaurant!.user!.uid!,
                                                                            'Nhận đơn',
                                                                            'Đơn hàng #${listOrder[index].id} đã được nhận bởi ${user.username}',
                                                                            2);
                                                                        await notification(
                                                                            listOrder[index].user!.uid!,
                                                                            'Nhận đơn',
                                                                            'Đơn hàng #${listOrder[index].id} đã được nhận bởi ${user.username}',
                                                                            2);
                                                                        // if (isNotify ==
                                                                        //     true) {
                                                                        //   await saveNotification(
                                                                        //       'Nhận đơn',
                                                                        //       'Đơn hàng #${listOrder[index].id} đã được nhận bởi ${user.username}',
                                                                        //       '${listOrder[index].foodOrder![0].food!.restaurant!.user!.id}',
                                                                        //       2);
                                                                        // }
                                                                        await Get.off(
                                                                            () =>
                                                                                ReceivedScreen(),
                                                                            arguments: {
                                                                              'userId': user.id
                                                                            });
                                                                        showToast(
                                                                            "Nhận đơn hàng thành công");
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Nhận đơn',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.blue),
                                                                      ),
                                                                    ),
                                                                  ]);
                                                            });
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 190.w,
                                                        child: Text(
                                                          'Nhận đơn',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                    ),
                  );
                }
              }
            }),
      ),
    );
  }

  late RxList<Order> listOrder;
  late Users user;
  late bool isDelivery = false;

  @override
  void initState() {
    listOrder = new RxList<Order>();
    // fetch();
    fetch();
    user = Get.arguments['user'];
    print(user);
    super.initState();
  }

  Future<void> fetch() async {
    var list = await getOrder();
    if (list != null) {
      listOrder.assignAll(list);
      listOrder.refresh();
    }
  }

  Future<List<Order>?> getOrder() async {
    List<Order> list;
    String? token = (await getToken());
    try {
      print(Apis.getDeliveryUrl);
      http.Response response = await http.get(
        Uri.parse(Apis.getDeliveryUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        // print(parsedJson['food']);
        list = ListOrders.fromJson(parsedJson).order!;
        print(list);
        return list;
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

  Future<void> received(int? id) async {
    String? token = await getToken();
    print(token);
    print(id);
    try {
      // EasyLoading.show(status: 'Loading...');
      http.Response response = await http.post(
        Uri.parse(Apis.receivedUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'orderId': id,
          'userId': user.id,
        }),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        // EasyLoading.dismiss();
        // var parsedJson = jsonDecode(response.body);
        // Order order = Order.fromJson(parsedJson['order']);
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }
}
