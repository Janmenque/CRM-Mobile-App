import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/myaccount_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/emergency_tab/emergency_tab.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/financial_tab/financial_tab.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/office_tab.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/personal_tab/personal_tab.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/appreciate_tab/appreciate_tab.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/bottom_nav_controller.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/buttom_navigation_bar.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatelessWidget {
  final int? tabIndex;

  const MyAccount({Key? key, this.tabIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BottomNavController>();

    return ChangeNotifierProvider(
        create: (context) => MyAccountProvider(),
        child: Consumer<MyAccountProvider>(
          builder: (context, provider, _) {
            return WillPopScope(
              onWillPop: () => NavUtil.replaceScreen(
                  context, ButtomNavigationBar(
                    bottomNavigationIndex: controller.currentScreenIndex,
                  )),
              child: DefaultTabController(
                  length: 5,
                  initialIndex: tabIndex ?? 0,
                  child: Scaffold(
                    backgroundColor: AppColors.backgroundColor,
                      appBar: AppBar(
                        elevation: 1,
                        backgroundColor: AppColors.white,
                        bottom: TabBar(
                          isScrollable: true,
                          labelColor: AppColors.primaryColor,
                          indicatorColor: AppColors.primaryColor,
                          labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                          labelPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                          tabs: [
                            Text(
                              tr("official"),
                              style: const TextStyle(fontFamily: 'cairo'),
                            ),
                            Text(
                              tr("personal"),
                              style: const TextStyle(fontFamily: 'cairo'),
                            ),
                            Text(
                              tr("financial"),
                              style: const TextStyle(fontFamily: 'cairo'),
                            ),
                            Text(
                              tr("emergency"),
                              style: const TextStyle(fontFamily: 'cairo'),
                            ),
                            Text(
                              tr("appreciate"),
                              style: const TextStyle(fontFamily: 'cairo'),
                            ),
                          ],
                        ),
                        automaticallyImplyLeading: true,
                        centerTitle: false,
                        title: Text(
                          tr("my_account"),
                          style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp),
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          OfficeTab(officialInfo: context.watch<MyAccountProvider>().officialInfo,),
                          PersonalTab(personalInfo: context.watch<MyAccountProvider>().personalInfo,),
                          FinancialTab(financialInfo: context.watch<MyAccountProvider>().financialInfo,),
                          EmergencyTeb(emergencyInfo: context.watch<MyAccountProvider>().emergencyInfo,),
                          const AppreciateTab(),
                        ],
                      ))),
            );
          },
        ));
  }
}
