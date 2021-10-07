import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/auth_controller.dart';
import 'package:fooddelivery/screens/auth/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: BackButton(
          color: Colors.black,
        ),
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
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
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
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 366.w,
                  child: Text(
                      'Nhập địa chỉ email của bạn vào bên dưới và chúng tôi sẽ gửi cho bạn một email kèm theo hướng dẫn về cách thay đổi mật khẩu của bạn'),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  width: 414.w,
                  child: Column(
                    children: <Widget>[
                      InputField(
                        hintText: 'Email',
                        icon: Icons.email,
                        validator: (val) {
                          if (val!.length == 0) {
                            return 'Vui lòng nhập Email hoặc Số điện thoại';
                          } else if (!val.isEmail) {
                            return 'Sai định dạng Email';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: 40.h,
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
                          onPressed: () {},
                          child: Text(
                            'Quên mật khẩu'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
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
