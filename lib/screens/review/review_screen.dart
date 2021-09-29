import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/controllers/profile_controllor.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils.dart';

class ReviewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReviewScreen();
  }
}

String? img;

class _ReviewScreen extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Đánh giá'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFFFFFFF),
          height: 834.h,
          width: 414.w,
          alignment: Alignment.centerRight,
          child: Column(
            children: [
              Container(
                width: 414.w,
                margin: EdgeInsets.all(10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black12),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: o.value.foodOrder![0].food!.restaurant == null
                              ? Container(
                                  width: 80.w,
                                  height: 80.h,
                                  padding: EdgeInsets.only(
                                      right: 12.w,
                                      bottom: 12.h,
                                      left: 12.w,
                                      top: 12.h),
                                  child: Image.asset(
                                    'assets/images/user.png',
                                    fit: BoxFit.cover,
                                    color: Colors.black26,
                                  ),
                                )
                              : Container(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    child: Image.network(
                                      Apis.baseURL +
                                          o.value.foodOrder![0].food!
                                              .restaurant!.image!,
                                      width: 80.w,
                                      height: 80.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                        Container(
                          width: 282.w,
                          padding: EdgeInsets.only(left: 12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.food_bank,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    o.value.foodOrder![0].food!.restaurant!
                                        .name!,
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Text('Địa chỉ : ' +
                                  o.value.foodOrder![0].food!.restaurant!
                                      .address
                                      .toString(), overflow: TextOverflow.ellipsis,),
                              Text('Giá : ' + o.value.price.toString() + ' đ'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 30.w,
                      child: IconButton(
                        icon: Icon(Icons.navigate_next),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: Text('Thông tin đơn hàng'),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        width: 384.w,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: o.value.foodOrder!.length,
                                            itemBuilder: (context, ind) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 24.w,
                                                    child: Text(o
                                                            .value
                                                            .foodOrder![ind]
                                                            .quantity
                                                            .toString() +
                                                        ' x'),
                                                  ),
                                                  Container(
                                                    width: 180.w,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          o.value.foodOrder![ind]
                                                              .food!.name!,
                                                          style: TextStyle(
                                                              fontSize: 18.sp),
                                                        ),
                                                        Container(
                                                          width: 180.w,
                                                          child: ListView.builder(
                                                              shrinkWrap: true,
                                                              itemCount: o
                                                                  .value
                                                                  .foodOrder![ind]
                                                                  .toppings!
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                return Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "+ " +
                                                                          '${o.value.foodOrder![ind].toppings![i].name!}: ' +
                                                                          ' ${o.value.foodOrder![ind].toppings![i].price!}',
                                                                      style: TextStyle(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          color: Colors
                                                                              .grey),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 1.h,
                                                                    )
                                                                  ],
                                                                );
                                                              }),
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 70.w,
                                                    child: Text(
                                                      o.value.foodOrder![ind]
                                                          .price
                                                          .toString(),
                                                      textAlign: TextAlign.right,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: const Text('Ok'),
                                      ),
                                    ]);
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5, color: Colors.grey.shade300)))),
              SizedBox(
                height: 10.w,
              ),
              ListImages(),
              SizedBox(
                height: 10.w,
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: 5,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  ignoreGestures: false,
                  onRatingUpdate: (double value) {
                    rate = value;
                  },
                ),
              ),
              SizedBox(
                height: 10.w,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.h, right: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.grey.shade300)
                  ),
                padding: EdgeInsets.all(12.w),
                child: TextField(
                  controller: review,
                  maxLines: 15,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Đánh giá món ăn của quán.',
                  ),
                ),
              ),
              SizedBox(
                height: 20.w,
              ),
              InkWell(
                onTap: () async {
                  await addReview();
                  // showToast('Đánh giá thành công');
                },
                child: Container(
                  height: 45.h,
                  width: 360.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(width: 1, color: Colors.blue)),
                  child: Center(
                    child: Text(
                      'Đánh giá',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late Rx<Order> o;
  late TextEditingController review;
  final ProfileController controller = Get.put(ProfileController());
  late double rate = 5;

  @override
  void initState() {
    o = new Rx<Order>(new Order());
    var order = Get.arguments['order'];
    o.value = order;

    review = TextEditingController();
  }

  Future<void> addReview() async {
    String? token = await getToken();
    String nameImage = '';
    int? restaurantId = o.value.foodOrder![0].food!.restaurant!.id;
    print('res ssss $restaurantId');
    print('rate $rate');

    int? code = await uploadImage(controller.image!, controller.imagePath!);
    if (code == 200) {
      nameImage = controller.imagePath!.split('/').last;
    }
    if (review.text.isNotEmpty && controller.image!.path.isNotEmpty) {
      try {
        http.Response response = await http.post(
          Uri.parse(Apis.addReviewUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': "Bearer $token",
          },
          body: jsonEncode(<String, dynamic>{
            'review': review.text,
            'rate': rate.toString(),
            'image': nameImage,
            'restaurantId': restaurantId.toString(),
          }),
        );

        print(response.statusCode);
        if (response.statusCode == 200) {
          // EasyLoading.dismiss();
          var parsedJson = jsonDecode(response.body);
          print(parsedJson['success']);
          Get.back();
          // Food food = Food.fromJson(parsedJson['food']);
          // // Get.back(result: food);
          // Get.off(ListProduct(),
          //     arguments: {'food': food, 'category_id': category_id});
          // showToast("Tạo thành công");
        }
        if (response.statusCode == 404) {
          // EasyLoading.dismiss();
          // var parsedJson = jsonDecode(response.body);
          // print(parsedJson['error']);
        }
      } on TimeoutException catch (e) {
        showError(e.toString());
      } on SocketException catch (e) {
        showError(e.toString());
      }
    } else {
      showToast('Vui lòng điền đầy đủ các trường');
    }
  }
}

class ListImages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListImages();
  }
}

class _ListImages extends State<ListImages> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          SizedBox(
            width: 120.w,
            height: 120.h,
            child: RaisedButton(
              onPressed: () {
                controller.getImage();
                // img = controller.imagePath;
              },
              color: Colors.white,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0)),
              child: GetBuilder<ProfileController>(
                builder: (_) {
                  return controller.image!.path == ''
                      ? Icon(
                          Icons.add_a_photo,
                          color: Colors.grey,
                          size: 25.0.sp,
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 120.h),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              child: Image.file(
                                controller.image!,
                                // width: 90.w,
                                // height: 90.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  File i = new File('');

  @override
  void initState() {
    super.initState();
  }
}
