
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectStatusProgressWidget extends StatelessWidget {
 const ProjectStatusProgressWidget(
      {Key? key,
      required this.checkbox,
      required this.title,
      required this.persentageActiveColor,
      required this.persentageDisebleColor,
      required this.dateTitle,
      required this.date,
      required this.trackDotColor,
      required this.trackTitleColor,
      required this.activeContainerWidth,
      required this.deActivetContainerWidth,
      required this.ownerImage,
      required this.persentage})
      : super(key: key);

  final String? checkbox, title, date, dateTitle, persentage, ownerImage;
  final Color? persentageActiveColor,
      persentageDisebleColor,
      trackTitleColor,
      trackDotColor;

  final double? activeContainerWidth, deActivetContainerWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              checkbox!,
              // "assets/projects/check_box.png",
              height: 16.h,
              width: 16.w,
            ),
            SizedBox(
              width: 11.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  //"Marketing Page Redesign",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            bottomLeft: Radius.circular(10.r),
                          ),
                          color: persentageActiveColor!
                          ),
                      height: 4.h,
                      width: activeContainerWidth!,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                          ),
                          color: persentageDisebleColor!
                          ),
                      height: 4.h,
                      width: deActivetContainerWidth!,
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Text(
                      persentage!,
                      style: TextStyle(
                          color: const Color(0xff828282), fontSize: 11.sp),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 6.h,
                      width: 6.w,
                      decoration: BoxDecoration(
                          color: trackDotColor!, shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      "On Track",
                      style: TextStyle(color: trackTitleColor, fontSize: 12.sp),
                    ),
                  ],
                ),
                Text(
                  "14 Mar",
                  style: TextStyle(
                      color: const Color(0xff828282), fontSize: 12.sp),
                ),
              ],
            ),
            SizedBox(
              width: 20.w,
            ),
            Image.asset(
              ownerImage!,
              height: 32.h,
              width: 32.w,
            )
          ],
        )
      ],
    );
  }
}
