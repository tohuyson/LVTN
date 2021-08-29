import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/networking.dart';
import 'package:fooddelivery/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryMap extends StatefulWidget {
  final double height;
  final Restaurant restaurant;
  final Order order;

  DeliveryMap({required this.height, required this.restaurant, required this.order});

  @override
  State<StatefulWidget> createState() {
    return _DeliveryMap(height: height, restaurant: restaurant, order: order);
  }
}

class _DeliveryMap extends State<DeliveryMap> {
  final double height;
  final Restaurant restaurant;
  final Order order;

  _DeliveryMap({required this.height, required this.restaurant,required this.order});

  //draw line

  late GoogleMapController mapController;

  final List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline
  final Set<Marker> markers = {}; // For holding instance of Marker
  late var data;

  // Dummy Start and Destination Points
  late double startLat;

  late double startLng;

  late double endLat;
  late double endLng;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setMarkers();
  }

  setMarkers() {
    markers.add(
      Marker(
        markerId: MarkerId("Home"),
        position: LatLng(startLat, startLng),
        infoWindow: InfoWindow(
          title: "Home",
          snippet: "Home Sweet Home",
        ),
      ),
    );

    markers.add(Marker(
      markerId: MarkerId("Destination"),
      position: LatLng(endLat, endLng),
      infoWindow: InfoWindow(
        title: "Masjid",
        snippet: "5 star ratted place",
      ),
    ));
  }

  void getJsonData() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    NetworkHelper network = NetworkHelper(
      startLat: startLat,
      startLng: startLng,
      endLat: endLat,
      endLng: endLng,
    );

    try {
      // getData() returns a json Decoded data
      data = await network.getData();

      // We can reach to our desired JSON data manually as following
      LineString ls =
          LineString(data['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }

      if (polyPoints.length == ls.lineString.length) {
        setPolyLines();
      }
    } catch (e) {
      print(e);
    }
  }

  setPolyLines() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Colors.lightBlue,
      points: polyPoints,
    );
    polyLines.add(polyline);
  }

  @override
  void initState() {
    startLat= double.parse(order.latitude!);
    startLng = double.parse(order.longitude!);
    endLat = double.parse(restaurant.lattitude!);
    endLng = double.parse(restaurant.longtitude!);

    currentPostion =
        LatLng(double.parse(restaurant.lattitude!),double.parse(restaurant.longtitude!));

    // _getUserLocation();
    getJsonData();
    super.initState();
  }

  @override
  void dispose() {
    // locateUser();
    super.dispose();
  }

  LatLng currentPostion = new LatLng(10.873286, 106.7914436);
  late Position currentLocation;

  // Future<Position> locateUser() async {
  //   return Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  // _getUserLocation() async {
  //   currentLocation = await locateUser();
  //   setState(() {
  //     startLat = currentLocation.latitude;
  //     startLng = currentLocation.longitude;
  //   });
  //   print('center $currentPostion');
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: double.infinity,
      color: Colors.white,
      child: GoogleMap(
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: currentPostion,
          zoom: 16,
        ),
        markers: markers,
        polylines: polyLines,
        mapType: MapType.normal,
        gestureRecognizers: Set()
          ..add(
              Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
          ..add(Factory<ScaleGestureRecognizer>(
                  () => ScaleGestureRecognizer()))
          ..add(
              Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
          ..add(Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer())),
      ),
    );
      // FutureBuilder(
      //   future: _getUserLocation(),
      //   builder: (context, snapshot) {
      //     return Container(
      //       height: height!.h,
      //       width: double.infinity,
      //       color: Colors.white,
      //       child: GoogleMap(
      //         myLocationEnabled: true,
      //         onMapCreated: _onMapCreated,
      //         initialCameraPosition: CameraPosition(
      //           target: currentPostion,
      //           zoom: 16,
      //         ),
      //         markers: markers,
      //         polylines: polyLines,
      //         mapType: MapType.normal,
      //         gestureRecognizers: Set()
      //           ..add(
      //               Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
      //           ..add(Factory<ScaleGestureRecognizer>(
      //               () => ScaleGestureRecognizer()))
      //           ..add(
      //               Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
      //           ..add(Factory<VerticalDragGestureRecognizer>(
      //               () => VerticalDragGestureRecognizer())),
      //       ),
      //     );
      //   });
  }
}

class LineString {
  LineString(this.lineString);

  List<dynamic> lineString;
}
