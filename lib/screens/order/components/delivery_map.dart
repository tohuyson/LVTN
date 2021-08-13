import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/utils.dart';
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

// Starting point latitude
double _originLatitude = 10.8693218;
// Starting point longitude
double _originLongitude = 106.7869136;

double _destLatitude = 10.8724929;
// Destination Longitude
double _destLongitude = 106.7895604;
// Markers to show points on the map
Map<MarkerId, Marker> markers = {};

PolylinePoints polylinePoints = PolylinePoints();
Map<PolylineId, Polyline> polylines = {};

class _DeliveryMap extends State<DeliveryMap> {
  final double? height;

  _DeliveryMap({this.height});

  Completer<GoogleMapController> _controller = Completer();

  // Configure map position and zoom
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 16.25,
  );

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      keyGoogleMap,
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }

  @override
  void initState() {
    _getUserLocation();
    _addMarker(
      LatLng(_originLatitude, _originLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(_destLatitude, _destLongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    _getPolyline();

    super.initState();
  }

  @override
  void dispose() {
    locateUser();
    super.dispose();
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
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        // myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        polylines: Set<Polyline>.of(polylines.values),
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
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
