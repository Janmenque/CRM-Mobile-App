import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {Key? key,
      required this.amount,
      required this.title,
      required this.backgroundImage,
      required this.amountRight,
      required this.amountTop,
      required this.titleTop,
      required this.titleRight})
      : super(key: key);

  final String amount, title, backgroundImage;
 final  double amountRight, amountTop, titleRight, titleTop;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: backgroundImage,
          height: 155.h,
          width: 185.w,
        ),
        Positioned(
          top: amountTop,
          bottom: 0.h,
          left: 00.w,
          right: amountRight,
          child: Text(
            amount,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          ).tr(),
        ),
        Positioned(
          top: titleTop,
          bottom: 0.h,
          left: 0.w,
          right: titleRight,
          child: Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 25.h),
            child: AutoSizeText(
              title.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
        )
      ],
    );
  }
}




class DashboardCardCashImage extends StatelessWidget {
  const DashboardCardCashImage(
      {Key? key,
      required this.amount,
      required this.title,
      required this.backgroundInage,
      required this.amountright,
      required this.amounttop,
      required this.titileTop,
      required this.titleRight})
      : super(key: key);

  final String amount, title, backgroundInage;
 final double amountright, amounttop, titleRight, titileTop;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
         backgroundInage,
          height: 125.h,
          width: 155.w,
        ),
        Positioned(
          top: amounttop,
          bottom: 0.h,
          left: 00.w,
          right: amountright,
          child: Text(
            amount,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          ).tr(),
        ),
        Positioned(
          top: titileTop,
          bottom: 0.h,
          left: 0.w,
          right: titleRight,
          child: Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 25.h),
            child: AutoSizeText(
              title.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
