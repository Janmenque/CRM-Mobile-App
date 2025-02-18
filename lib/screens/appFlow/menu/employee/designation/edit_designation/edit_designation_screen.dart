import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/data/model/employee_model/designation_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/designation/edit_designation/edit_designation_provider.dart';
import 'package:hrm_app/screens/custom_widgets/add_client_textfield.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class EditDesignationScreen extends StatelessWidget {
  final Designation? designationDetails;
  const EditDesignationScreen({super.key, this.designationDetails});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EditDesignationProvider(designationDetails!),
        child: Consumer<EditDesignationProvider>(
          builder: (context, provider, _) {
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(56.h),
                child: const CustomTitleAppBar(
                  title: "Edit Designation",
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(12.0.sp),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 70.h,
                      ),
                      Text(
                        "Designation name*",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AddClientTextField(
                        textController: provider.titleController,
                      ),
                      SizedBox(
                        height: 117.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            provider.postEditDepartmentData(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5B58FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ]),
              ),
            );
          },
        ));
  }
}
