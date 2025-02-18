
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class HomeProjectCard extends StatelessWidget {
  const HomeProjectCard(
      {Key? key,
        this.description,
        this.quantity,
        this.seeMore,
        this.title,
        this.cardImage,
        this.descriptionNextLine,
        this.quantityColor})
      : super(key: key);

  final String? title,
      quantity,
      description,
      seeMore,
      cardImage,
      descriptionNextLine;
  final Color? quantityColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          cardImage!,
          height: 250.h,
        ),
        Positioned(
          top: 12.h,
          bottom: 0.h,
          left: 20.w,
          right: 0.w,
          child: Text(
            title ?? "",
            style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        Positioned(
          top: 135.h,
          bottom: 0.h,
          left: 16.w,
          right: 16.w,
          child: Text(
            description ?? "",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 12.sp,
            ),
          ),
        ),
        Positioned(
          top: 48.h,
          bottom: 0.h,
          left: 70.w,
          right: 0.w,
          child: Text(
            quantity ?? "",
            style: TextStyle(
                color: quantityColor ?? AppColors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: 194.h,
          bottom: 0.h,
          left: 48.w,
          right: 0.w,
          child: Text(
            seeMore ?? "",
            style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}