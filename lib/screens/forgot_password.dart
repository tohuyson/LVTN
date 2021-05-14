import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/signin.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Get.to(SignIn())),
        centerTitle: true,
        title: Text(
          'Quên mật khẩu',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60.h, left: 40.w, right: 40.w),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
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
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height / 8,
                    // maxHeight: MediaQuery.of(context).size.height / 4,
                  ),
                  child: Text(
                      'Nhập địa chỉ email của bạn vào bên dưới và chúng tôi sẽ gửi cho bạn một email kèm theo hướng dẫn về cách thay đổi mật khẩu của bạn'),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      // SizedBox(
                      //   height: 50,
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 45.h,
                        padding: EdgeInsets.only(
                            top: 4.h, left: 16.w, right: 16.w, bottom: 4.h),
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
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            ),
                            hintText: 'Email',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: Container(
                          height: 45.h,
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: Text(
                              'Quên mật khẩu'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
