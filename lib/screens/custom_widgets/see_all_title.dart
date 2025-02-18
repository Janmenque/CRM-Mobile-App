import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeeAllTitle extends StatelessWidget {
  const SeeAllTitle({Key? key, this.titile, this.ontap}) : super(key: key);

  final String? titile;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titile ?? "",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp),
          ).tr(),
          InkWell(
            onTap: ontap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.w),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff5B58FF)),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                "see_all",
                style:
                TextStyle(color: const Color(0xff5B58FF), fontSize: 14.sp),
              ).tr(),
            ),
          )
        ],
      ),
    );
  }
}