import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressMapNow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddressMapNow();
  }
}

class _AddressMapNow extends State<AddressMapNow> {
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
              ),
            ),
            GestureDetector(
              onTap: () async {
                await loadData();
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

  Future<void> loadData() async {
    List<Placemark> placemark = await getPosition();
    String street = await getStreet(placemark);
    String locality = await getLocality(placemark);
    String a = await getAddress(placemark);

    String address = locality + ', ' + a;

    await setValue('street', street);
    await setValue('address', address);
    await setValue('latitude', newLocation.latitude.toString());
    await setValue('longitude', newLocation.longitude.toString());

    Get.off(BottomNavigation(selectedIndex: 1));
  }

  Future<List<Placemark>> getPosition() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        newLocation.latitude, newLocation.longitude);
    return placemarks;
  }

  Future<String> getStreet(List<Placemark> placemarks) async {
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].street!.isNotEmpty) {
        return placemarks[i].street!;
      }
    }
    return '';
  }

  Future<String> getLocality(List<Placemark> placemarks) async {
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].locality!.isNotEmpty) {
        return placemarks[i].locality!;
      }
    }
    return '';
  }

  Future<String> getAddress(List<Placemark> placemarks) async {
    // List<String> address = [];
    String address = '';

    for (int i = 0; i < placemarks.length; i++) {
      print(placemarks[i]);
      if (placemarks[i].administrativeArea!.isNotEmpty &&
          placemarks[i].subAdministrativeArea!.isNotEmpty &&
          placemarks[i].country!.isNotEmpty) {
        address = placemarks[i].subAdministrativeArea! +
            ', ' +
            placemarks[i].administrativeArea! +
            ', ' +
            placemarks[i].country!;
      }
    }
    return address;
  }
}
