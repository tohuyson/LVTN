import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum SingingCharacter { staff, student }

class Delivery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Delivery();
  }
}

class _Delivery extends State<Delivery> {
  SingingCharacter? _character = SingingCharacter.staff;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giao hàng'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nhân viên quán',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Row(
                      children: [
                        Text(
                          '2000đ',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Radio<SingingCharacter>(
                          value: SingingCharacter.staff,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sinh viên',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Row(
                      children: [
                        Text(
                          '5000đ',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Radio<SingingCharacter>(
                          value: SingingCharacter.student,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 70.h,
            width: 414.w,
            padding: EdgeInsets.all(12.w),
            child: InkWell(
              onTap: () {
                if (_character == SingingCharacter.staff) {
                  Get.back(result: new RxString('Nhân viên'));
                }
                if (_character == SingingCharacter.student) {
                  Get.back(result: new RxString('Sinh Viên'));
                }
                print('Xác nhận');
              },
              child: Container(
                height: 46.h,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    'Xác nhận',
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
