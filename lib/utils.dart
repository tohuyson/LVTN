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
    "Merchant Demo thanh toán cho đơn hàng  #$apptransid";

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

Future<bool> notification(String uid, String title, String body) async {
  try {
    http.Response response = await http.post(
      Uri.parse(Apis.postNotificationUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uid': uid,
        'title': title,
        'body': body,
      }),
    );
    print(response.statusCode);
  } on TimeoutException catch (e) {
    showError(e.toString());
  } on SocketException catch (e) {
    showError(e.toString());
  }
  return false;
}

Future<bool> saveNotification(String title, String body) async {
  var token = await getToken();
  try {
    http.Response response = await http.post(
      Uri.parse(Apis.saveNotificationUrl),
      headers: <String, String>{
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'body': body,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {}
  } on TimeoutException catch (e) {
    showError(e.toString());
  } on SocketException catch (e) {
    showError(e.toString());
  }
  return false;
}
