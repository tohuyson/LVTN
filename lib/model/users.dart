import 'package:fooddelivery/model/function_profile.dart';

class Users {
  final int id;
  final String name;
  final String token;
  final List<FunctionProfile> list_function;

  Users({this.id, this.name, this.token,this.list_function});
}
