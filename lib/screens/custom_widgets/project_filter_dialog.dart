import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_complete_list/project_complete_list_screen.dart';
import 'package:hrm_app/screens/custom_widgets/horizontal_divider.dart';
import '../appFlow/menu/projects/project_in_progress_list/project_in_progress_list.dart';
import '../appFlow/menu/projects/project_upcomming_list/project_upcomming_list.dart';

class ProjectFilterDialog extends StatelessWidget {
  const ProjectFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProjectUpCommingListScreen()));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 15.h,
                        width: 15.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffFFAF00)),
                      ),
                      SizedBox(
                        width: 13.w,
                      ),
                      Text(
                        "UpComming",
                        style: TextStyle(
                            color: const Color(0xff6B6B6B),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
              const  HorizontalDivider(dividerColor:  Color(0xffECECEC)),
                SizedBox(
                  height: 12.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProjectInProgressListScreen()));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 15.h,
                        width: 15.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff00606F)),
                      ),
                      SizedBox(
                        width: 13.w,
                      ),
                      Text(
                        "In Progress",
                        style: TextStyle(
                            color: const Color(0xff6B6B6B),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                 SizedBox(
                  height: 12.h,
                ),
              const  HorizontalDivider(dividerColor:  Color(0xffECECEC)),
                SizedBox(
                  height: 12.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProjectCompleteListScreen()));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 15.h,
                        width: 15.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff38CE3C)),
                      ),
                      SizedBox(
                        width: 13.w,
                      ),
                      Text(
                        "Completed    ",
                        style: TextStyle(
                            color: const Color(0xff6B6B6B),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
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
