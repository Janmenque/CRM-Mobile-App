import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class HistoryCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? amount;
  final Color? color;
  const HistoryCard({Key? key, this.color, this.title, this.image, this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          child: Row(
            children: [
              Image.asset(
                image!,
                height: 50.h,
              ),
              SizedBox(
                width: 8.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    "Today",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.lightGrey,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                amount!,
                style: TextStyle(
                    fontSize: 18.sp, color: color, fontWeight: FontWeight.w600),
              ),
            ],
          )),
    );
  }
}
