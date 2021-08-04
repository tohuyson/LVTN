import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  late Users? users;

  // var user = Users(avatar: 'assets/images/user.png').obs;
  late Rx<Users> user;

  @override
  void onInit() {
    // getUser();
    fetchUsers();
    // users = (getUser().obs) as Users?;
    super.onInit();
  }

  @override
  void onReady() {
    // getRestaurants();
    super.onReady();
  }

  Future<void> fetchUsers() async {
    var u = await getUser();
    if (u != null) {
      user = u.obs;
    }
    // update();
  }

  late File? image;
  late String? imagePath;
  final _picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath = pickedFile.path;
      print(imagePath);
      update();
    } else {
      print('No image selected.');
    }
  }

  Future<Users?> getUser() async {
    Users? users;
    String token = (await getToken())!;
    try {
      print(Apis.getUsersUrl);
      http.Response response = await http.get(
        Uri.parse(Apis.getUsersUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        print(parsedJson['users']);
        users = UsersJson.fromJson(parsedJson).users!;
        print(users);
        return users;
      }
      if (response.statusCode == 401) {
        showToast("Loading faild");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
      print(e.toString());
    }
    return null;
  }

  Future<void> _removeToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('token');
  }

  Future<void> logout() async {
    String token = (await getToken())!;
    print(token);
    try {
      print(Apis.getLogoutUrl);
      http.Response response = await http.post(
        Uri.parse(Apis.getLogoutUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      ).timeout(Duration(seconds: 10));
      print(response.statusCode);
      if (response.statusCode == 200) {
        _removeToken();
        Get.offAll(SignIn());
      }
      if (response.statusCode == 401) {
        showToast("Logout failed.");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
      print(e.toString());
    }
  }
}
