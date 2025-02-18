import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectStatusCard extends StatelessWidget {
  const ProjectStatusCard(
      {Key? key,
      this.tapBarButton1,
      this.tapBarButton2,
      this.rightIconArrowColor,
      this.projectName,
      this.startData,
      this.endDate,
      this.progressBar,
      this.ontap,
      this.usersImage,
      this.userCount,
      this.actualCount})
      : super(key: key);

  final Widget? tapBarButton1, tapBarButton2, progressBar;
  final Color? rightIconArrowColor;
  final String? projectName, startData, endDate;
  final Function()? ontap;
  final List<Widget>? usersImage;
  final int? userCount;
  final int? actualCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 19.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      tapBarButton1 ?? const SizedBox(),
                      SizedBox(
                        width: 10.w,
                      ),
                      tapBarButton2 ?? const SizedBox(),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: rightIconArrowColor,
                    size: 13.sp,
                  )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    projectName ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ).tr(),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.0 * usersImage!.length,
                        height: 40.0.h,
                        child: Stack(children: usersImage!),
                      ),
                      (actualCount ?? 0) > 3
                          ? Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 9.h, horizontal: 7.w),
                        decoration: BoxDecoration(
                            color: rightIconArrowColor,
                            shape: BoxShape.circle),
                        child: Text(
                          "${userCount.toString()}+",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ).tr(),
                      )

                          :  const SizedBox()
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 26.h,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/projects/calender_black.png",
                    height: 14.h,
                    width: 14.w,
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    startData ?? "",
                    style: TextStyle(
                        color: const Color(0xff7B7B7B),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ).tr(),
                  SizedBox(
                    width: 14.w,
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    endDate ?? "",
                    style: TextStyle(
                        color: const Color(0xff7B7B7B),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ).tr(),
                ],
              ),
              SizedBox(
                height: 21.h,
              ),
              progressBar ?? const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
