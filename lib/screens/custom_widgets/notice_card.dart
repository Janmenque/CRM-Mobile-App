
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard(
      {Key? key, this.image, this.name, this.notice, this.time, this.title})
      : super(key: key);

  final String? image, title, time, notice, name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                image!,
                height: 48.h,
                width: 48.w,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "You have ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff80868D),
                              fontSize: 14.sp),
                        ),
                        Text(
                          notice ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                              fontSize: 14.sp),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "has been created by ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff80868D),
                              fontSize: 14.sp),
                        ),
                        Text(
                          name ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff5B58FF),
                              fontSize: 14.sp),
                        )
                      ],
                    )
                  ],
                ),
                Text(
                  time ?? "",
                  style: TextStyle(
                    color: const Color(0xff80868D),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}