import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/authservice.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/controllers/sign_in_controller.dart';
import 'package:fooddelivery/screens/auth/forgot_password.dart';
import 'package:fooddelivery/screens/auth/signup.dart';
import 'package:fooddelivery/screens/auth/verify_phone.dart';
import 'package:fooddelivery/screens/auth/widgets/input_field.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignIn();
  }
}

class _SignIn extends State<SignIn> {
  final formKey = new GlobalKey<FormState>();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  late TextEditingController? phone;
  late String phoneNo, verificationId;
  bool isLoading = false;

  bool codeSent = false;

  @override
  void initState() {
    checkPermission();
    phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phone!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              // Kiểm tra xem có bị lỗi khi initialize không
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              // Nếu thành công thì hiển thị như lúc đầu chúng ta đã tạo
              if (snapshot.connectionState == ConnectionState.done) {
                return SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50.h,
                          ),
                          Container(
                              width: 414.w,
                              height: 280.h,
                              child: Center(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image(
                                      image: ResizeImage(
                                    AssetImage('assets/images/logo.png'),
                                    width: 200,
                                    height: 200,
                                  )),
                                ),
                              )),
                          Form(
                            autovalidateMode: AutovalidateMode.always,
                            key: formKey,
                            child: Builder(
                              builder: (BuildContext ctx) => Column(
                                children: [
                                  InputField(
                                    controller: phone,
                                    hintText: 'Số điện thoại',
                                    keyboardType: TextInputType.number,
                                    icon: Icons.phone,
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
                                  ),

                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  // codeSent==true?Container(height: 20.h,width: 300.w, color: Colors.red,):Container(),
                                  // InputField(
                                  //                               //   controller: controller.password,
                                  //                               //   obscureText: true,
                                  //                               //   hintText: 'Mật khẩu',
                                  //                               //   icon: Icons.vpn_key,
                                  //                               //   validator: (val) {
                                  //                               //     if (val!.length == 0) {
                                  //                               //       return 'Vui lòng nhập mật khẩu';
                                  //                               //     } else
                                  //                               //       return null;
                                  //                               //   },
                                  //                               // ),
                                  //                               // SizedBox(
                                  //                               //   height: 10.h,
                                  //                               // ),
                                  //                               // Align(
                                  //                               //   alignment: Alignment.centerRight,
                                  //                               //   child: TextButton(
                                  //                               //     onPressed: () {
                                  //                               //       Get.to(ForgotPassword());
                                  //                               //     },
                                  //                               //     child: Text(
                                  //                               //       'Quên mật khẩu ?',
                                  //                               //       style: TextStyle(color: Colors.grey),
                                  //                               //     ),
                                  //                               //   ),
                                  //                               // ),
                                  Container(
                                    height: 60.h,
                                    width: 414.w,
                                    padding: EdgeInsets.only(
                                        left: 24.w, right: 24.w),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: TextButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          print(phone!.text);
                                          if (isLoading == false) {
                                            await verifyPhone(phone!.text);
                                          }
                                        }
                                        // Get.to(VerifyPhone(), arguments: {
                                        //   'numberPhone': phone!.text,
                                        // });
                                        // await saveToken(
                                        //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjAxNWMwZTdjNTdkNGZhYTRhYzU3YmJiZmQ0ZTZjOTIxNjI1YWI0OTM5MWZkOWViZjY0M2E1YmE2MzE0OWY4NzVmOTBhYjNmMWM2ZTAzZTciLCJpYXQiOjE2Mjc2NzU2NDguNjYyMTcyLCJuYmYiOjE2Mjc2NzU2NDguNjYyMTgsImV4cCI6MTY1OTIxMTY0OC40NTczNjYsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.R6nyyfpag5jwgvrYQTWbk41yoDJBkNxctS1za-H_keIU1MbN9oXngGnKet2QZbQeW-RPrD9qYxyu6t1nWQZtY7MzVsvI5DL8wM3CxaN8bt4RK5G1aEexWNsGoH2A66vM6iPSXyXlxPzhOmGia2Pgq_p323899U8ebS-GldXVD_r7gyFfvhddaU2tEK5WNmt-xeStCzKYC4uTyM-vcUHp7nVRj-N56u2_aPQRKcbjTumuRs9WbVuRASuyaCxu07zudlE5IqnVTRkk1ASTkudc1sBJmg1VljiBl0wGMyxvV_P1AlkxdFY_vItHAQu5pDpXXdjB-94DpxWXOHiBE3QKkhJfsj4oZr-9t1RGqehqhBe4e16MdYOs33HeTH2xwz2BlVPE0IUue2o9YWanxg7mY2Rth7S984XzTFmZnlgzWn84dZJYJZ6V1JH8pb3EHduxH4t91v89iY-R994NNXgbX_UpENWu2B5QAmQ_lCzGpl85W4YbGGvsISimyMQpZGVejkoz8151zr7vWfzEU_bTxSI-HkJZDqisJmci7c1RkNTaNFa4yxmrfVvwI0U9nE3KsGiQobk48mupiODVDBrUPa2qOk9J-AhUkiXu82-51Qx7a_hijaUIOwejXB3zg3OZvC7FNF1bKbHGdL8efO3Ry713a9XnZ10fKqAgrlPPOGs');
                                        // Get.to(BottomNavigation(selectedIndex: 2,));
                                        // Get.to(SignUp());
                                      },
                                      child: Text(
                                        'Đăng nhập/Đăng ký'.toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10.h,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: <Widget>[
                                  //     Text("Bạn chưa có tài khoản ? "),
                                  //     TextButton(
                                  //       onPressed: () {
                                  //         Get.to(
                                  //           SignUp(),
                                  //         );
                                  //       },
                                  //       child: Text(
                                  //         "Đăng ký",
                                  //         style:
                                  //             TextStyle(color: Color(0xff47A4FF)),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 30.h,
                            child: SizedBox(
                              height: 30.h,
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: <Widget>[
                          //     Container(
                          //       color: Color(0xffDFDFDF),
                          //       height: 2.h,
                          //       width: 100.w,
                          //     ),
                          //     SizedBox(
                          //       width: 10.h,
                          //     ),
                          //     Text(
                          //       'Hoặc',
                          //       style: TextStyle(
                          //         fontSize: 16.sp,
                          //         color: Colors.grey,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 10.h,
                          //     ),
                          //     Container(
                          //       width: 100.w,
                          //       color: Color(0xffDFDFDF),
                          //       height: 2.h,
                          //     )
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 40.h,
                          // ),
                          // Center(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       InkWell(
                          //         onTap: () {
                          //           controller.signInWithFacebook();
                          //         },
                          //         child: Container(
                          //           width: 50.w,
                          //           height: 50.h,
                          //           decoration: BoxDecoration(
                          //             color: Theme.of(context).primaryColor,
                          //             shape: BoxShape.circle,
                          //             border: Border.all(
                          //               width: 1,
                          //               color: Theme.of(context).primaryColor,
                          //             ),
                          //           ),
                          //           child: Center(
                          //             child: Image.asset(
                          //                 'assets/logos/Facebook_Logo.png'),
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         width: 20.h,
                          //       ),
                          //       Container(
                          //         width: 50.w,
                          //         height: 50.h,
                          //         decoration: BoxDecoration(
                          //           // color: Color(0xffff4645),
                          //           shape: BoxShape.circle,
                          //         ),
                          //         child: Center(
                          //           child: GestureDetector(
                          //             onTap: () {
                          //               // controller.google_SignIn();
                          //               controller.google_SignIn();
                          //             },
                          //             child: Image.asset(
                          //               'assets/logos/Google_Logo.png',
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                );
              }
              // Đang load
              return CircularProgressIndicator();
            },
          ),
          Positioned.fill(
            child: Center(
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                width: 100.w,
                height: 100.h,
                child: isLoading ? Loading() : Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Vị trí"),
          content: new Text(
              "Bạn đang tắt quyền truy cập vị trí\n\nViệc cho phép truy cập vị trí sẽ giúp định vị đúng vị trí để giao  hàng chính xác hơn."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Hủy"),
              onPressed: () {
                Get.back();
              },
            ),
            new TextButton(
              child: new Text("Đồng ý"),
              onPressed: () {
                Get.back();
                loadData();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      _showDialog();
    } else {
      loadData();
    }
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

    Position position = await getPosition();
    String street = await getStreet(position);
    String locality = await getLocality(position);
    String a = await getAddress(position);
    String address;
    setState(() {
      address = (street + ', ' + locality + ', ' + a);
      setValue('address', address);
    });
  }

  Future<String> getStreet(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].street!.isNotEmpty) {
        return placemarks[i].street!;
      }
    }
    return '';
  }

  Future<String> getLocality(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].locality!.isNotEmpty) {
        return placemarks[i].locality!;
      }
    }
    return '';
  }

  Future<Position> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    return position;
  }

  Future<String> getAddress(Position position) async {
    // List<String> address = [];
    String address = '';

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
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

  Future<void> verifyPhone(phoneNo) async {
    setState(() {
      isLoading = true;
    });
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      //login với firebase
      await AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      setState(() {
        isLoading = false;
      });
      showToast('Số điện thoại không chính xác');
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String? verId, [int? forceResend]) {
      this.verificationId = verId!;
      setState(() {
        this.codeSent = true;
        isLoading = false;
        Get.to(VerifyPhone(), arguments: {
          'numberPhone': phone!.text,
          'verificationId': verificationId
        });
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.setLanguageCode('VI');

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+84' + phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
