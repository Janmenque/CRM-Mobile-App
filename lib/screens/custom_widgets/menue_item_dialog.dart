import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/custom_widgets/horizontal_divider.dart';

class MenuItemDialog extends StatelessWidget {
  const MenuItemDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 25),
        child: Container(
          //height: 119.0.h,
          width: 224.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/task/see_setails.png",
                      height: 18,
                      width: 14,
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    Text(
                      "See details",
                      style: TextStyle(
                          color: const Color(0xff6B6B6B),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              SizedBox(
                  width: 18.w,
                ),
                const HorizontalDivider(dividerColor:  Color(0xffECECEC)),
               SizedBox(
                  width: 18.w,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/task/blue_check.png",
                      height: 18,
                      width: 14,
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    Text(
                      "Mark as a complete",
                      style: TextStyle(
                          color: const Color(0xff6B6B6B),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  width: 18.w,
                ),
                const HorizontalDivider(dividerColor:  Color(0xffECECEC)),
                SizedBox(
                  width: 18.w,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/task/delete.png",
                      height: 18,
                      width: 14,
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    Text(
                      "Delete Project",
                      style: TextStyle(
                          color: const Color(0xff6B6B6B),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  width: 18.w,
                ),
               const HorizontalDivider(dividerColor:  Color(0xffECECEC)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
