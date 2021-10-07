import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/list_address.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/address/add_address.dart';
import 'package:fooddelivery/screens/address/address_map_now.dart';
import 'package:fooddelivery/screens/address/edit_address.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddressScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddressScreen();
  }
}

class _AddressScreen extends State<AddressScreen> {
  late RxList<Address> address;
  late Users user;
  RxString street = ''.obs;
  RxString addressDetail = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  late Address add;

  @override
  void initState() {
    checkPermision();
    address = new RxList<Address>();
    fetchAddress();
    fetchUsers();
    super.initState();
  }

  Future<void> getAd() async {
    street = (await getValue('street'))!.obs;
    addressDetail = (await getValue('address'))!.obs;
    latitude = (await getValue('latitude'))!.obs;
    longitude = (await getValue('longitude'))!.obs;
    add = Address(
        detail: street.value,
        address: addressDetail.value,
        lattitude: latitude.value,
        longtitude: longitude.value);
  }

  Future<void> checkPermision() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  Future<String> getStreet(List<Placemark> placemarks) async {
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].street!.isNotEmpty) {
        return placemarks[i].street!;
      }
    }
    return '';
  }

  Future<String> getLocality(List<Placemark> placemarks) async {
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].locality!.isNotEmpty) {
        return placemarks[i].locality!;
      }
    }
    return '';
  }

  Future<String> getAdd(List<Placemark> placemarks) async {
    String address = '';

    for (int i = 0; i < placemarks.length; i++) {
      print(placemarks[i]);
      if (placemarks[i].administrativeArea!.isNotEmpty &&
          placemarks[i].subAdministrativeArea!.isNotEmpty &&
          placemarks[i].country!.isNotEmpty) {
        address = placemarks[i].subAdministrativeArea! +
            ', ' +
            placemarks[i].administrativeArea! +
            ', ' +
            placemarks[i].country!;
      }
    }
    return address;
  }

  Future<List<Placemark>> getLocation(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    return placemarks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Địa chỉ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await Get.to(AddressMapNow(), arguments: {'address': add});
              },
              icon: Icon(Icons.map_outlined))
        ],
      ),
      body: FutureBuilder(
          future: checkload(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else {
              if (snapshot.hasData) {
                return Container(
                  width: 414.w,
                  color: kPrimaryColorBackground,
                  child: Column(children: [
                    Container(
                      height: 664.h,
                      width: 414.w,
                      padding:
                          EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vị trí hiện tại',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          addressDetail.value != '' && street.value != ''
                              ? Container(
                                  width: 390.w,
                                  margin: EdgeInsets.only(top: 8.h),
                                  padding:
                                      EdgeInsets.only(top: 8.h, bottom: 8.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.location_on_outlined,
                                          size: 24,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Obx(
                                        () => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              street.value,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 6.h,
                                            ),
                                            Container(
                                                width: 336.w,
                                                child: Text(
                                                  addressDetail.value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                            child: Text(
                              'Địa chỉ đã lưu',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            height: 520.h,
                            child: address.length > 0
                                ? Obx(() => ListView.builder(
                                    itemCount: address.length,
                                    itemBuilder: (context, index) {
                                      return Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        actionExtentRatio: 0.12,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 8.h,
                                              bottom: 8.h,
                                              left: 10.w,
                                              right: 10.w),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  size: 28.sp,
                                                  color: Colors.black54,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Container(
                                                  width: 290.w,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                user.username!,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            user.phone!,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    16.sp),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text(
                                                        address[index].detail!,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                        address[index].address!,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 34.w,
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      await Get.to(
                                                          EditAddress(),
                                                          arguments: {
                                                            'address_id':
                                                                address[index]
                                                                    .id,
                                                            'user_id': user.id,
                                                          });
                                                      setState(() {
                                                        fetchAddress();
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.edit,
                                                      size: 18,
                                                    ),
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
                                                          title: Text(
                                                              'Xóa địa chỉ'),
                                                          content: const Text(
                                                              'Bạn có chắc chắn muốn xóa không?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Get.back(),
                                                              child: const Text(
                                                                  'Hủy'),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                await deleteAddress(
                                                                    address[index]
                                                                        .id!);
                                                                setState(() {
                                                                  address
                                                                      .removeAt(
                                                                          index);
                                                                  address
                                                                      .refresh();
                                                                  Get.back();
                                                                });
                                                              },
                                                              child: const Text(
                                                                'Xóa',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ]);
                                                    });
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    }))
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                          'Bạn chưa có địa chỉ đã lưu'),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 65.h,
                      child: GestureDetector(
                        onTap: () async {
                          var result = await Get.to(AddAddress());
                          setState(() {
                            address.add(result);
                            address.refresh();
                            fetchAddress();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
                          height: 45.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              'Thêm địa chỉ mới'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
              } else {
                return Container();
              }
            }
          }),
    );
  }

  Future<Address?> deleteAddress(int address_id) async {
    String token = (await getToken())!;

    try {
      http.Response response = await http.post(
        Uri.parse(Apis.deleteAddressUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'address_id': address_id,
        }),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        Address address = AddressJson.fromJson(parsedJson).address!;
        return address;
      }
      if (response.statusCode == 404) {
        var parsedJson = jsonDecode(response.body);
        print(parsedJson['error']);
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }

  Future<bool?> checkload() async {
    await fetchUsers();
    await fetchAddress();
    await getAd();
    return user.isBlank;
  }

  Future<void> fetchUsers() async {
    var u = await getUser();
    print(u);
    if (u != null) {
      user = u;
    }
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
