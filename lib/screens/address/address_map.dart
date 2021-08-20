import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class AddressMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddressMap();
  }
}

class _AddressMap extends State<AddressMap> {
  late Address address;
  late final LatLng center;
  late GoogleMapController controller;

  late LatLng newLocation;

  List<Marker> allMarkers = [];

  @override
  void initState() {
    address = Get.arguments['address'];
    center = new LatLng(double.parse(address.lattitude.toString()),
        double.parse(address.longtitude.toString()));

    allMarkers.add(
      Marker(
          markerId: MarkerId('myMarker'),
          draggable: true,
          onTap: () {
            print('Marker Tapped');
          },
          position: center,
          onDragEnd: ((newPosition) {
            print(newPosition.latitude);
            print(newPosition.longitude);
            setState(() {
              newLocation =
                  new LatLng(newPosition.latitude, newPosition.longitude);
            });
          })),
    );
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sửa vị trí'),
        centerTitle: true,
        elevation: 0,
        leading: BackButton(),
      ),
      body: Container(
        height: 834.h,
        width: 414.w,
        child: Column(
          children: [
            Container(
              height: 730.h,
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 18.0,
                ),
                onMapCreated: _onMapCreated,
                markers: Set.from(allMarkers),
                // onTap: handleTap,
              ),
            ),
            InkWell(
              onTap: () async {
               await updateLocationAddress();
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
                height: 45.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    'Đồng ý'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateLocationAddress() async {
    print(newLocation);
    String token = (await getToken())!;
    print(address.id);
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.updateLocationUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'address_id': address.id,
          'longtitude': newLocation.longitude,
          'lattitude': newLocation.latitude,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        Address a = AddressJson.fromJson(parsedJson).address!;
        Get.back(result: a);
      }
      if (response.statusCode == 500) {
        showToast("Hệ thống bị lỗi, Vui lòng thử lại sau!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
      print(e.toString());
    }
  }
}
