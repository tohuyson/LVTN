import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Address extends StatelessWidget {
  final int selectedIndex;

  Address(this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Địa chỉ',
            style: TextStyle(color: Colors.black,fontSize: 22.sp),
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
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
            child: Column(
              children: [
                Container(
                  height: 40.h,
                  child: TextField(
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(5)),
                      //   borderSide: BorderSide(
                      //     width: 1.w,
                      //     style: BorderStyle.none,
                      //   ),
                      // ),
                        filled: true,
                        // prefixIcon: Icon(
                        //   Icons.search,
                        //   color: Colors.black,
                        // ),
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
                          fontSize: 16.sp,),
                        hintText: "Nhập địa chỉ",
                        contentPadding: EdgeInsets.all(15)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  // color: Colors.black12,
                  margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  padding:
                  EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
                  child: Text(
                    'Địa chỉ đã lưu',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
               Container(
                 height:MediaQuery.of(context).size.height / 1.356 ,
                 child:  ListView(
                 shrinkWrap: true,
                 children: [
                   Container(
                       height: 80.h,
                       margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                       padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                       // color: Color(0xFFF1F1F1),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(2)),
                         border: Border.all(width: 0,color: Colors.black12),
                         color: Colors.white,
                       ),
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             IconButton(
                                 icon: Icon(
                                   Icons.location_on,
                                   color: Colors.black,
                                   size: 32.sp,
                                 ),
                                 onPressed: () {
                                   print("Map");
                                 }),
                             Container(
                               child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Tòa cẩm tú',
                                     style: TextStyle(
                                         fontSize: 16.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     'Đường số 9, linh trung thủ đức, Hồ chí minh',
                                     style: TextStyle(
                                         fontSize: 15.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Row(
                                     children: [
                                       Text('Mỹ Duyên', style:TextStyle(
                                           fontSize: 16.sp,
                                           fontWeight: FontWeight.w400) ,),
                                       SizedBox(
                                         width: 30.w,
                                       ),
                                       Text('0773555859')
                                     ],
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(
                               width: 20.w,
                             ),
                             Container(
                               padding: EdgeInsets.only(right: 5.w),
                               child:  Text(
                                 'Sửa',
                                 style: TextStyle(color: Colors.cyan,),
                               ),
                             )
                           ],
                         ),
                       )),
                   Container(
                       height: 80.h,
                       margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                       padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                       // color: Color(0xFFF1F1F1),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(2)),
                         border: Border.all(width: 0,color: Colors.black12),
                         color: Colors.white,
                       ),
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             IconButton(
                                 icon: Icon(
                                   Icons.location_on,
                                   color: Colors.black,
                                   size: 32.sp,
                                 ),
                                 onPressed: () {
                                   print("Map");
                                 }),
                             Container(
                               child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Tòa cẩm tú',
                                     style: TextStyle(
                                         fontSize: 16.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     'Đường số 9, linh trung thủ đức, Hồ chí minh',
                                     style: TextStyle(
                                         fontSize: 15.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Row(
                                     children: [
                                       Text('Mỹ Duyên', style:TextStyle(
                                           fontSize: 16.sp,
                                           fontWeight: FontWeight.w400) ,),
                                       SizedBox(
                                         width: 30.w,
                                       ),
                                       Text('0773555859')
                                     ],
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(
                               width: 20.w,
                             ),
                             Container(
                               padding: EdgeInsets.only(right: 5.w),
                               child:  Text(
                                 'Sửa',
                                 style: TextStyle(color: Colors.cyan,),
                               ),
                             )
                           ],
                         ),
                       )),
                   Container(
                       height: 80.h,
                       margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                       padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                       // color: Color(0xFFF1F1F1),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(2)),
                         border: Border.all(width: 0,color: Colors.black12),
                         color: Colors.white,
                       ),
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             IconButton(
                                 icon: Icon(
                                   Icons.location_on,
                                   color: Colors.black,
                                   size: 32.sp,
                                 ),
                                 onPressed: () {
                                   print("Map");
                                 }),
                             Container(
                               child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Tòa cẩm tú',
                                     style: TextStyle(
                                         fontSize: 16.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     'Đường số 9, linh trung thủ đức, Hồ chí minh',
                                     style: TextStyle(
                                         fontSize: 15.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Row(
                                     children: [
                                       Text('Mỹ Duyên', style:TextStyle(
                                           fontSize: 16.sp,
                                           fontWeight: FontWeight.w400) ,),
                                       SizedBox(
                                         width: 30.w,
                                       ),
                                       Text('0773555859')
                                     ],
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(
                               width: 20.w,
                             ),
                             Container(
                               padding: EdgeInsets.only(right: 5.w),
                               child:  Text(
                                 'Sửa',
                                 style: TextStyle(color: Colors.cyan,),
                               ),
                             )
                           ],
                         ),
                       )),
                   Container(
                       height: 80.h,
                       margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                       padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                       // color: Color(0xFFF1F1F1),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(2)),
                         border: Border.all(width: 0,color: Colors.black12),
                         color: Colors.white,
                       ),
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             IconButton(
                                 icon: Icon(
                                   Icons.location_on,
                                   color: Colors.black,
                                   size: 32.sp,
                                 ),
                                 onPressed: () {
                                   print("Map");
                                 }),
                             Container(
                               child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Tòa cẩm tú',
                                     style: TextStyle(
                                         fontSize: 16.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     'Đường số 9, linh trung thủ đức, Hồ chí minh',
                                     style: TextStyle(
                                         fontSize: 15.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Row(
                                     children: [
                                       Text('Mỹ Duyên', style:TextStyle(
                                           fontSize: 16.sp,
                                           fontWeight: FontWeight.w400) ,),
                                       SizedBox(
                                         width: 30.w,
                                       ),
                                       Text('0773555859')
                                     ],
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(
                               width: 20.w,
                             ),
                             Container(
                               padding: EdgeInsets.only(right: 5.w),
                               child:  Text(
                                 'Sửa',
                                 style: TextStyle(color: Colors.cyan,),
                               ),
                             )
                           ],
                         ),
                       )),
                   Container(
                       height: 80.h,
                       margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                       padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                       // color: Color(0xFFF1F1F1),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(2)),
                         border: Border.all(width: 0,color: Colors.black12),
                         color: Colors.white,
                       ),
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             IconButton(
                                 icon: Icon(
                                   Icons.location_on,
                                   color: Colors.black,
                                   size: 32.sp,
                                 ),
                                 onPressed: () {
                                   print("Map");
                                 }),
                             Container(
                               child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Tòa cẩm tú',
                                     style: TextStyle(
                                         fontSize: 16.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     'Đường số 9, linh trung thủ đức, Hồ chí minh',
                                     style: TextStyle(
                                         fontSize: 15.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Row(
                                     children: [
                                       Text('Mỹ Duyên', style:TextStyle(
                                           fontSize: 16.sp,
                                           fontWeight: FontWeight.w400) ,),
                                       SizedBox(
                                         width: 30.w,
                                       ),
                                       Text('0773555859')
                                     ],
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(
                               width: 20.w,
                             ),
                             Container(
                               padding: EdgeInsets.only(right: 5.w),
                               child:  Text(
                                 'Sửa',
                                 style: TextStyle(color: Colors.cyan,),
                               ),
                             )
                           ],
                         ),
                       )),
                   Container(
                       height: 80.h,
                       margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                       padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                       // color: Color(0xFFF1F1F1),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(2)),
                         border: Border.all(width: 0,color: Colors.black12),
                         color: Colors.white,
                       ),
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             IconButton(
                                 icon: Icon(
                                   Icons.location_on,
                                   color: Colors.black,
                                   size: 32.sp,
                                 ),
                                 onPressed: () {
                                   print("Map");
                                 }),
                             Container(
                               child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Tòa cẩm tú',
                                     style: TextStyle(
                                         fontSize: 16.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     'Đường số 9, linh trung thủ đức, Hồ chí minh',
                                     style: TextStyle(
                                         fontSize: 15.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Row(
                                     children: [
                                       Text('Mỹ Duyên', style:TextStyle(
                                           fontSize: 16.sp,
                                           fontWeight: FontWeight.w400) ,),
                                       SizedBox(
                                         width: 30.w,
                                       ),
                                       Text('0773555859')
                                     ],
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(
                               width: 20.w,
                             ),
                             Container(
                               padding: EdgeInsets.only(right: 5.w),
                               child:  Text(
                                 'Sửa',
                                 style: TextStyle(color: Colors.cyan,),
                               ),
                             )
                           ],
                         ),
                       )),
                   Container(
                       height: 80.h,
                       margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                       padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                       // color: Color(0xFFF1F1F1),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(2)),
                         border: Border.all(width: 0,color: Colors.black12),
                         color: Colors.white,
                       ),
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             IconButton(
                                 icon: Icon(
                                   Icons.location_on,
                                   color: Colors.black,
                                   size: 32.sp,
                                 ),
                                 onPressed: () {
                                   print("Map");
                                 }),
                             Container(
                               child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Tòa cẩm tú',
                                     style: TextStyle(
                                         fontSize: 16.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     'Đường số 9, linh trung thủ đức, Hồ chí minh',
                                     style: TextStyle(
                                         fontSize: 15.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Row(
                                     children: [
                                       Text('Mỹ Duyên', style:TextStyle(
                                           fontSize: 16.sp,
                                           fontWeight: FontWeight.w400) ,),
                                       SizedBox(
                                         width: 30.w,
                                       ),
                                       Text('0773555859')
                                     ],
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(
                               width: 20.w,
                             ),
                             Container(
                               padding: EdgeInsets.only(right: 5.w),
                               child:  Text(
                                 'Sửa',
                                 style: TextStyle(color: Colors.cyan,),
                               ),
                             )
                           ],
                         ),
                       )),
                   Container(
                       height: 80.h,
                       margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                       padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                       // color: Color(0xFFF1F1F1),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(2)),
                         border: Border.all(width: 0,color: Colors.black12),
                         color: Colors.white,
                       ),
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             IconButton(
                                 icon: Icon(
                                   Icons.location_on,
                                   color: Colors.black,
                                   size: 32.sp,
                                 ),
                                 onPressed: () {
                                   print("Map");
                                 }),
                             Container(
                               child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Tòa cẩm tú',
                                     style: TextStyle(
                                         fontSize: 16.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     'Đường số 9, linh trung thủ đức, Hồ chí minh',
                                     style: TextStyle(
                                         fontSize: 15.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Row(
                                     children: [
                                       Text('Mỹ Duyên', style:TextStyle(
                                           fontSize: 16.sp,
                                           fontWeight: FontWeight.w400) ,),
                                       SizedBox(
                                         width: 30.w,
                                       ),
                                       Text('0773555859')
                                     ],
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(
                               width: 20.w,
                             ),
                             Container(
                               padding: EdgeInsets.only(right: 5.w),
                               child:  Text(
                                 'Sửa',
                                 style: TextStyle(color: Colors.cyan,),
                               ),
                             )
                           ],
                         ),
                       )),
                   Container(
                       height: 80.h,
                       margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                       padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                       // color: Color(0xFFF1F1F1),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(2)),
                         border: Border.all(width: 0,color: Colors.black12),
                         color: Colors.white,
                       ),
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             IconButton(
                                 icon: Icon(
                                   Icons.location_on,
                                   color: Colors.black,
                                   size: 32.sp,
                                 ),
                                 onPressed: () {
                                   print("Map");
                                 }),
                             Container(
                               child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Tòa cẩm tú',
                                     style: TextStyle(
                                         fontSize: 16.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     'Đường số 9, linh trung thủ đức, Hồ chí minh',
                                     style: TextStyle(
                                         fontSize: 15.sp,
                                         fontWeight: FontWeight.w400),
                                   ),
                                   Row(
                                     children: [
                                       Text('Mỹ Duyên', style:TextStyle(
                                           fontSize: 16.sp,
                                           fontWeight: FontWeight.w400) ,),
                                       SizedBox(
                                         width: 30.w,
                                       ),
                                       Text('0773555859')
                                     ],
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(
                               width: 20.w,
                             ),
                             Container(
                               padding: EdgeInsets.only(right: 5.w),
                               child:  Text(
                                 'Sửa',
                                 style: TextStyle(color: Colors.cyan,),
                               ),
                             )
                           ],
                         ),
                       )),
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
               ),)
              ],
            ),
          ),
        ],
      )
    );
  }
}
