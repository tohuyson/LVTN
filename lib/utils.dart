import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
