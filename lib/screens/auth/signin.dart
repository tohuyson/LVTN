import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/sign_in_controller.dart';
import 'package:fooddelivery/screens/auth/forgot_password.dart';
import 'package:fooddelivery/screens/auth/signup.dart';
import 'package:fooddelivery/screens/auth/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends GetWidget<SignInController> {
  SignInController controller = Get.put(SignInController());
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
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
                          Container(
                              width: 414.w,
                              height: 280.h,
                              child: Center(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image(
                                      image: ResizeImage(
                                    AssetImage(
                                        'assets/images/logo-food-delivery.png'),
                                    width: 100,
                                    height: 100,
                                  )),
                                ),
                              )),
                          Form(
                            // key: controller.formKeySignIn,
                            child: Builder(
                              builder: (BuildContext ctx) => Column(
                                children: [
                                  InputField(
                                    controller: controller.email,
                                    hintText: 'Email',
                                    icon: Icons.person,
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return 'Vui lòng nhập Email hoặc Số điện thoại';
                                      } else if (!val.isEmail) {
                                        return 'Sai định dạng Email';
                                      } else
                                        return null;
                                    },
                                    // onChanged: (val) {
                                    //   controller.email = val;
                                    // },
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  InputField(
                                    controller: controller.password,
                                    obscureText: true,
                                    hintText: 'Mật khẩu',
                                    icon: Icons.vpn_key,
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return 'Vui lòng nhập mật khẩu';
                                      } else
                                        return null;
                                    },
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Get.to(ForgotPassword());
                                      },
                                      child: Text(
                                        'Quên mật khẩu ?',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50.h,
                                    width: 414.w,
                                    padding: EdgeInsets.only(
                                        left: 24.w, right: 24.w),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: TextButton(
                                      onPressed: () {
                                        controller.login(ctx);
                                      },
                                      child: Text(
                                        'Đăng nhập'.toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Bạn chưa có tài khoản ? "),
                                      TextButton(
                                        onPressed: () {
                                          Get.to(
                                            SignUp(),
                                          );
                                        },
                                        child: Text(
                                          "Đăng ký",
                                          style: TextStyle(
                                              color: Color(0xff47A4FF)),
                                        ),
                                      ),
                                    ],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                color: Color(0xffDFDFDF),
                                height: 2.h,
                                width: 100.w,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'Hoặc',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 10.h,
                              ),
                              Container(
                                width: 100.w,
                                color: Color(0xffDFDFDF),
                                height: 2.h,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.signInWithFacebook();
                                  },
                                  child: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                          'assets/logos/Facebook_Logo.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.h,
                                ),
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    // color: Color(0xffff4645),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        // controller.google_SignIn();
                                        controller.google_SignIn();
                                      },
                                      child: Image.asset(
                                        'assets/logos/Google_Logo.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              // Đang load
              return CircularProgressIndicator();
            }));
  }
}
