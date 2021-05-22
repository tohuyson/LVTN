import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/categories.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> categorys = [
      Category(name: 'Cơm', url: 'healthy-eating.png'),
      Category(name: 'Phở', url: 'ramen.png'),
      Category(name: 'Hủ Tiếu', url: 'noodles.png'),
      Category(name: 'Bánh Canh', url: 'noodles_c.png'),
      Category(name: 'Nước Mía', url: 'ice-coffee.png'),
      Category(name: 'Coffee', url: 'hot-cup.png'),
      Category(name: 'Trà Sữa', url: 'iced-tea.png'),
      Category(name: 'Voucher', url: 'voucher.png'),
      Category(name: 'Quán yêu thích', url: 'like.png'),
      Category(name: 'Giao Hàng', url: 'delivery-man.png'),
    ];

    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 175.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
            ),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: categorys.length,
            itemBuilder: (_, index) {
              return Container(
                height: 80.h,
                width: 80.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Color(0xFFEFEFEF)),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      height: 40.h,
                      width: 40.w,
                      child: Image.asset(
                          'assets/icons_menu/' + categorys[index].url),
                    ),
                    Container(
                      height:30.h,
                      child: Center(
                          child: AutoSizeText(
                        categorys[index].name,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      )),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
