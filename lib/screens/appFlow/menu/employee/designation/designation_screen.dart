import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/designation/designation_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/designation/edit_designation/edit_designation_screen.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'components/designation_section_cart.dart';

class DesignationScreen extends StatelessWidget {
  const DesignationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DesignationListProvider(),
      child: Consumer<DesignationListProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(56.h),
              child:  CustomTitleAppBar(
                title: "Designation".tr(),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
                child: Column(
                  children: [
                    provider.designationListModel?.data
                        ?.designations != null ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.designationListModel?.data
                                ?.designations?.length ??
                            0,
                        itemBuilder: (BuildContext context, int index) {
                          final data = provider
                              .designationListModel?.data?.designations?[index];
                          return DesignationSectionCart(
                            title: data?.title,
                            status: data?.status,
                            createdAt: data?.createdAt,
                            onTap: () {
                              NavUtil.navigateScreen(
                                  context,
                                  EditDesignationScreen(
                                    designationDetails: data,
                                  ));
                            },
                            onDeleteTap: () {
                              Navigator.pop(context);
                              provider.deleteDesignation(data!.id);
                            },
                          );
                        }) :
                    const CustomListShimer()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
