import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/auth_controller.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:fooddelivery/screens/auth/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends GetWidget<AuthController> {
  AuthController controller = Get.put(AuthController());

  // TextEditingController username = TextEditingController();
  //
  // TextEditingController email = TextEditingController();

  // TextEditingController phone = TextEditingController();
  var confirmPass = null;

  // TextEditingController re_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          "Đăng ký",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 414.w,
                height: 160.h,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/logo-food-delivery.png'),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Form(
                // key: controller.formKeySignUp,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Builder(
                  builder: (BuildContext ctx) => Column(
                    children: [
                      InputField(
                        validator: (val) {
                          if (val!.length == 0) return "Vui lòng nhập tên";
                        },
                        hintText: 'Tên người dùng',
                        icon: Icons.person,
                        controller: controller.username,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InputField(
                        validator: (val) {
                          if (val!.length == 0)
                            return "Vui lòng nhập Email";
                          else if (!controller.isEmail(val))
                            return "Sai định dạng Email";
                          else
                            return null;
                        },
                        controller: controller.email,
                        hintText: 'Email',
                        icon: Icons.email,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InputField(
                        validator: (val) {
                          if (val!.length == 0)
                            return "Vui lòng nhập số điện thoại";
                          else if (!val.isNum) {
                            return 'Vui lòng nhập số điện thoại';
                          }
                          return null;
                        },
                        controller: controller.phone,
                        hintText: 'Số điện thoại',
                        icon: Icons.phone,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InputField(
                        obscureText: true,
                        validator: (val) {
                          confirmPass = val!;
                          if (val.length == 0)
                            return "Vui lòng nhập mật khẩu";
                          else if (val.length < 8)
                            return "Mật khẩu lớn hơn 8 ký tự";
                          else
                            return null;
                        },
                        controller: controller.password,
                        hintText: 'Mật khẩu',
                        icon: Icons.vpn_key,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InputField(
                        obscureText: true,
                        validator: (val) {
                          if (val!.length == 0)
                            return "Vui lòng nhập mật khẩu";
                          else if (val.length < 8)
                            return "Mật khẩu lớn hơn 8 ký tự";
                          else if (confirmPass != val)
                            return 'Không khớp mật khẩu';
                          return null;
                        },
                        hintText: 'Xác nhận mật khẩu',
                        icon: Icons.vpn_key,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        height: 50.h,
                        width: 414.w,
                        padding: EdgeInsets.only(left: 24.w, right: 24.w),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                          onPressed: () {
                            controller.register(ctx);
                          },
                          child: Text(
                            'Đăng Ký'.toUpperCase(),
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
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Bạn đã có tài khoản? "),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(color: Color(0xff47A4FF)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
