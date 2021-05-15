import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/components/address_item.dart';
import 'package:fooddelivery/components/list_widget.dart';

class Address extends StatelessWidget {
  final int selectedIndex;

  Address(this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    List<AddressItem> list = [
      AddressItem(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      AddressItem(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      AddressItem(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      AddressItem(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      AddressItem(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      AddressItem(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      AddressItem(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      AddressItem(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      AddressItem(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),
      AddressItem(
        addressdetail: 'Tòa nhà cẩm tú',
        address: 'Đường số 9, Linh Trung, Thủ Đức, Hồ Chí Minh',
        username: 'Mỹ Duyên',
        phone: '0773555858',
      ),


    ];
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Địa chỉ',
              style: TextStyle(color: Colors.black, fontSize: 22.sp),
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.map,
                  color: Colors.black,
                  size: 28.sp,
                ),
                onPressed: () {
                  print("Map");
                }),
          ],
        ),
        body: ListView(
          // shrinkWrap: true,
          children: [
            Container(
              color: Color(0xFFEEEEEE),
              width: MediaQuery.of(context).size.width,
              // height:MediaQuery.of(context).size.height / 1.221 ,
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
              child: Column(
                children: [
                  Container(
                    height: 40.h,
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
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
                    margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                    padding: EdgeInsets.only(
                        left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
                    child: Text(
                      'Địa chỉ đã lưu',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.356,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ListWidget(list),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                            height: 45.h,
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                'Thêm địa chỉ mới'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
          ],
        ));
  }
}
