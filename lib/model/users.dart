import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/function_profile.dart';

class Users {
  int? id;
  String? username;
  String? phone;
  String? email;
  List<FunctionProfile>? listFunction;
  List<Address>? listAddress;

  Users(
      {this.id,
      this.username,
      this.phone,
      this.email,
      this.listFunction,
      this.listAddress});

  Users.empty() {
    this.id = -1;
    this.username = 'Empty User';
    this.email = '';
    this.phone = '';
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserName': username,
      'Phone': phone,
      'Email': email,
    };
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
    );
  }
}
