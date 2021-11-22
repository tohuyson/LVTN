import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/address/address_map.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'add_address_item.dart';

class EditAddress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditAddress();
  }
}

class _EditAddress extends State<EditAddress> with WidgetsBindingObserver {
  late int address_id;
  late RxList listAddress;
  late Address address;
  late Users user;
  late TextEditingController addressDetail;
  late TextEditingController a;
  late TextEditingController name;
  late TextEditingController phone;
  final formKey = new GlobalKey<FormState>();
  String group = '';
  late GoogleMapController controller;

  List<Marker> allMarkers = [];

  @override
  void initState() {
    address = new Address();
    user = new Users();
    listAddress = new RxList();
    address_id = Get.arguments['address_id'];
    fetchAddress();
    fetchUsers();
    name = new TextEditingController();
    phone = new TextEditingController();

    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sửa địa chỉ'),
        leading: BackButton(),
        elevation: 0,
      ),
      body: FutureBuilder(
          future: checkLoad(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Form(
                  child: Builder(
                    builder: (BuildContext ctx) => Container(
                      width: 414.w,
                      height: 834.h,
                      child: Column(
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
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        var result =
                                            await Get.to(AddAddressItem());
                                        setState(() {
                                          if (result != null) {
                                            listAddress = result;
                                            listAddress.refresh();
                                            a.text = listAddress[0] +
                                                '\n' +
                                                listAddress[1] +
                                                '\n' +
                                                listAddress[2];
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
                            height: 280.h,
                            width: 414.w,
                            color: Colors.white,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    var result = await Get.to(AddressMap(),
                                        arguments: {'address': address});
                                    if (result != null) {
                                      setState(() {
                                        address = result;
                                        fetchAddress();
                                        controller.animateCamera(CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                            bearing: 270.0,
                                            target: LatLng(double.parse(address.lattitude.toString()),
                                                double.parse(address.longtitude.toString())),
                                            tilt: 30.0,
                                            zoom: 18.0,
                                          ),
                                        ));
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 40.h,
                                    padding: EdgeInsets.only(
                                        left: 12.w, right: 12.w),
                                    color: Color(0xffF7FFD4),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.notifications_on_sharp,
                                        ),
                                        Text(
                                          'Vui lòng ghim vị trí chính xác',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 240.h,
                                  child: GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          double.parse(
                                              address.lattitude.toString()),
                                          double.parse(
                                              address.longtitude.toString())),
                                      zoom: 18.0,
                                    ),
                                    onMapCreated: _onMapCreated,
                                    markers: Set.from(allMarkers),
                                    gestureRecognizers: Set()
                                      ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                                      ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
                                      ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                                      ..add(Factory<VerticalDragGestureRecognizer>(
                                              () => VerticalDragGestureRecognizer())),
                                    // onTap: handleTap,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          InkWell(
                            onTap: () {
                              editLocationAddress(ctx);
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

  Future<bool?> checkLoad() async {
    await fetchAddress();
    await fetchUsers();
    if (address.status == 1) {
      group = '1';
    }
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: false,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(double.parse(address.lattitude.toString()),
            double.parse(address.longtitude.toString()))));

    addressDetail = new TextEditingController(text: address.detail);
    a = new TextEditingController(text: address.address);
    return user.isBlank;
  }

  Future<void> fetchUsers() async {
    var u = await getUser();
    if (u != null) {
      user = u;
    }
  }

  Future<Users?> getUser() async {
    Users? users;
    String? token = (await getToken());
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getUsersUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        users = UsersJson.fromJson(parsedJson).users;
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

  Future<void> fetchAddress() async {
    var a = await getAddress();
    if (a != null) {
      address = a;
    }
  }

  Future<Address?> getAddress() async {
    Address a;
    String token = (await getToken())!;
    try {
      Map<String, String> queryParams = {
        'address_id': address_id.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      http.Response response = await http.get(
        Uri.parse(Apis.getAddressFromIdUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        a = AddressJson.fromJson(parsedJson).address!;
        return a;
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

  Future<void> editLocationAddress(BuildContext context) async {
    if (Form.of(context)!.validate()) {
      String add;
      if (listAddress.length == 0) {
        add = address.address!;
      } else {
        add = listAddress[2] + ', ' + listAddress[1] + ', ' + listAddress[0];
      }

      String a = addressDetail.text + ',' + add;
      String token = (await getToken())!;
      try {
        http.Response response = await http.post(
          Uri.parse(Apis.updateAddressUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': "Bearer $token",
          },
          body: jsonEncode(<String, dynamic>{
            'id': address.id,
            'detail': addressDetail.text,
            'address': add,
            'longtitude': address.longtitude,
            'lattitude': address.lattitude,
            'status': group,
          }),
        );
        if (response.statusCode == 200) {
          Get.back();
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
