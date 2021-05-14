import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/forgot_password.dart';
import 'package:fooddelivery/screens/signup.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height / 5.5,
                maxHeight: MediaQuery.of(context).size.height / 3.2,
              ),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Image(
                        image: ResizeImage(
                      AssetImage('assets/images/logo-food-delivery.png'),
                      width: 100,
                      height: 100,
                    )),
                  ),
                )),
            Container(
              constraints: BoxConstraints(
                // minHeight: MediaQuery.of(context).size.height / 3,
                maxHeight: MediaQuery.of(context).size.height / 2.4,
              ),
              // height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 60.h),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45.h,
                    padding:
                        EdgeInsets.only(top: 4.h, left: 16.w, right: 16.w, bottom: 4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: 'Email/Số điện thoại',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45.h,
                    // margin: EdgeInsets.only(top: 32),
                    margin: EdgeInsets.only(top: 15.h),
                    padding:
                        EdgeInsets.only(top: 4.h, left: 16.w, right: 16.w, bottom: 4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.vpn_key,
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: 'Mật khẩu',
                      ),
                    ),
                  ),
                  InkWell(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.h, right: 32.w),
                          child: Text(
                            'Quên mật khẩu ?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(ForgotPassword());
                      }),
                  Spacer(),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Container(
                      height: 45.h,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          'Đăng nhập'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Bạn chưa có tài khoản ? "),
                        Text(
                          "Đăng ký",
                          style: TextStyle(color: Color(0xff47A4FF)),
                        ),
                      ],
                    ),
                    onTap: () {
                      Get.to(SignUp());
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 30.h,
              // constraints: BoxConstraints(
              //   minHeight: 20,
              //   maxHeight: 30,
              // ),
              child:   SizedBox(
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
            Container(
              // constraints: BoxConstraints(
              //   minHeight: MediaQuery.of(context).size.height / 7,
              //   maxHeight: MediaQuery.of(context).size.height / 6,
              // ),
              height: MediaQuery.of(context).size.height / 6.5,
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.only(top: 60),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // constraints: BoxConstraints(
                      //   minHeight: 20,
                      //   maxHeight: 50,
                      // ),
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //   // colors: [
                        //   //   Color(0xff1346b4),
                        //   //   Color(0xff0cb2eb),
                        //   // ],
                        // ),
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Theme.of(context).primaryColor,),
                      ),
                      child: Center(
                        child: Image.asset('assets/logos/Facebook_Logo.png'),
                        // child: Icon(
                        //   FontAwesomeIcons.facebookF,
                        //   color: Colors.white,
                        //   size: 20,
                        // ),
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
                        child: Image.asset('assets/logos/Google_Logo.png',),
                        // child: Icon(
                        //   FontAwesomeIcons.google,
                        //   color: Colors.white,
                        //   size: 20,
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
