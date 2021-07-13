import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/toppings.dart';
import 'package:image_picker/image_picker.dart';

class Review extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Review();
  }
}

class _Review extends State<Review> {
  static String txtTopping = '';
  static double? _rating;

  String listTopping() {
    // for (Topping topping in food_1.listTopping!)
    //   txtTopping += topping.name! + ',';
    return txtTopping;
  }

  File? _image;

  final picker = ImagePicker();

  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đánh giá'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(width: 2, color: kPrimaryColorBackground))),
            child: Row(
              children: [
                Image.network(
                  '',
                  // food_1.image!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.only(left: 12.w),
                  width: 310.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '',
                        // food_1.name!,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Topping: ' + listTopping(),
                        maxLines: 3,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 414.w,
            height: 80.h,
            child: RatingBar.builder(
              wrapAlignment: WrapAlignment.center,
              initialRating: 5,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 38.sp,
              itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(_rating);
                print(rating);
                _rating = rating;
                print(_rating);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 190.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black38)),
                  child: OutlinedButton(
                    onPressed: _openImagePicker,
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.cover)
                        : Column(
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 28.sp,
                              ),
                              Text(
                                'Thêm hình ảnh',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                  ),
                ),
                Container(
                  width: 190.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black38)),
                  child: Column(
                    children: [
                      Icon(
                        Icons.video_call_outlined,
                        size: 28.sp,
                      ),
                      Text(
                        'Thêm video',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 414.w,
            height: 170.h,
            margin: EdgeInsets.all(12.w),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black26)),
            child: TextField(
              maxLines: null,
              maxLength: null,
              decoration: InputDecoration.collapsed(
                  hintText: 'Hãy chia sẻ cảm nhận của bạn về món ăn'),
            ),
          ),
        ],
      ),
    );
    // );
  }
}
