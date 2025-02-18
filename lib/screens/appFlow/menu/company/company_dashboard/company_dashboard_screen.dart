import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/company/add_company/add_company_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/company/company_list/company_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/company/content/company_list_card.dart';
import 'package:hrm_app/screens/appFlow/menu/company/content/conpany_total_value.dart';
import 'package:hrm_app/screens/custom_widgets/see_all_title.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';

class CompanyDashboardScreen extends StatelessWidget {
  const CompanyDashboardScreen({super.key});

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      value: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0XFF004D96),
                            Color(0XFF0082FF),
                          ])),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5.w,),
                Text(title, style: TextStyle(color: Colors.grey[600]),)]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Company Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        actions:  [
          Visibility(
            child: PopupMenuButton(
              onSelected: (value) {
                menuItemRoute(value, context);
              },
              itemBuilder: (BuildContext context) => [
                _buildPopupMenuItem('Add Company'),
              ],
            ),
          )
        ],
      ),
       body: SingleChildScrollView(
           child: Padding(
             padding: EdgeInsets.symmetric(horizontal: 20.w),
             child: Column(
              children: [
              SizedBox(height: 10.h,),
                const CompanyTotalValue(),
                SizedBox(
                    height: 10.h,
                  ),
                SeeAllTitle(
                  titile: "Company List",
                  ontap: () {
                  Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) =>
                       const CompanyListScreen()),
                );
               },
              ),
           SizedBox(
             height: 10.h,
           ),
           CompanyListCard(
               ontap: () { },
               name: "Onest Tech",
               email: "Onesttech@gmail.com",
               companyLogo: "assets/stocks/upwork.png",
               number: "01254687889",
             ),
           CompanyListCard(
             ontap: () { },
             name: "Sookh",
             email: "Onesttech@gmail.com",
             companyLogo: "assets/stocks/upwork.png",
             number: "01254687889",
           ),
           CompanyListCard(
             ontap: () { },
             name: "Onest Tech",
             email: "Onesttech@gmail.com",
             companyLogo: "assets/stocks/upwork.png",
             number: "01254687889",
           ),
           CompanyListCard(
             ontap: () { },
             name: "Onest Tech",
             email: "Onesttech@gmail.com",
             companyLogo: "assets/stocks/upwork.png",
             number: "01254687889",
           ),
         ],),
           ),),
    );

  }

  menuItemRoute(value, context) {
    switch (value) {
      case "Add Company":
        return NavUtil.navigateScreen(context, const AddCompanyScreen());

      default:
        if (kDebugMode) {
          print('value missing');
        }
    }
  }


}
