import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class HomePageDashboardCard extends StatelessWidget {
  const HomePageDashboardCard(
      {super.key,
        this.cardColor,
        this.cardLogo,
        this.title,
        this.count,
        this.onTap,
        this.textColor});

  final Color? cardColor, textColor;
  final String? title, count, cardLogo;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150.h,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
            color: cardColor ?? AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              cardLogo ?? "assets/images/placeholder_image.png",
             // height: 28.h,
              width: 28.w,
            ),
            SizedBox(
              height: 16.h,
            ),
          Expanded(child:   Text(
            count ?? "",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: textColor ?? AppColors.black),
          ).tr(),),
            Expanded(
              child: Center(
                child: Text(
                  title ?? "",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: textColor ?? AppColors.black),
                ).tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
