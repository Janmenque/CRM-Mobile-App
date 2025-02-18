import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/employee_model/employee_details_model.dart';
import 'package:hrm_app/data/model/employee_model/employee_list_model.dart';
import 'package:hrm_app/data/server/respository/employee_repository/employee_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/edit_employee/edit_employee_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/employee_dashboard/employee_dashboard_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/employee_details/employee_details_provider.dart';
import 'package:hrm_app/screens/custom_widgets/horizontal_divider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final int employeeId;
  const EmployeeDetailsScreen({super.key, required this.employeeId});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  EmployeeDetailsModel? employeeDetailsModel;
  EmployeeListModel? employeeListModel;

  @override
  void initState() {
    getDetailsData(widget.employeeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmployeeDetailsProvider(),
      child: Consumer<EmployeeDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                "employee_details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ).tr(),
              actions: [
                Visibility(
                  visible: provider.isAdmin ?? false,
                  child: InkWell(
                    onTap: () => NavUtil.navigateScreen(
                        context,
                        EditEmployeeScreen(
                          employeeDetails: employeeDetailsModel!,
                          onTap: () {
                            setState(() {
                              getDetailsData(widget.employeeId);
                            });
                          },
                        )),
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.colorPrimary),
                      child: const Icon(
                        size: 14.0,
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: provider.isAdmin ?? false,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        getEmployeeDelete(widget.employeeId);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.colorPrimary),
                      child: Icon(
                        size: 14.0.r,
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Center(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          height: 80.h,
                          width: 80.h,
                          fit: BoxFit.cover,
                          imageUrl: employeeDetailsModel?.data?.avatar ??
                              "https://www.w3schools.com/howto/img_avatar.png",
                          placeholder: (context, url) => Center(
                            child: Image.asset(
                                "assets/images/placeholder_image.png"),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Center(
                        child: Text(
                      employeeDetailsModel?.data?.name ?? '',
                      style: TextStyle(
                          height: 1.5.h,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                    )),
                    Center(
                        child: Text(
                      employeeDetailsModel?.data?.designation ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        height: 1.5.h,
                      ),
                    ).tr()),
                    Center(
                        child: Text(
                      employeeDetailsModel?.data?.address ?? '',
                      style: TextStyle(
                        color: const Color(0xff8A8A8A),
                        fontSize: 14.sp,
                        height: 1.5.h,
                      ),
                    )),
                    SizedBox(
                      height: 16.h,
                    ),
                    const HorizontalDivider(dividerColor: Colors.black),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      employeeDetailsModel?.data?.phone == null ? "" : "phone",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.3.h),
                    ).tr(),
                    Text(
                      employeeDetailsModel?.data?.phone ?? '',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.3.h),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      employeeDetailsModel?.data?.email == null ? "" :"email",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.3.h),
                    ).tr(),
                    Text(
                      employeeDetailsModel?.data?.email ?? '',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.3.h),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      employeeDetailsModel?.data?.address == null ? "" :"location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.3.h),
                    ).tr(),
                    Text(
                      employeeDetailsModel?.data?.address ?? '',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.3.h),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      employeeDetailsModel?.data?.aboutMe == null ? "" : "about_me",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.3.h),
                    ).tr(),
                    Text(
                      employeeDetailsModel?.data?.aboutMe ?? '',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.3.h),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      employeeDetailsModel?.data?.skills?.isEmpty == true ? "" :"skills",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.3.h),
                    ).tr(),
                    SizedBox(
                      height: 11.h,
                    ),
                    employeeDetailsModel?.data != null
                        ? Wrap(
                            children: employeeDetailsModel!.data!.skills!
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                    child: Chip(
                                      label: Text(e.name!),
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void getDetailsData(employeeId) async {
    final response = await EmployeeRepository.getEmployeeDetails(employeeId);
    if (response.httpCode == 200) {
      setState(() {
        employeeDetailsModel = response.data;
      });
    }
  }

  void getEmployeeDelete(employeeId) async {
    final response = await EmployeeRepository.employeeDelete(employeeId);
    if (response['result'] == true) {
      Fluttertoast.showToast(msg: "Employee Deleted Successfully");
      NavUtil.replaceScreen(context, const EmployeeDashboardScreen());
      setState(() {
        employeeDetailsModel = response.data;
      });
    }
  }
}
