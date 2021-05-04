import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/forgot_password.dart';
import 'package:fooddelivery/screens/signup.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height / 5.5,
                maxHeight: MediaQuery.of(context).size.height / 3.2,
              ),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Image(
                        image: ResizeImage(
                      AssetImage('assets/images/logo-food-delivery.png'),
                      width: 100,
                      height: 100,
                    )),
                  ),
                )),
            Container(
              constraints: BoxConstraints(
                // minHeight: MediaQuery.of(context).size.height / 3,
                maxHeight: MediaQuery.of(context).size.height / 2.4,
              ),
              // height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 60),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: 'Email/Số điện thoại',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    // margin: EdgeInsets.only(top: 32),
                    margin: EdgeInsets.only(top: 15),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.vpn_key,
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: 'Mật khẩu',
                      ),
                    ),
                  ),
                  InkWell(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 32),
                          child: Text(
                            'Quên mật khẩu ?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(ForgotPassword());
                      }),
                  Spacer(),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          'Đăng nhập'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Bạn chưa có tài khoản ? "),
                        Text(
                          "Đăng ký",
                          style: TextStyle(color: Color(0xff47A4FF)),
                        ),
                      ],
                    ),
                    onTap: () {
                      Get.to(SignUp());
                    },
                  ),
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: 20,
                maxHeight: 30,
              ),
              child:   SizedBox(
                height: 30,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Color(0xffDFDFDF),
                  height: 2,
                  width: 100,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Hoặc',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  color: Color(0xffDFDFDF),
                  height: 2,
                )
              ],
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height / 7,
                maxHeight: MediaQuery.of(context).size.height / 6,
              ),
              height: MediaQuery.of(context).size.height / 6.5,
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.only(top: 60),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 20,
                        maxHeight: 50,
                      ),
                      width: 50,
                      // height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff1346b4),
                            Color(0xff0cb2eb),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffff4645),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
