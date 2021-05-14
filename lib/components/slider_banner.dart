import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2.h),
      child: ImageSlideshow(
        width: double.infinity,
        height: 120.h,
        initialPage: 0,
        indicatorColor: Theme.of(context).primaryColor,
        indicatorBackgroundColor: Colors.white,
        children: [
          Image.asset(
            'assets/images/banner-1.png',
            fit: BoxFit.fill,
          ),
          Image.asset(
            'assets/images/banner-2.png',
            fit: BoxFit.fill,
          ),
        ],
        onPageChanged: (value) {
          // print('Page changed: $value');
        },
        autoPlayInterval: 3000,
      ),
    );
  }
}
