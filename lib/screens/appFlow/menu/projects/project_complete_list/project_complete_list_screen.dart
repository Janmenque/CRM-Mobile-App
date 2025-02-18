import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../custom_widgets/custom_tap_bar_button.dart';
import '../../../../custom_widgets/custom_title_appbar.dart';
import '../../../../custom_widgets/progress_indecator_with_persentage.dart';
import '../../../../custom_widgets/project_status_card.dart';

class ProjectCompleteListScreen extends StatelessWidget {
  const ProjectCompleteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "Project Completed",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 17.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 11.5.h, horizontal: 13.5.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/Group.png",
                            height: 17.24.h,
                            width: 17.24.w,
                          ),
                          SizedBox(
                            width: 9.24.w,
                          ),
                          Text(
                            "Search",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff4A43EC),
                              fontSize: 14.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  InkWell(
                    onTap: () {
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 13.h, horizontal: 15.w),
                      decoration: BoxDecoration(
                          color: const Color(0xff5B58FF),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Icon(
                        Icons.add,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //title and see all
                    Text(
                      "Completed",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),

                    Row(
                      children: [
                        Image.asset(
                          "assets/projects/projects_filter.png",
                          height: 18.h,
                          width: 18.w,
                        ),
                        SizedBox(
                          width: 08.w,
                        ),
                        Text(
                          "Filter",
                          style: TextStyle(
                              color: const Color(0xff4A43EC),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),

              ///cmpleted
              ProjectStatusCard(
                tapBarButton1: const CustomTapBarButton(
                  buttonColor: Color(0xffF4EFFD),
                  textColor: Color(0xff5B58FF),
                  buttonText: "UI/UX Design",
                  borderColor: Color(0xffF4EFFD),
                ),
                tapBarButton2: const CustomTapBarButton(
                  buttonColor: Color(0xffEFF9EC),
                  textColor: Color(0xff5DC33F),
                  buttonText: "Mudium",
                  borderColor: Color(0xffEFF9EC),
                ),
                rightIconArrowColor: const Color(0xff5DC33F),
                projectName: "Create a\nLanding Page",
                usersImage: const [],
                userCount: 0,
                progressBar: ProgressIndeccatorWithPersentage(
                  persentageActiveColor: const Color(0xff5DC33F),
                  persentageDisebleColor: const Color(0xff5DC33F),
                  activeContainerWidth: 10.w,
                  deActivetContainerWidth: 237.w,
                  persentage: "100%",
                ),
              ),
              SizedBox(
                height: 2.h,
              ),

              ///cmpleted
              ProjectStatusCard(
                tapBarButton1: const CustomTapBarButton(
                  buttonColor: Color(0xffF4EFFD),
                  textColor: Color(0xff5B58FF),
                  buttonText: "UI/UX Design",
                  borderColor: Color(0xffF4EFFD),
                ),
                tapBarButton2: const CustomTapBarButton(
                  buttonColor: Color(0xffEFF9EC),
                  textColor: Color(0xff5DC33F),
                  buttonText: "Mudium",
                  borderColor: Color(0xffEFF9EC),
                ),
                rightIconArrowColor: const Color(0xff5DC33F),
                projectName: "Create a\nLanding Page",
                usersImage: const [],
                userCount: 0,
                progressBar: ProgressIndeccatorWithPersentage(
                  persentageActiveColor: const Color(0xff5DC33F),
                  persentageDisebleColor: const Color(0xff5DC33F),
                  activeContainerWidth: 10.w,
                  deActivetContainerWidth: 237.w,
                  persentage: "100%",
                ),
              ),
              SizedBox(
                height: 2.h,
              ),

              ///cmpleted
              ProjectStatusCard(
                tapBarButton1: const CustomTapBarButton(
                  buttonColor: Color(0xffF4EFFD),
                  textColor: Color(0xff5B58FF),
                  buttonText: "UI/UX Design",
                  borderColor: Color(0xffF4EFFD),
                ),
                tapBarButton2: const CustomTapBarButton(
                  buttonColor: Color(0xffEFF9EC),
                  textColor: Color(0xff5DC33F),
                  buttonText: "Mudium",
                  borderColor: Color(0xffEFF9EC),
                ),
                rightIconArrowColor: const Color(0xff5DC33F),
                projectName: "Create a\nLanding Page",
                usersImage: const [],
                userCount: 0,
                progressBar: ProgressIndeccatorWithPersentage(
                  persentageActiveColor: const Color(0xff5DC33F),
                  persentageDisebleColor: const Color(0xff5DC33F),
                  activeContainerWidth: 10.w,
                  deActivetContainerWidth: 237.w,
                  persentage: "100%",
                ),
              ),
              SizedBox(
                height: 2.h,
              ),

              ///cmpleted
              ProjectStatusCard(
                usersImage: const [],
                userCount: 0,
                tapBarButton1: const CustomTapBarButton(
                  buttonColor: Color(0xffF4EFFD),
                  textColor: Color(0xff5B58FF),
                  buttonText: "UI/UX Design",
                  borderColor: Color(0xffF4EFFD),
                ),
                tapBarButton2: const CustomTapBarButton(
                  buttonColor: Color(0xffEFF9EC),
                  textColor: Color(0xff5DC33F),
                  buttonText: "Mudium",
                  borderColor: Color(0xffEFF9EC),
                ),
                rightIconArrowColor: const Color(0xff5DC33F),
                projectName: "Create a\nLanding Page",
                progressBar: ProgressIndeccatorWithPersentage(
                  persentageActiveColor: const Color(0xff5DC33F),
                  persentageDisebleColor: const Color(0xff5DC33F),
                  activeContainerWidth: 10.w,
                  deActivetContainerWidth: 237.w,
                  persentage: "100%",
                ),
              ),
              SizedBox(
                height: 2.h,
              ),

              ///cmpleted
              ProjectStatusCard(
                usersImage: const [],
                userCount: 0,
                tapBarButton1: const CustomTapBarButton(
                  buttonColor: Color(0xffF4EFFD),
                  textColor: Color(0xff5B58FF),
                  buttonText: "UI/UX Design",
                  borderColor: Color(0xffF4EFFD),
                ),
                tapBarButton2: const CustomTapBarButton(
                  buttonColor: Color(0xffEFF9EC),
                  textColor: Color(0xff5DC33F),
                  buttonText: "Mudium",
                  borderColor: Color(0xffEFF9EC),
                ),
                rightIconArrowColor: const Color(0xff5DC33F),
                projectName: "Create a\nLanding Page",
                progressBar: ProgressIndeccatorWithPersentage(
                  persentageActiveColor: const Color(0xff5DC33F),
                  persentageDisebleColor: const Color(0xff5DC33F),
                  activeContainerWidth: 10.w,
                  deActivetContainerWidth: 237.w,
                  persentage: "100%",
                ),
              ),
              SizedBox(
                height: 2.h,
              ),

              ///cmpleted
              ProjectStatusCard(
                usersImage: const [],
                userCount: 0,
                tapBarButton1: const CustomTapBarButton(
                  buttonColor: Color(0xffF4EFFD),
                  textColor: Color(0xff5B58FF),
                  buttonText: "UI/UX Design",
                  borderColor: Color(0xffF4EFFD),
                ),
                tapBarButton2: const CustomTapBarButton(
                  buttonColor: Color(0xffEFF9EC),
                  textColor: Color(0xff5DC33F),
                  buttonText: "Mudium",
                  borderColor: Color(0xffEFF9EC),
                ),
                rightIconArrowColor: const Color(0xff5DC33F),
                projectName: "Create a\nLanding Page",
                progressBar: ProgressIndeccatorWithPersentage(
                  persentageActiveColor: const Color(0xff5DC33F),
                  persentageDisebleColor: const Color(0xff5DC33F),
                  activeContainerWidth: 10.w,
                  deActivetContainerWidth: 237.w,
                  persentage: "100%",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
