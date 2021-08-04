import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/authservice.dart';
import 'package:fooddelivery/screens/auth/widgets/input_field.dart';
import 'package:get/get.dart';

class VerifyPhone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerifyPhone();
  }
}

class _VerifyPhone extends State<VerifyPhone> {
  late TextEditingController? code;

  late String numberPhone, verificationId;

  @override
  void initState() {
    code = TextEditingController();
    numberPhone = Get.arguments['numberPhone'];
    verificationId = Get.arguments['verificationId'];
    super.initState();
  }

  @override
  void dispose() {
    code!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhập Mã Xác Minh'),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 414.w,
          height: 834.h,
          padding: EdgeInsets.only(top: 50.h, left: 30.w, right: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Mã xác minh của bạn đã được gửi tới số',
                style: TextStyle(fontSize: 18.sp),
                softWrap: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                numberPhone,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                softWrap: true,
              ),
              SizedBox(
                height: 50.h,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Mã xác minh',
                ),
                controller: code,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.length == 0) {
                    return 'Vui lòng nhập Mã xác minh';
                  } else if (!val.isNum) {
                    return 'Sai định dạng Mã xác minh';
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
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextButton(
                  onPressed: () async {
                    print(code!.text);
                    var isSignSMS = await AuthService()
                        .signInWithOTP(code!.text, verificationId);
                    print(isSignSMS);

                    if (isSignSMS == true) {
                      print("vào ddaa7f true đi bạn $isSignSMS");
                      await AuthService().loginAndRegisterPhone(numberPhone);
                    }
                  },
                  child: Text(
                    'Tiếp tục'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
