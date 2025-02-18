
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/widgets/project_status_progress_widget.dart';
import 'package:hrm_app/screens/custom_widgets/horizontal_divider.dart';

class ProjectStatus extends StatelessWidget {
  const ProjectStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Project Status",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.5),
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/task/filters.png",
                    height: 24.h,
                    width: 24.w,
                  ),
                  SizedBox(
                    width: 24.w,
                  ),
                  Container(
                    height: height * 0.04,
                    color: const Color(0xffE9E9EA),
                    width: 2,
                  ),
                  SizedBox(
                    width: 24.w,
                  ),
                  Image.asset("assets/task/plus.png", height: 24.w, width: 24.w)
                ],
              )
            ],
          ),

          SizedBox(
            height: 13.58.h,
          ),

         const HorizontalDivider(
            dividerColor:  Color(0xffE9E9EA),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Project",
                style: TextStyle(
                    color: Color(0xff828282), fontSize: 14, height: 1.5),
              ),
              Row(
                children: [
                  const Text(
                    "Status",
                    style: TextStyle(
                        color: Color(0xff828282), fontSize: 14, height: 1.5),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  const Text(
                    "Owner",
                    style: TextStyle(
                        color: Color(0xff828282), fontSize: 14, height: 1.5),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
         const HorizontalDivider(
            dividerColor:  Color(0xffE9E9EA),
          ),

          SizedBox(
            height: 19.h,
          ),

         const  ProjectStatusProgressWidget(
            checkbox: "assets/projects/check_box.png",
            title: "Marketing Page Redesign",
            persentageActiveColor:  Color(0xff219653),
            activeContainerWidth: 129,
            persentageDisebleColor:  Color(0xff219653),
            deActivetContainerWidth: 0,
            persentage: "100 %",
            dateTitle: "On Track",
            date: "14 Mar",
            ownerImage: "assets/projects/owner1.png",
            trackDotColor:  Color(0xff219653),
            trackTitleColor:  Color(0xff219653),
          ),
          SizedBox(
            height: 20.h,
          ),

         const ProjectStatusProgressWidget(
            checkbox: "assets/projects/empty_checkbox.png",
            title: "Pitch Deck",
            persentageActiveColor:  Color(0xffF2994A),
            activeContainerWidth: 90,
            persentageDisebleColor:  Color(0xffFCEBDB),
            deActivetContainerWidth: 39,
            persentage: "70 %",
            dateTitle: "At Risk",
            date: "19 Mar",
            trackDotColor:  Color(0xffF2994A),
            trackTitleColor:  Color(0xffF2994A),
            ownerImage: "assets/projects/owner2.png",
          ),
          SizedBox(
            height: 20.h,
          ),

          const ProjectStatusProgressWidget(
            checkbox: "assets/projects/empty_checkbox.png",
            title: "New IOS Development",
            persentageActiveColor:  Color(0xffEB5757),
            activeContainerWidth: 110,
            persentageDisebleColor:  Color(0xffFBDDDD),
            deActivetContainerWidth: 19,
            persentage: "85 %",
            dateTitle: "Off Track",
            date: "25 Mar",
            trackDotColor:  Color(0xffEB5757),
            trackTitleColor:  Color(0xffEB5757),
            ownerImage: "assets/projects/owner3.png",
          ),
        ],
      ),
    );
  }
}
