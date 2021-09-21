import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/list_address.dart';
import 'package:fooddelivery/screens/order/order_detail.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListAddressDelivery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListAddressDelivery();
  }
}

class _ListAddressDelivery extends State<ListAddressDelivery> {
  late RxList<Address> address;
  late String group;
  late Address chooseAddress;

  @override
  void initState() {
    address = new RxList<Address>();
    group = '';
    fetchAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Địa chỉ đã lưu'),
        centerTitle: true,
      ),
      body: Container(
        color: kPrimaryColorBackground,
        child: Column(
          children: [
            Container(
              height: 730.h,
              child: Obx(
                () => ListView.builder(
                    itemCount: address.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(12.w),
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        width: 414.w,
                        child: Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(
                              width: 12.w,
                            ),
                            Container(
                                width: 278.w,
                                child: Text(
                                  address[index].detail! +
                                      ', ' +
                                      address[index].address!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )),
                            new Radio(
                              toggleable: true,
                              value:
                                  '${address[index].detail}|${address[index].address}|${address[index].lattitude}|${address[index].longtitude}',
                              groupValue: group.toString(),
                              onChanged: (val) {
                                setState(() {
                                  group = val.toString();
                                  chooseAddress = address[index];
                                  print(group);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            GestureDetector(
              onTap: () async {
                print(group);

                print(chooseAddress.detail);

                await setValue('street', chooseAddress.detail!);
                await setValue('address', chooseAddress.address!);
                await setValue('latitude', chooseAddress.lattitude!);
                await setValue('longitude', chooseAddress.longtitude!);
                Get.back(result: group);
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
                height: 45.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    'Đồng ý'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchAddress() async {
    var a = await getAddress();
    print(a);
    if (a != null) {
      address.assignAll(a);
      address.refresh();
      print(address.length);
    }
  }

  Future<List<Address>?> getAddress() async {
    List<Address> list;
    String token = (await getToken())!;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getAddressUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListAddress.fromJson(parsedJson).listAddress!;
        return list;
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
}
