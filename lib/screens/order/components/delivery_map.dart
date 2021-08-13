import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryMap extends StatefulWidget {
  final double? height;

  DeliveryMap({this.height});

  @override
  State<StatefulWidget> createState() {
    return _DeliveryMap(height: height);
  }
}

class _DeliveryMap extends State<DeliveryMap> {
  final double? height;

  _DeliveryMap({this.height});

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  void dispose() {
    locateUser();
    super.dispose();
  }

  static LatLng currentPostion = LatLng(10.873286, 106.7914436);
  late Position currentLocation;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height!.h,
      width: double.infinity,
      color: Colors.white,
      // child: GoogleMap(
      //   mapType: MapType.normal,
      //   myLocationEnabled: true,
      //   initialCameraPosition: CameraPosition(
      //     target: currentPostion,
      //     zoom: 10,
      //   ),
      //   onMapCreated: (GoogleMapController controller) {},
      // ),
    );
  }
}
