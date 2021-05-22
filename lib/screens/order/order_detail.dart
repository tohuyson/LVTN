import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderDetail extends StatefulWidget {
  final Order order;

  OrderDetail({this.order});

  @override
  State<StatefulWidget> createState() => _OrderDetail(order: order);
}

class _OrderDetail extends State<OrderDetail> {
  final Order order;

  _OrderDetail({this.order});

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  static LatLng currentPostion = LatLng(10.873286, 106.7914436);
  Position currentLocation;

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  _getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      currentPostion =
          LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print('center $currentPostion');
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Đơn hàng',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: 834.h,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 250.h,
              width: double.infinity,
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: currentPostion,
                  zoom: 10,
                ),
                onMapCreated: (GoogleMapController controller) {
                  // _controller.complete(controller);
                },
              ),
            ),
            Container(
              height: 550.h,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      top: 8.h,
                    ),
                    padding:
                        EdgeInsets.only(bottom: 8.h, left: 5.w, right: 5.w),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colors.black12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Text(
                          order.category,
                          style: TextStyle(fontSize: 16.sp),
                        )),
                        Container(
                            child: Text(
                          'Đang đến trong 20 phút',
                          style: TextStyle(fontSize: 16.sp),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.h, left: 10.w, right: 10.w),
                    padding:
                        EdgeInsets.only(bottom: 8.h, left: 5.w, right: 5.w),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colors.black12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 290.w,
                          height: 55.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                order.namefood.name,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              AutoSizeText(
                                'Tổng: ' +
                                    order.price.toString() +
                                    ' - ' +
                                    order.method,
                                style: TextStyle(fontSize: 14),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 38.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                'Chi tiết',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stepper(
                    steps: [
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Đặt đơn"),
                            Container(
                                padding: EdgeInsets.only(right: 30.w),
                                child: Text("10:30")),
                          ],
                        ),
                        content: SizedBox(
                          width: 0,
                          height: 0,
                        ),
                        isActive: true,
                      ),
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Xác nhận đơn hàng"),
                            Container(
                                padding: EdgeInsets.only(right: 30.w),
                                child: Text("10:30")),
                          ],
                        ),
                        content: SizedBox(
                          width: 0,
                          height: 0,
                        ),
                      ),
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Giao hàng"),
                            Container(
                                padding: EdgeInsets.only(right: 30.w),
                                child: Text("10:30")),
                          ],
                        ),
                        content: SizedBox(
                          width: 0,
                          height: 0,
                        ),
                      ),
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Đã giao hàng"),
                            Container(
                                padding: EdgeInsets.only(right: 30.w),
                                child: Text("10:30")),
                          ],
                        ),
                        content: SizedBox(
                          width: 0,
                          height: 0,
                        ),
                      ),
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Hoàn thành"),
                            Container(
                                padding: EdgeInsets.only(right: 30.w),
                                child: Text("10:30")),
                          ],
                        ),
                        content: SizedBox(
                          width: 0,
                          height: 0,
                        ),
                      ),
                    ],
                    currentStep: _index,
                    onStepTapped: (index) {
                      setState(() {
                        _index = index;
                      });
                    },
                    controlsBuilder: (BuildContext context,
                            {VoidCallback onStepContinue,
                            VoidCallback onStepCancel}) =>
                        Container(),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 15.h, bottom: 10.h, left: 8.w, right: 8.w),
                      height: 45.h,
                      width: 360.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border:
                              Border.all(width: 1, color: Color(0xFFF60404))),
                      child: Center(
                        child: Text(
                          'Hủy Đơn Hàng',
                          style: TextStyle(
                              color: Color(0xFFF60404),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
