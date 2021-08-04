import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/address/add_address_item.dart';
import 'package:fooddelivery/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddAddress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddAddress();
  }
}

class _AddAddress extends State<AddAddress> {
  String group = '';
  late RxList address;
  late TextEditingController addressDetail;
  late TextEditingController a;
  late TextEditingController name;
  late TextEditingController phone;
  final formKey = new GlobalKey<FormState>();
  late Users user;

  @override
  void initState() {
    address = RxList();
    name = new TextEditingController();
    fetchUsers();
    phone = new TextEditingController();
    addressDetail = new TextEditingController();
    a = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Thêm địa chỉ'),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: FutureBuilder(
          future: fetchUsers(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: kPrimaryColorBackground,
                width: 414.w,
                height: 834.h,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Builder(
                      builder: (BuildContext ctx) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 390.w,
                            padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                            child: Text(
                              'Liên hệ',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            color: Colors.white,
                            child: Column(
                              children: [
                                TextFormField(
                                  readOnly: true,
                                  initialValue: user.username,
                                  validator: (val) {
                                    if (val!.length == 0) {
                                      return 'Vui lòng nhập Họ và tên';
                                    } else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Họ và tên",
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black12)),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  initialValue: user.phone,
                                  validator: (val) {
                                    if (val!.length == 0) {
                                      return 'Vui lòng nhập Số điện thoại';
                                    } else if (val.length < 10) {
                                      return 'Sai định dạng Số điện thoại';
                                    } else if (!val.isNum) {
                                      return 'Sai định dạng Số điện thoại';
                                    } else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Số điện thoại",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 390.w,
                            padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                            child: Text(
                              'Địa chỉ',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            color: Colors.white,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (val) {
                                    if (val!.length == 0) {
                                      return 'Vui lòng chọn Địa chỉ';
                                    } else
                                      return null;
                                  },
                                  controller: a,
                                  maxLines: null,
                                  readOnly: true,
                                  // enabled: false,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        print('vào đây');
                                        var result =
                                            await Get.to(AddAddressItem());
                                        setState(() {
                                          print(address.value);
                                          if (result != null) {
                                            address = result;
                                            address.refresh();
                                            a.text = address[0] +
                                                '\n' +
                                                address[1] +
                                                '\n' +
                                                address[2];
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.black26,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText:
                                        'Tỉnh/ Thành phố,Quận/Huyện, Phường/Xã',
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black12)),
                                ),
                                TextFormField(
                                  validator: (val) {
                                    if (val!.length == 0) {
                                      return 'Vui lòng nhập Địa chỉ cụ thể';
                                    } else
                                      return null;
                                  },
                                  controller: addressDetail,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Tên đường, số nhà",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: kPrimaryColorBackground,
                                        width: 2))),
                            padding: EdgeInsets.only(left: 12.w),
                            width: 414.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Đặt làm địa chỉ mặc định',
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                                new Radio(
                                  toggleable: true,
                                  value: '1',
                                  groupValue: group.toString(),
                                  onChanged: (val) {
                                    setState(() {
                                      group = val.toString();
                                      print(group);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              addLocationAddress(ctx);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 10.h,
                                  left: 10.w,
                                  right: 10.w),
                              height: 45.h,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  'Hoàn thành'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }

  Future<bool?> fetchUsers() async {
    var u = await getUser();
    print(u);
    if (u != null) {
      user = u;
    }
    return user.isBlank;
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

  Future<void> addLocationAddress(BuildContext context) async {
    if (Form.of(context)!.validate()) {
      String add = address[2] + ', ' + address[1] + ', ' + address[0];
      String a = addressDetail.text + ',' + add;
      List<Location> locations = await locationFromAddress(a);
      print(locations);
      Location position = locations.first;
      String token = (await getToken())!;
      try {
        http.Response response = await http.post(
          Uri.parse(Apis.addAddressUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': "Bearer $token",
          },
          body: jsonEncode(<String, dynamic>{
            'detail': addressDetail.text,
            'address': add,
            'longtitude': position.longitude,
            'lattitude': position.latitude,
            'status': group,
          }),
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          var parsedJson = jsonDecode(response.body);
          var address = AddressJson.fromJson(parsedJson).address;
          Get.back(result: address);
        }
        if (response.statusCode == 500) {
          showToast("Hệ thống bị lỗi, Vui lòng thử lại sau!");
        }
      } on TimeoutException catch (e) {
        showError(e.toString());
      } on SocketException catch (e) {
        showError(e.toString());
        print(e.toString());
      }
    }
  }
}
