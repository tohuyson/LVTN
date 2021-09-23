import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooddelivery/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';
import 'package:crypto/crypto.dart';

import 'networking.dart';

String keyGoogleMap = 'AIzaSyBFRhlxolpDTOnWONYQ-VdctzKzlsN5hAY';

/// Function Format DateTime to String with layout string
String formatNumber(double value) {
  final f = new NumberFormat("#,###", "vi_VN");
  return f.format(value);
}

/// Function Format DateTime to String with layout string
String formatDateTime(DateTime dateTime, String layout) {
  return DateFormat(layout).format(dateTime).toString();
}

int transIdDefault = 1;

String getAppTransId() {
  if (transIdDefault >= 100000) {
    transIdDefault = 1;
  }

  transIdDefault += 1;
  var timeString = formatDateTime(DateTime.now(), "yyMMdd_hhmmss");
  return sprintf("%s%06d", [timeString, transIdDefault]);
}

String getBankCode() => "zalopayapp";

String getDescription(String apptransid) =>
    "Thanh toán cho đơn hàng  #$apptransid";

String getMacCreateOrder(String data) {
  var hmac = new Hmac(sha256, utf8.encode(ZaloPayConfig.key1));
  return hmac.convert(utf8.encode(data)).toString();
}

saveToken(String token) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString('token', token);
}

showError(String s) {
  EasyLoading.dismiss();
  EasyLoading.showError(s, duration: Duration(milliseconds: 750));
}

showToast(String s) {
  EasyLoading.dismiss();
  EasyLoading.showToast(s);
}

Future<String?> getToken() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('token');
}

Future<void> setValue(String key, String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(key, value);
}

Future<String?> getValue(String key) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(key);
}

Future<int?> uploadImage(File file, String filename) async {
  String? token = await getToken();
  print(token);
  try {
    var request =
        await http.MultipartRequest('POST', Uri.parse(Apis.uploadImage));
    request.files.add(http.MultipartFile.fromBytes(
        'image', file.readAsBytesSync(),
        filename: filename.split('/').last));
    var response = await request.send();
    print(response.statusCode);
    return response.statusCode;
  } on TimeoutException catch (e) {
    showError(e.toString());
  } on SocketException catch (e) {
    showError(e.toString());
  }
}

Future<int?> uploadAvatar(File file, String filename) async {
  String? token = await getToken();
  print(token);
  try {
    var request =
        await http.MultipartRequest('POST', Uri.parse(Apis.uploadAvatar));
    request.files.add(http.MultipartFile.fromBytes(
        'image', file.readAsBytesSync(),
        filename: filename.split('/').last));
    var response = await request.send();
    print(response.statusCode);
    return response.statusCode;
  } on TimeoutException catch (e) {
    showError(e.toString());
  } on SocketException catch (e) {
    showError(e.toString());
  }
}

Future<bool> notification(String uid, String title, String body,int notification_type_id) async {
  try {
    http.Response response = await http.post(
      Uri.parse(Apis.postNotificationUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'uid': uid,
        'title': title,
        'body': body,
        'notification_type_id': notification_type_id,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
  } on TimeoutException catch (e) {
    showError(e.toString());
  } on SocketException catch (e) {
    showError(e.toString());
  }
  return false;
}

Future<void> saveNotification(
    String title, String body, String user_id, int notification_type_id) async {
  var token = await getToken();
  try {
    print(title);
    print(body);
    http.Response response = await http.post(
      Uri.parse(Apis.saveNotificationUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': user_id,
        'title': title,
        'body': body,
        'notification_type_id': notification_type_id,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {}
  } on TimeoutException catch (e) {
    showError(e.toString());
  } on SocketException catch (e) {
    showError(e.toString());
  }
}

Future<double> distanceRestaurant(
    double startLat, double startLng, double endLat, double endLng) async {
  Distance distance = new Distance(
    startLat: startLat,
    startLng: startLng,
    endLat: endLat,
    endLng: endLng,
  );
  var data = await distance.postData();
  // print(data);

  if (data != 404) {
    var arrarDistance = data['distances'][0];
    print(arrarDistance);
    if(arrarDistance[1]!= null)
    return arrarDistance[1];
    else return 0.0;
  }
  return 0.0;
}
