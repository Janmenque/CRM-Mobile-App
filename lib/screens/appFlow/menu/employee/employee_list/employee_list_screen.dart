import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/employee_details/emlployee_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/employee_list/employee_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/widget/employee_list_update_card.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/connectivity/no_internet_screen.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => EmployeeListProvider(),
        child: Consumer<EmployeeListProvider>(builder: (context, provider, _) {
          return 
          Scaffold(
                  backgroundColor: const Color(0xffF5F6FA),
                  appBar: AppBar(
                          elevation: 0,
            title:  Text("employee_list", style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),).tr(),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 24.h, horizontal: 18.w),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffEBEBEB)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            child: TextFormField(
                              onChanged: ((value) {
                                provider.getSearchValue(value);
                              }),
                              maxLines: 1,
                              cursorColor: const Color(0xff5B58FF),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(8.sp),
                                      height: 29.h,
                                      width: 29.w,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff5B58FF)),
                                      child: Image.asset(
                                        "assets/task/search_bar.png",
                                        height: 11.h,
                                        width: 11.w,
                                      ),
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                      color: const Color(0xffCED1DA),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp),
                                  hintText: "Search...."),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          provider.crmEmployeeListResponse?.data?.employees != null ?
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.crmEmployeeListResponse?.data
                                  ?.employees?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final data = provider.crmEmployeeListResponse
                                    ?.data?.employees?[index];
                                return EmployeeListUpdateCard(
                                  name: data?.name,
                                  designation: data?.designation,
                                  address: data?.phone,
                                  image: data?.avatar,
                                  onTap: () {
                                    NavUtil.navigateScreen(
                                        context,
                                        EmployeeDetailsScreen(
                                          employeeId: data!.id!,
                                        ));
                                  },
                                );
                              }) : const CustomListShimer()
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
