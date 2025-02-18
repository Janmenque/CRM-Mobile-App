import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/add_departments/add_departments.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/add_designation/add_designation.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/add_employee/add_employee_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/departments/departments_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/designation/designation_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/employee_details/emlployee_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/employee_list/employee_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/provider/employee_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/widget/employee_list_update_card.dart';
import 'package:hrm_app/screens/custom_widgets/dashboard.dart';
import 'package:hrm_app/screens/custom_widgets/dashboard_shimer_effect.dart';
import 'package:hrm_app/screens/custom_widgets/see_all_title.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/connectivity/no_internet_screen.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  const EmployeeDashboardScreen({super.key});

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      value: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
              spacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
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
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[600]),
                ).tr()
              ]),
          const Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => CrmEmployeeProvider(context),
        child: Consumer<CrmEmployeeProvider>(builder: (context, provider, _) {
          final statistics = provider.crmEmployeeeDashboardResponse?.data;
          return Scaffold(
              backgroundColor: const Color(0xffF5F6FA),
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  "Employees",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ).tr(),
                actions: [
                  Visibility(
                    visible: provider.isAdmin ?? false,
                    child: PopupMenuButton(
                      onSelected: (value) {
                        menuItemRoute(value, context);
                      },
                      itemBuilder: (BuildContext context) => [
                        _buildPopupMenuItem('add_employee'),
                        _buildPopupMenuItem('add_designation'),
                        _buildPopupMenuItem('add_department'),
                        _buildPopupMenuItem('employees'),
                        _buildPopupMenuItem('department'),
                        _buildPopupMenuItem('designations'),
                      ],
                    ),
                  )
                ],
              ),
              body: statistics != null
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 24.h, horizontal: 17.w),
                        child: Column(
                          children: [
                            GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: statistics.staticstics?.length ?? 0,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 140,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0),
                                itemBuilder: (BuildContext context, int index) {
                                  final data = statistics.staticstics?[index];
                                  return DashboardCard(
                                    backgroundImage: data!.image!,
                                    title: data.text ?? "",
                                    amount: data.count ?? "",
                                    amountTop: 35.0.h,
                                    amountRight: 15.0.w,
                                    titleTop: 58.0.h,
                                    titleRight: 20.0.w,
                                  );
                                }),

                            ///list title
                            SeeAllTitle(
                              titile: "Employees",
                              ontap: () {
                                if (kDebugMode) {
                                  print("tap");
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EmployeeListScreen()),
                                );
                              },
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider
                                        .crmEmployeeeDashboardResponse
                                        ?.data
                                        ?.employees
                                        ?.length ??
                                    0,
                                itemBuilder: (BuildContext context, int index) {
                                  final data = provider
                                      .crmEmployeeeDashboardResponse
                                      ?.data
                                      ?.employees?[index];
                                  return EmployeeListUpdateCard(
                                    name: data?.name,
                                    designation: data?.designation,
                                    address: data?.phone,
                                    image: data?.avatar,
                                    onTap: () => NavUtil.navigateScreen(
                                      context,
                                      EmployeeDetailsScreen(
                                        employeeId: data!.id!,
                                      ),
                                    ),
                                  );
                                }),

                            SizedBox(
                              height: 22.h,
                            ),
                          ],
                        ),
                      ))
                  : const DashboardShimerEffect());
        }),
      ),
    );
  }

  menuItemRoute(value, context) {
    switch (value) {
      case "add_employee":
        return NavUtil.navigateScreen(context, const AddEmployeeScreen());
      case "add_designation":
        return NavUtil.navigateScreen(context, const AddDesignation());
      case "employees":
        return NavUtil.navigateScreen(context, const EmployeeListScreen());
      case "department":
        return NavUtil.navigateScreen(context, const Departments());
      case "add_department":
        return NavUtil.navigateScreen(context, const AddDepartments());
      case "designations":
        return NavUtil.navigateScreen(context, const DesignationScreen());

      default:
        if (kDebugMode) {
          print('value miss math');
        }
    }
  }
}
