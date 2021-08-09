import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis.dart';
import 'package:http/http.dart' as http;

String keyGoogleMap = 'AIzaSyBFRhlxolpDTOnWONYQ-VdctzKzlsN5hAY';

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
