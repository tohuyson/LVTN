import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
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
                                  Container(
                                    height: 60.h,
                                    width: 414.w,
                                    padding: EdgeInsets.only(left: 24.w, right: 24.w),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                    child: TextButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          print(phone!.text);
                                          if (isLoading == false) {
                                            await verifyPhone(phone!.text);
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Đăng nhập/Đăng ký'.toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
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

  Future<void> checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showToast('Vui lòng bật vị trí!');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {
      await loadData();
    }
  }

  Future<void> loadData() async {
    List<Placemark> placemark = await getPosition();
    String street = await getStreet(placemark);
    String locality = await getLocality(placemark);
    String a = await getAddress(placemark);
    String address;
    address = (street + ', ' + locality + ', ' + a);
    await setValue('address', address);
    await setValue("latitude", latitude);
    await setValue('longitude', longitude);
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

  Future<String> getAddress(List<Placemark> placemarks) async {
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

  Future<void> verifyPhone(phoneNo) async {
    setState(() {
      isLoading = true;
    });
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      setState(() {
        isLoading = false;
      });
      showToast('Số điện thoại không chính xác');
    };

    final PhoneCodeSent smsSent = (String? verId, [int? forceResend]) {
      this.verificationId = verId!;
      print(verId);
      setState(() {
        this.codeSent = true;
        isLoading = false;
      });
      Get.to(VerifyPhone(), arguments: {
        'numberPhone': phone!.text,
        'verificationId': verificationId.trim(),
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+84' + phoneNo,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
