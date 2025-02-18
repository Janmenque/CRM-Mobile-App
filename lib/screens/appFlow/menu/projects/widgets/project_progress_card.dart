import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/custom_widgets/custom_tap_bar_button.dart';
import 'package:hrm_app/screens/custom_widgets/rounded_stack_image.dart';

class ProjectsProgressCard extends StatelessWidget {
  const ProjectsProgressCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 23.h),
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/projects/projectRectengle.png"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomTapBarButton(
                      buttonColor: const Color(0xffFFDF38),
                      verticalPadding: 2.h,
                      textColor: Colors.black,
                      buttonText: "UI/UX  Design",
                      borderColor: const Color(0xffFFDF38),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomTapBarButton(
                      buttonColor: const Color(0xffFF6060),
                      verticalPadding: 2.h,
                      textColor: Colors.white,
                      buttonText: "High",
                      borderColor: const Color(0xffFF6060),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/projects/menu.png",
                  height: 27.h,
                  width: 14.w,
                )
              ],
            ),
            SizedBox(
              height: 14.h,
            ),
            Text(
              "Konsep design homepage",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 14.h,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut.",
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            SizedBox(
              height: 21.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Project Prgress",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    )),
                Text("32%",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ))
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      bottomLeft: Radius.circular(10.r),
                    ),
                    color: Colors.white,
                  ),
                  height: 6.h,
                  width: 100.w,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                    color: const Color(0xffA4A3FF),
                  ),
                  height: 6.h,
                  width: 210.w,
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const RoundedStackImages(
                      image1: "assets/projects/roundProfile.png",
                      image2: "assets/projects/roundImage02.png",
                      image3: "assets/projects/roundProfile.png",
                      image4: "assets/projects/add_rounded.png",
                    ),
                    Text(
                      "  + 15 people",
                      style: TextStyle(
                          color: const Color(0xffA2A1FF), fontSize: 14.sp),
                    )
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/projects/Calendar.png",
                      height: 20.h,
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "Due NOV 24",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
