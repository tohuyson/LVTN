import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/controllers/address_controller.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/model/list_address.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/address/add_address.dart';
import 'package:fooddelivery/screens/address/address_item.dart';
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

  @override
  void initState() {
    address = new RxList<Address>();
    // getAd();
    fetchAddress();
    fetchUsers();
    super.initState();
  }

  Future<void> getAd() async {
    street = (await getValue('street'))!.obs;
    addressDetail = (await getValue('address'))!.obs;
    print(street);
    print(addressDetail);
  }

  Future<void> loadData() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showToast('Vui lòng bật vị trí!');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast('Vui lòng cung cấp vị trí!');
      }
    }

    List<Placemark> placemark = await getPosition();
    String s = await getStreet(placemark);
    String locality = await getLocality(placemark);
    String a = await getAdd(placemark);
    setState(() {
      street = s.obs;
      addressDetail = (s + ', ' + locality + ', ' + a).obs;
      setValue('street', s);
      setValue('address', addressDetail.value);
      setValue("latitude", latitude);
      setValue('longitude', longitude);
    });
  }

  String latitude = '';
  String longitude = '';

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
    // List<String> address = [];
    String address = '';

    for (int i = 0; i < placemarks.length; i++) {
      print(placemarks[i]);
      if (placemarks[i].administrativeArea!.isNotEmpty &&
          placemarks[i].subAdministrativeArea!.isNotEmpty &&
          placemarks[i].country!.isNotEmpty) {
        print('vào dât đi bạn');
        // address.add(placemarks[i].administrativeArea!);
        // address.add(placemarks[i].subAdministrativeArea!);
        // address.add(placemarks[i].locality!);
        address = placemarks[i].subAdministrativeArea! +
            ', ' +
            placemarks[i].administrativeArea! +
            ', ' +
            placemarks[i].country!;
      }
    }
    return address;
  }

  Future<List<Placemark>> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
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
                await loadData();
              },
              icon: Icon(Icons.my_location))
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
                  height: 834.h,
                  color: kPrimaryColorBackground,
                  child: Column(children: [
                    Container(
                      width: 414.w,
                      padding: EdgeInsets.only(
                          left: 12.w, right: 12.w, top: 10.h, bottom: 10.h),
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
                                          Icons.location_on,
                                          size: 20,
                                        ),
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
                                              height: 8.h,
                                            ),
                                            Container(
                                                width: 350.w,
                                                child: Text(
                                                  addressDetail.value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300),
                                                )),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Row(
                                              children: [],
                                            )
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
                            height: 510.h,
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
                                                  Icons.location_on,
                                                  size: 20.sp,
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
                                                              // address[index].status == 1
                                                              //     ? Text(
                                                              //         '[Mặc định]',
                                                              //         style: TextStyle(
                                                              //             color: Theme.of(
                                                              //                     context)
                                                              //                 .primaryColor),
                                                              //       )
                                                              //     : Text(''),
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
                                                        // address.addressDetail!,
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
                                                        // address.addressDetail!,
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
                                                // SizedBox(
                                                //   width: 10.w,
                                                // ),
                                                Container(
                                                  width: 50.w,
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
                                                    child: Text(
                                                      'Sửa',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
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

                                                                // Get.to(ListProduct());

                                                                // food.refresh();
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
                    // Column(
                    //   children: [
                    //     Text('Địa chỉ đã lưu'),
                    //     Expanded(
                    //       child: Obx(
                    //         () => address.length > 0
                    //             ? ListView.builder(
                    //                 itemCount: address.length,
                    //                 itemBuilder: (context, index) {
                    //                   return Slidable(
                    //                     actionPane: SlidableDrawerActionPane(),
                    //                     actionExtentRatio: 0.12,
                    //                     child: Container(
                    //                       padding: EdgeInsets.only(
                    //                           top: 8.h,
                    //                           bottom: 8.h,
                    //                           left: 10.w,
                    //                           right: 10.w),
                    //                       color: Colors.white,
                    //                       margin: EdgeInsets.only(bottom: 10.h),
                    //                       child: Center(
                    //                         child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.spaceAround,
                    //                           children: [
                    //                             Container(
                    //                               width: 40.w,
                    //                               child: Icon(
                    //                                 Icons.location_on,
                    //                                 color: Colors.black,
                    //                                 size: 28.sp,
                    //                               ),
                    //                             ),
                    //                             Container(
                    //                               width: 290.w,
                    //                               child: Column(
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment.start,
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment
                    //                                         .spaceEvenly,
                    //                                 children: [
                    //                                   Column(
                    //                                     crossAxisAlignment:
                    //                                         CrossAxisAlignment
                    //                                             .start,
                    //                                     children: [
                    //                                       Row(
                    //                                         children: [
                    //                                           Text(
                    //                                             user.username!,
                    //                                             overflow:
                    //                                                 TextOverflow
                    //                                                     .clip,
                    //                                             style: TextStyle(
                    //                                                 fontSize:
                    //                                                     18.sp,
                    //                                                 fontWeight:
                    //                                                     FontWeight
                    //                                                         .w500),
                    //                                           ),
                    //                                           SizedBox(
                    //                                             width: 10.w,
                    //                                           ),
                    //                                           address[index]
                    //                                                       .status ==
                    //                                                   1
                    //                                               ? Text(
                    //                                                   '[Mặc định]',
                    //                                                   style: TextStyle(
                    //                                                       color: Theme.of(context)
                    //                                                           .primaryColor),
                    //                                                 )
                    //                                               : Text(''),
                    //                                         ],
                    //                                       ),
                    //                                       SizedBox(
                    //                                         height: 5.h,
                    //                                       ),
                    //                                       Text(
                    //                                         user.phone!,
                    //                                         style: TextStyle(
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .w400,
                    //                                             fontSize: 16.sp),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   SizedBox(
                    //                                     height: 5.h,
                    //                                   ),
                    //                                   Text(
                    //                                     address[index].detail!,
                    //                                     // address.addressDetail!,
                    //                                     overflow:
                    //                                         TextOverflow.clip,
                    //                                     style: TextStyle(
                    //                                         fontSize: 16.sp,
                    //                                         fontWeight:
                    //                                             FontWeight.w400),
                    //                                   ),
                    //                                   Text(
                    //                                     address[index].address!,
                    //                                     // address.addressDetail!,
                    //                                     overflow:
                    //                                         TextOverflow.clip,
                    //                                     style: TextStyle(
                    //                                         fontSize: 16.sp,
                    //                                         fontWeight:
                    //                                             FontWeight.w400),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                             // SizedBox(
                    //                             //   width: 10.w,
                    //                             // ),
                    //                             Container(
                    //                               width: 50.w,
                    //                               child: TextButton(
                    //                                 onPressed: () async {
                    //                                   await Get.to(EditAddress(),
                    //                                       arguments: {
                    //                                         'address_id':
                    //                                             address[index].id,
                    //                                         'user_id': user.id,
                    //                                       });
                    //                                   setState(() {
                    //                                     fetchAddress();
                    //                                   });
                    //                                 },
                    //                                 child: Text(
                    //                                   'Sửa',
                    //                                   style: TextStyle(
                    //                                     color: Theme.of(context)
                    //                                         .primaryColor,
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     secondaryActions: <Widget>[
                    //                       Container(
                    //                         margin: EdgeInsets.only(top: 5),
                    //                         child: IconSlideAction(
                    //                           caption: 'Delete',
                    //                           color: Color(0xFFEEEEEE),
                    //                           icon: Icons.delete,
                    //                           foregroundColor: Colors.red,
                    //                           onTap: () {
                    //                             showDialog(
                    //                                 context: context,
                    //                                 builder: (context) {
                    //                                   return AlertDialog(
                    //                                       title: Text(
                    //                                           'Xóa địa chỉ'),
                    //                                       content: const Text(
                    //                                           'Bạn có chắc chắn muốn xóa không?'),
                    //                                       actions: <Widget>[
                    //                                         TextButton(
                    //                                           onPressed: () =>
                    //                                               Get.back(),
                    //                                           child: const Text(
                    //                                               'Hủy'),
                    //                                         ),
                    //                                         TextButton(
                    //                                           onPressed:
                    //                                               () async {
                    //                                             await deleteAddress(
                    //                                                 address[index]
                    //                                                     .id!);
                    //                                             setState(() {
                    //                                               address
                    //                                                   .removeAt(
                    //                                                       index);
                    //                                               address
                    //                                                   .refresh();
                    //                                               Get.back();
                    //                                             });
                    //
                    //                                             // Get.to(ListProduct());
                    //
                    //                                             // food.refresh();
                    //                                           },
                    //                                           child: const Text(
                    //                                             'Xóa',
                    //                                             style: TextStyle(
                    //                                                 color: Colors
                    //                                                     .red),
                    //                                           ),
                    //                                         ),
                    //                                       ]);
                    //                                 });
                    //                           },
                    //                         ),
                    //                       )
                    //                     ],
                    //                   );
                    //                 })
                    //             : Container(
                    //                 color: Colors.white,
                    //                 child: Center(
                    //                   child: Text('Bạn chưa có địa chỉ'),
                    //                 ),
                    //               ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    InkWell(
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
                            borderRadius: BorderRadius.all(Radius.circular(5))),
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
    await getAd();
    await fetchUsers();
    await fetchAddress();
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
