import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class CompanyDashboardCard extends StatelessWidget {
  const CompanyDashboardCard(
      {super.key,
        this.cardColor,
        this.cardLogo,
        this.title,
        this.count,
        this.textColor});

  final Color? cardColor, textColor;
  final String? title, count, cardLogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: cardColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            title ?? "",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: textColor ?? Colors.black),
          ),
       const SizedBox(
          height: 10,
        ),
          Text(
            count ?? "",
            style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
                color: textColor ?? Colors.black),
          )
        ],
      ),
    );
  }
}
