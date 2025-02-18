import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/task/widgets/task_assign_card_with_date.dart';
import '../../../../custom_widgets/custom_title_appbar.dart';

class TaskInReviewSCreen extends StatelessWidget {
  const TaskInReviewSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: PreferredSize( 
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "Task In Review",
        ),
      ),
      body: Padding(
         padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task in Review",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),  
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
             TaskAssignCardWithDate(
              onTap: (){
                if (kDebugMode) {
                  print("check");
                }
              },
              taskName: "Create a Landing Page for E-\ncommerce Platform",
              image1: "assets/projects/roundProfile.png",
              image2: "assets/projects/roundImage02.png",
              image3: "assets/projects/roundProfile.png",
              image4: "assets/task/task_in_review_add_updsate.png",
              tapButtonColor: const Color(0xff00606F),
              taskStartDate: "12 Aug - ",
              taskEndDate: "20 Aug",
            ),
               SizedBox(
              height: 2.h,
            ),
             TaskAssignCardWithDate(
                  onTap: (){
                if (kDebugMode) {
                  print("check");
                }
              },
              taskName: "HRM Dashboard UI design and\n Frontend design",
              image1: "assets/projects/roundProfile.png",
              image2: "assets/projects/roundImage02.png",
              image3: "assets/projects/roundProfile.png",
              image4: "assets/task/task_in_review_add_updsate.png",
              tapButtonColor: const Color(0xff00606F),
              taskStartDate: "12 Aug - ",
              taskEndDate: "20 Aug",
            ),
               SizedBox(
              height: 2.h,
            ),
             TaskAssignCardWithDate(
                onTap: (){
                if (kDebugMode) {
                  print("check");
                }
              },
              taskName: "Online Learning Managment\n  App design",
              image1: "assets/projects/roundProfile.png",
              image2: "assets/projects/roundImage02.png",
              image3: "assets/projects/roundProfile.png",
              image4: "assets/task/task_in_review_add_updsate.png",
              tapButtonColor: const Color(0xff00606F),
              taskStartDate: "12 Aug - ",
              taskEndDate: "20 Aug",
            ),
               SizedBox(
              height: 2.h,
            ),
             TaskAssignCardWithDate(
                onTap: (){
                if (kDebugMode) {
                  print("check");
                }
              },
              taskName: "Create a Landing Page for E-\ncommerce Platform",
              image1: "assets/projects/roundProfile.png",
              image2: "assets/projects/roundImage02.png",
              image3: "assets/projects/roundProfile.png",
              image4: "assets/task/task_in_review_add_updsate.png",
              tapButtonColor: const Color(0xff00606F),
              taskStartDate: "12 Aug - ",
              taskEndDate: "20 Aug",
            ),
               SizedBox(
              height: 2.h,
            ),
             TaskAssignCardWithDate(
                onTap: (){
                if (kDebugMode) {
                  print("check");
                }
              },
              taskName: "Create a Landing Page for E-\ncommerce Platform",
              image1: "assets/projects/roundProfile.png",
              image2: "assets/projects/roundImage02.png",
              image3: "assets/projects/roundProfile.png",
              image4: "assets/task/task_in_review_add_updsate.png",
              tapButtonColor: const Color(0xff00606F),
              taskStartDate: "12 Aug - ",
              taskEndDate: "20 Aug",
            ),
               SizedBox(
              height: 2.h,
            ),
             TaskAssignCardWithDate(
                onTap: (){
                if (kDebugMode) {
                  print("check");
                }
              },
              taskName: "Create a Landing Page for E-\ncommerce Platform",
              image1: "assets/projects/roundProfile.png",
              image2: "assets/projects/roundImage02.png",
              image3: "assets/projects/roundProfile.png",
              image4: "assets/task/task_in_review_add_updsate.png",
              tapButtonColor: const Color(0xff00606F),
              taskStartDate: "12 Aug - ",
              taskEndDate: "20 Aug",
            ),
               SizedBox(
              height: 2.h,
            ),
             TaskAssignCardWithDate(
                onTap: (){
                if (kDebugMode) {
                  print("check");
                }
              },
              taskName: "Create a Landing Page for E-\ncommerce Platform",
              image1: "assets/projects/roundProfile.png",
              image2: "assets/projects/roundImage02.png",
              image3: "assets/projects/roundProfile.png",
              image4: "assets/task/task_in_review_add_updsate.png",
              tapButtonColor: const Color(0xff00606F),
              taskStartDate: "12 Aug - ",
              taskEndDate: "20 Aug",
            ),
               SizedBox(
              height: 2.h,
            ),
             TaskAssignCardWithDate(
                onTap: (){
                if (kDebugMode) {
                  print("check");
                }
              },
              taskName: "Create a Landing Page for E-\ncommerce Platform",
              image1: "assets/projects/roundProfile.png",
              image2: "assets/projects/roundImage02.png",
              image3: "assets/projects/roundProfile.png",
              image4: "assets/task/task_in_review_add_updsate.png",
              tapButtonColor: const Color(0xff00606F),
              taskStartDate: "12 Aug - ",
              taskEndDate: "20 Aug",
            ),
               SizedBox(
              height: 2.h,
            ),
           
            ],
          ),
        ),
      ),
    );
  }
}