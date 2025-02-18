import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/data/model/employee_model/department_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/departments/edit_departments/edit_departments_provider.dart';
import 'package:hrm_app/screens/custom_widgets/add_client_textfield.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class EditDepartment extends StatelessWidget {
  final Department? departmentDetails;
  const EditDepartment({super.key, this.departmentDetails, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        onTap.call();
        return true;
      },
      child: ChangeNotifierProvider(
          create: (context) => EditDepartmentProvider(departmentDetails!),
          child: Consumer<EditDepartmentProvider>(
            builder: (context, provider, _) {
              return Scaffold(
                backgroundColor: AppColors.backgroundColor,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: const Text("Edit Departments"),),
                body: Padding(
                  padding: EdgeInsets.all(12.0.sp),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 70.h,
                        ),
                        Text(
                          "Department name*",
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
                              backgroundColor: const Color(0xff5B58FF), shape: RoundedRectangleBorder(
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
          )),
    );
  }
}
