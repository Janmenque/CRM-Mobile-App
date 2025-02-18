import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/utils/res.dart';

class CrmAccountDashboard extends StatelessWidget {
  const CrmAccountDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
         appBar: 
       PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "Accounts", 
        ),
      ),
      body: SingleChildScrollView(child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: const Column(
          children:  [
            AccountDashboardCard(
              image: "assets/accpunts/earning.png",
              titile: "Earnings",

            ),
               AccountDashboardCard(
              image: "assets/accpunts/manage_expense.png",
              titile: "Manage expense",

            ),
               AccountDashboardCard(
              image: "assets/accpunts/earning.png",
              titile: "Manage claims",

            ),
               AccountDashboardCard(
              image: "assets/accpunts/purchase_list.png",
              titile: "Purchase List",

            ),
          ],
        ),
      )),
    );
  }
}

class AccountDashboardCard extends StatelessWidget {
  const AccountDashboardCard({
    Key? key, required this.image, this.titile
  }) : super(key: key);


  final String? image, titile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 8.0.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 26.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: AppColors.white, border: Border.all(color: const Color(0xffE8E8E8),),),
        child: Row(
          children: [
            Image.asset(
              image!, 
               height: 35.h, width: 31.w,),
            SizedBox(
              width: 14.w,
            ),
            Text(titile ?? "", style: TextStyle(color: AppColors.black, fontSize: 18.sp, fontWeight: FontWeight.bold, ),)
          ],
        ),
      ),
    );
  }
}