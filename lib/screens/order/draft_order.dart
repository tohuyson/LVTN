import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/card.dart';
import 'package:fooddelivery/screens/restaurant/restaurant_screen.dart';
import 'package:fooddelivery/screens/widget/empty_screen.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DraftOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DraftOrder();
  }
}

class _DraftOrder extends State<DraftOrder> {
  late RxList<CardModel> card;

  @override
  void initState() {
    card = new RxList<CardModel>();
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEEEEEE),
      height: 834.h,
      child: FutureBuilder(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else {
              if (snapshot.hasError) {
                return EmptyScreen(text: 'Bạn chưa có đơn hàng nào.');
              } else {
                return card.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: card.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.18,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(RestaurantsScreen(), arguments: {
                                  'restaurant_id': card[index].restaurantId
                                });
                              },
                              child: Container(
                                width: 414.w,
                                padding: EdgeInsets.only(
                                  top: 3.h,
                                ),
                                margin: EdgeInsets.only(
                                    top: 10.h, left: 10.h, right: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.sp)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 12.h,
                                          left: 12.w,
                                          right: 12.w,
                                          top: 12.h),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black12),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            ),
                                            child: card[index].restaurant ==
                                                    null
                                                ? Container(
                                                    width: 80.w,
                                                    height: 80.w,
                                                    padding: EdgeInsets.only(
                                                        right: 12.w,
                                                        bottom: 12.h,
                                                        left: 12.w,
                                                        top: 12.h),
                                                    child: Image.asset(
                                                      'assets/images/user.png',
                                                      fit: BoxFit.fill,
                                                      color: Colors.black26,
                                                    ),
                                                  )
                                                : Container(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      child: Image.network(
                                                        Apis.baseURL +
                                                            card[index]
                                                                .restaurant!
                                                                .image!,
                                                        width: 72.w,
                                                        height: 80.h,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          Container(
                                            width: 290.w,
                                            padding: EdgeInsets.only(
                                                left: 10.w, right: 10.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  card[index].restaurant!.name!,
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text('Địa chỉ : ' +
                                                    card[index]
                                                        .restaurant!
                                                        .address
                                                        .toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text('Giá : ' + NumberFormat.currency(
                                                    locale: 'vi')
                                                    .format(
                                                    card[index]
                                                        .sumPrice),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            secondaryActions: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: IconSlideAction(
                                  caption: 'Delete',
                                  color: Color(0xFFEEEEEE),
                                  icon: Icons.delete,
                                  foregroundColor: Colors.red,
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: Text('Xóa đơn hàng'),
                                              content: const Text(
                                                  'Bạn có chắc chắn muốn xóa không?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => Get.back(),
                                                  child: const Text('Hủy'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    await deleteDraftOrder(
                                                        card[index].id);
                                                    setState(() {
                                                      card.removeAt(index);
                                                      card.refresh();
                                                      Get.back();
                                                      showToast(
                                                          "Xóa thành công");
                                                    });
                                                  },
                                                  child: const Text(
                                                    'Xóa',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ]);
                                        });
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      )
                    : EmptyScreen(text: 'Bạn chưa có đơn hàng nào.');
              }
            }
          }),
    );
  }

  Future<void> fetch() async {
    var c = await getDraftOrder();
    if (c != null) {
      card.assignAll(c);
      card.refresh();
    }
  }

  Future<List<CardModel>?> getDraftOrder() async {
    List<CardModel> list;
    String? token = (await getToken());
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getdraftOrderUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListCardModel.fromJson(parsedJson).card!;
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

  Future<CardModel?> deleteDraftOrder(int? id) async {
    String? token = await getToken();
    print(token);

    try {
      EasyLoading.show(status: 'Loading...');
      http.Response response = await http.post(
        Uri.parse(Apis.deleteDraftOrderUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'card_id': id,
        }),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        var parsedJson = jsonDecode(response.body);
        CardModel? card = CardJson.fromJson(parsedJson).card;
        return card;
      }
      if (response.statusCode == 404) {
        EasyLoading.dismiss();
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }
}
