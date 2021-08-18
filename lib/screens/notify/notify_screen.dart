import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/notify.dart';
import 'package:fooddelivery/screens/notify/notify_item.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotifyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotifyScreen();
  }
}

class _NotifyScreen extends State<NotifyScreen> {
  late RxList<Notify> listNotify;

  @override
  void initState() {
    listNotify = new RxList<Notify>();
    fetchNotify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Thông báo',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 24.sp,
              ),
              onPressed: () {
                print("Map");
              }),
        ],
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        height: 834.h,
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: listNotify.length,
                    itemBuilder: (context, index) {
                      return NotifyItem(
                        notify: listNotify[index],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchNotify() async {
    var n = await getNotify();
    print(n);
    if (n != null) {
      listNotify.assignAll(n);
      listNotify.refresh();
    }
  }

  Future<List<Notify>> getNotify() async {
    List<Notify> list = [];
    String token = (await getToken())!;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getNotificationUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListNotify.fromJson(parsedJson).notify!;
        return list;
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return list;
  }
}
