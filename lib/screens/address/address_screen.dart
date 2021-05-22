import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/address.dart';

import 'address_item.dart';

class AddressScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<Address> list = [
      Address(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      Address(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      Address(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      Address(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      Address(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      Address(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      Address(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      Address(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
    ];
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            'Địa chỉ',
            style: TextStyle(color: Colors.white,),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.map,
                  color: Colors.white,
                  size: 24.sp,
                ),
                onPressed: () {
                  print("Map");
                }),
          ],
        ),
        body: Container(
          height:  834.h,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.h),
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                ),
                width: double.infinity,
                height: 40.h,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        borderSide: BorderSide(color: Colors.black26),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black26,
                      ),
                      hintStyle: new TextStyle(
                        color: Colors.black38,
                        fontSize: 16.sp,
                      ),
                      hintText: "Nhập địa chỉ",
                      contentPadding: EdgeInsets.all(15)),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
                child: Text(
                  'Địa chỉ đã lưu',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(child: ListView(
                children: [
                  for(Address w in list) AddressItem(address: w,),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
                      height: 45.h,
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text(
                          'Thêm địa chỉ mới'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )),

            ],
          ),
        ));
  }
}
