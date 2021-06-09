import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/function_profile.dart';

class Users {
  final int id;
  final String name;
  final String phone;
  final String token;
  final List<FunctionProfile> listFunction;
  final List<Address> listAddress;

  Users(
      {this.id,
      this.name,
      this.phone,
      this.token,
      this.listFunction,
      this.listAddress});
}
