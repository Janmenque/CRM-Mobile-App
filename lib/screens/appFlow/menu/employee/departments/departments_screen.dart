import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/departments/department_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/departments/edit_departments/edit_departments.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

import 'components/departments_section_cart.dart';

class Departments extends StatelessWidget {
  const Departments({super.key});

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => EmployeeDepartmentListProvider(),
        child: Consumer<EmployeeDepartmentListProvider>(
            builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(56.h),
              child:  CustomTitleAppBar(
                title: "Departments".tr(),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
                child: Column(
                  children: [
                    provider.departmentListModel?.data
                        ?.departments != null ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.departmentListModel?.data
                                ?.departments?.length ??
                            0,
                        itemBuilder: (BuildContext context, int index) {
                          final data = provider
                              .departmentListModel?.data?.departments?[index];
                          return DepartmentsSectionCart(
                            title: data?.title,
                            status: data?.status,
                            createdAt: data?.createdAt,
                            onTap: () {
                              NavUtil.navigateScreen(
                                  context,
                                  EditDepartment(
                                    departmentDetails: data,
                                    onTap: () {
                                      provider.getDepartment();
                                    },
                                  ));
                            },
                            onDeleteTap: () {
                              Navigator.pop(context);
                              provider.deleteDepartment(data!.id!);
                            },
                          );
                        })
                        : const CustomListShimer()
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
