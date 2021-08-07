import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/card.dart';
import 'package:fooddelivery/screens/chat/widget/loading.dart';
import 'package:fooddelivery/screens/widget/empty_screen.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
      padding: EdgeInsets.only(top: 5.h),
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
                // return buildLoading();
                return card.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: card.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.12,
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 3.h,
                                left: 8.h,
                              ),
                              margin: EdgeInsets.only(
                                  top: 10.h, left: 12.h, right: 10.w),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.sp)),
                                color: Colors.white,
                              ),
                              // height: 100.h,
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
                                          child: card[index].restaurant == null
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
                                                            Radius.circular(5)),
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
                                          padding: EdgeInsets.only(
                                              left: 12.w, right: 10.w),
                                          height: 92.h,
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
                                                      .toString()),
                                              Text('Giá : ' +
                                                  card[index]
                                                      .sumPrice
                                                      .toString() +
                                                  ' đ'),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
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
                                                    // await deleteMaterials(
                                                    //     materials[index].id);
                                                    // setState(() {
                                                    //   materials.removeAt(index);
                                                    //   materials.refresh();
                                                    //   Get.back();
                                                    //   showToast("Xóa thành công");
                                                    // });
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
      print(Apis.getdraftOrderUrl);
      http.Response response = await http.get(
        Uri.parse(Apis.getdraftOrderUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListCardModel.fromJson(parsedJson).card!;
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
}
