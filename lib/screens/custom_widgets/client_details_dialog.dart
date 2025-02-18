import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientDetailsDialog extends StatelessWidget {
  const ClientDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Image.asset(
                  "assets/projects/projectAssign1.png",
                  height: 52.h,
                  width: 52.w,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Jane Cooper",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Ui/Ux Designer",
                  style: TextStyle(
                      color: const Color(0xff8A8A8A),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      size: 13.sp,
                      color: const Color(0xff5B58FF),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "(219) 555-0114",
                      style: TextStyle(
                          color: const Color(0xff8A8A8A),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 13.sp,
                      color: const Color(0xff5B58FF),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "jane@onfo.com",
                      style: TextStyle(
                          color: const Color(0xff8A8A8A),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
