import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/controllers/date_controller.dart';
import 'package:fooddelivery/controllers/profile_controllor.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../apis.dart';
import '../../utils.dart';

late Rx<Users?> user;
late Users? lu;
final DateController controllerDate = Get.put(DateController());

class InformationUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InformationUser();
  }
}

class _InformationUser extends State<InformationUser> {
  ProfileController controller = Get.put(ProfileController());
  List listgender = ["Nam", "Nữ", "Khác"];
  String selected = '';
  String? avatar;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUsers(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  title: Text("Thông tin người dùng"),
                  leading: BackButton(),
                ),
                body: Container(
                  padding: EdgeInsets.only(top: 5.h),
                  color: Color(0xFFEEEEEE),
                  height: 834.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        color: Color(0xFFFFFFFF),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 60.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black12),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                margin: EdgeInsets.all(5),
                                child: GetBuilder<ProfileController>(
                                  builder: (_) {
                                    return lu!.avatar != null
                                        ? controller.image == null
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                child: Image.network(
                                                  Apis.baseURL + lu!.avatar!,
                                                  width: 100.w,
                                                  height: 100.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                child: Image.file(
                                                  controller.image!,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                        : controller.image == null
                                            ? Icon(
                                                Icons.add_a_photo,
                                                color: Colors.grey,
                                                size: 25.0.sp,
                                              )
                                            : ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                child: Image.file(
                                                  controller.image!,
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                  },
                                )),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Thay đổi hình đại diện',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        await controller.getImage();
                                        await changeAvatar();
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
                      Container(
                        color: Color(0xFFFFFFFF),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          width: 0.2, color: Colors.black12))),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0.2.h),
                              color: Color(0xFFFFFFFF),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 15.w, right: 10.w),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.3,
                                                color: Colors.black12))),
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Số điện thoại',
                                            style: TextStyle(fontSize: 17.sp),
                                          ),
                                        ),
                                        Container(
                                          height: 55.h,
                                          margin: EdgeInsets.only(right: 20.w),
                                          child: Center(
                                            child: user.value!.phone! == null
                                                ? Text('')
                                                : Text(
                                                    user.value!.phone!,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        color: Color(0xFFFFFFFF),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15.w, right: 10.w),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.3, color: Colors.black12))),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      'Tên',
                                      style: TextStyle(fontSize: 17.sp),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          user.value!.username!,
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        title: Text('Tên'),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              ItemField(
                                                                controller:
                                                                    username,
                                                                hintText:
                                                                    "Tên người dùng",
                                                                type:
                                                                    TextInputType
                                                                        .text,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Get.back(),
                                                            child: const Text(
                                                              'Hủy',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              await changeName();
                                                              setState(() {
                                                                user.refresh();
                                                                Get.back();
                                                                showToast(
                                                                    "Cập nhật thành công");
                                                              });
                                                            },
                                                            child: const Text(
                                                              'Lưu lại',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ),
                                                        ]);
                                                  });
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
                          ],
                        ),
                      ),
                      Container(
                        color: Color(0xFFFFFFFF),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15.w, right: 10.w),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.3, color: Colors.black12))),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      'Email',
                                      style: TextStyle(fontSize: 17.sp),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        user.value!.email == null
                                            ? Text('')
                                            : Text(
                                                user.value!.email!,
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        title: Text('Email'),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              ItemField(
                                                                controller:
                                                                    email,
                                                                hintText:
                                                                    "Email",
                                                                type:
                                                                    TextInputType
                                                                        .text,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Get.back(),
                                                            child: const Text(
                                                              'Hủy',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              await changeEmail();
                                                              setState(() {
                                                                user.refresh();
                                                                Get.back();
                                                                showToast(
                                                                    "Cập nhật thành công");
                                                              });
                                                            },
                                                            child: const Text(
                                                              'Lưu lại',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ),
                                                        ]);
                                                  });
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
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0.2.h),
                        color: Color(0xFFFFFFFF),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15.w, right: 10.w),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.3, color: Colors.black12))),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      'Giới tính',
                                      style: TextStyle(fontSize: 17.sp),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        user.value!.gender != null
                                            ? Text(
                                                user.value!.gender!,
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.blue,
                                                ),
                                              )
                                            : Text(
                                                'Vui lòng thêm',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        title:
                                                            Text('Giới tính'),
                                                        content:
                                                            StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              StateSetter
                                                                  setState) {
                                                            return SingleChildScrollView(
                                                              child: Container(
                                                                  width: double
                                                                      .maxFinite,
                                                                  child: Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: <
                                                                          Widget>[
                                                                        ConstrainedBox(
                                                                          constraints:
                                                                              BoxConstraints(
                                                                            maxHeight:
                                                                                MediaQuery.of(context).size.height * 0.4,
                                                                          ),
                                                                          child: ListView.builder(
                                                                              shrinkWrap: true,
                                                                              itemCount: listgender.length,
                                                                              itemBuilder: (BuildContext context, int index) {
                                                                                return RadioListTile<String>(
                                                                                  title: Text(listgender[index]),
                                                                                  value: listgender[index],
                                                                                  groupValue: selected,
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      selected = value!;
                                                                                    });
                                                                                  },
                                                                                );
                                                                              }),
                                                                        ),
                                                                      ])),
                                                            );
                                                          },
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Get.back(),
                                                            child: const Text(
                                                              'Hủy',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              await changeGender();
                                                              setState(() {
                                                                user.refresh();
                                                                Get.back();
                                                                showToast(
                                                                    "Cập nhật thành công");
                                                              });
                                                            },
                                                            child: const Text(
                                                              'Lưu lại',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ),
                                                        ]);
                                                  });
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
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0.2.h),
                        color: Color(0xFFFFFFFF),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15.w, right: 10.w),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.3, color: Colors.black12))),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      'Ngày sinh',
                                      style: TextStyle(fontSize: 17.sp),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        user.value!.dob != null
                                            ? Text(
                                                user.value!.dob.toString(),
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.blue,
                                                ),
                                              )
                                            : Text(
                                                'Vui lòng thêm',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        content: Date(),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Get.back(),
                                                            child: const Text(
                                                              'Hủy',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              await changeDob();
                                                              setState(() {
                                                                user.refresh();
                                                                Get.back();
                                                                showToast(
                                                                    "Cập nhật thành công");
                                                              });
                                                            },
                                                            child: const Text(
                                                              'Lưu lại',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ),
                                                        ]);
                                                  });
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          } else {
            return Container();
          }
        });
  }

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController gender;

  User? userFirebase;

  @override
  void initState() {
    controller.image = null;
    userFirebase = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  Future<bool?> fetchUsers() async {
    var u = await getUser();
    if (u != null) {
      user = u.obs;
      lu = u;
    }
    username = TextEditingController(text: lu!.username);
    email = TextEditingController(text: lu!.email);
    phone = TextEditingController(text: lu!.phone.toString());
    gender = TextEditingController(text: lu!.gender);
    return user.isBlank;
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
      if (response.statusCode == 401) {}
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return null;
  }

  Future<Users?> changeAvatar() async {
    String? token = await getToken();
    String? nameImage;
    if (lu!.avatar != null) {
      if (controller.imagePath != null) {
        int code =
            (await uploadAvatar(controller.image!, controller.imagePath!))!;
        if (code == 200) {
          nameImage = controller.imagePath!.split('/').last;
        }
      } else {
        nameImage = lu!.avatar!.split('/').last;
      }
    } else {
      if (controller.imagePath != null) {
        int code =
            (await uploadAvatar(controller.image!, controller.imagePath!))!;
        if (code == 200) {
          nameImage = controller.imagePath!.split('/').last;
        }
      }
    }
    try {
      EasyLoading.show(status: 'Loading...');
      http.Response response = await http.post(
        Uri.parse(Apis.changeAvatarUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'avatar': nameImage,
        }),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        var parsedJson = jsonDecode(response.body);
        Users users = Users.fromJson(parsedJson['user']);

        userFirebase!.updatePhotoURL(Apis.baseURL + users.avatar!);
        FirebaseFirestore.instance
            .collection('users')
            .doc(userFirebase!.uid)
            .update({'photoUrl': Apis.baseURL + users.avatar!});
        return users;
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }

  Future<Users?> changeName() async {
    String? token = await getToken();
    try {
      EasyLoading.show(status: 'Loading...');
      http.Response response = await http.post(
        Uri.parse(Apis.changeNameUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'username': username.text,
        }),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        var parsedJson = jsonDecode(response.body);
        Users users = Users.fromJson(parsedJson['user']);
        return users;
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }

  Future<Users?> changeEmail() async {
    String? token = await getToken();
    try {
      EasyLoading.show(status: 'Loading...');
      http.Response response = await http.post(
        Uri.parse(Apis.changeEmailUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'email': email.text,
        }),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        var parsedJson = jsonDecode(response.body);
        Users users = Users.fromJson(parsedJson['user']);
        return users;
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }

  Future<Users?> changeDob() async {
    String? token = await getToken();
    String? dob = controllerDate.dob;
    try {
      EasyLoading.show(status: 'Loading...');
      http.Response response = await http.post(
        Uri.parse(Apis.changeDobUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'dob': dob,
        }),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        var parsedJson = jsonDecode(response.body);
        Users users = Users.fromJson(parsedJson['user']);
        return users;
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }

  Future<Users?> changeGender() async {
    String? token = await getToken();
    if (selected != null || selected != '') {
      try {
        EasyLoading.show(status: 'Loading...');
        http.Response response = await http.post(
          Uri.parse(Apis.changeGenderUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': "Bearer $token",
          },
          body: jsonEncode(<String, dynamic>{
            'gender': selected,
          }),
        );

        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          var parsedJson = jsonDecode(response.body);
          Users users = Users.fromJson(parsedJson['user']);
          return users;
        }
      } on TimeoutException catch (e) {
        showError(e.toString());
      } on SocketException catch (e) {
        showError(e.toString());
      }
    } else {
      showToast('Vui lòng chọn giới tính');
    }
  }
}

class ItemInfor extends StatelessWidget {
  String? title;
  String? description;

  ItemInfor({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 10.w),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.3, color: Colors.black12))),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              title!,
              style: TextStyle(fontSize: 17.sp),
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  description!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                    onPressed: () {
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 14,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Date extends StatelessWidget {
  final DateController controller = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: EdgeInsets.only(left: 15.w), child: Text('Ngày sinh')),
          Row(
            children: [
              GetBuilder<DateController>(builder: (context) {
                return Text(
                  controller.dob,
                  style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                );
              }),
              IconButton(
                onPressed: () {
                  controller.selectDateDob(context);
                },
                icon: Icon(
                  Icons.calendar_today_rounded,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ItemField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? type;
  final String? hintText;
  final ValueChanged<String>? onChanged;

  const ItemField(
      {this.hintText,
      this.controller,
      this.validator,
      this.type,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        keyboardType: type,
        style: TextStyle(fontSize: 16.0.sp, color: Colors.black),
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding:
              EdgeInsets.only(top: 20.h, bottom: 20.h, left: 12.w, right: 15.w),
          hintText: hintText,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0.w),
            borderSide: const BorderSide(color: Colors.black12, width: 0.1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12, width: 0.7),
          ),
        ),
      ),
    );
  }
}
