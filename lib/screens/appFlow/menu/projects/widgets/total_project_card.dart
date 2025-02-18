
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class TotalProjectCard extends StatelessWidget {
  const TotalProjectCard(
      {Key? key, required this.image, this.count, this.label})
      : super(key: key);
  final String? label, count, image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
            imageUrl: image!,
            height: 164.h,
            width: 159.w),
        Positioned(
          top: 42.h,
          bottom: 0.h,
          left: 00.w,
          right: 14.w,
          child: Text(
            count ?? "",
            //"86",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: 64.h,
          bottom: 0.h,
          left: 0,
          right: 20.w,
          child: Text(
            label ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
          ).tr(),
        )
      ],
    );
  }
}
