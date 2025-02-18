
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/data/model/employee_model/employee_details_model.dart';
import 'package:hrm_app/data/model/response_department_list.dart';
import 'package:hrm_app/data/model/response_designation_list.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/edit_employee/edit_employee_provider.dart';
import 'package:hrm_app/screens/custom_widgets/add_client_textfield.dart';
import 'package:hrm_app/screens/custom_widgets/label_text.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class EditEmployeeScreen extends StatelessWidget {
  const EditEmployeeScreen(
      {Key? key, required this.employeeDetails, required this.onTap})
      : super(key: key);
  final EmployeeDetailsModel employeeDetails;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: ChangeNotifierProvider(
        create: (BuildContext context) {
          return EditEmployeeProvider(employeeDetails);
        },
        child: Consumer<EditEmployeeProvider>(
          builder: (BuildContext context, provider, _) {
            Future<void> showMyDialog(context) async {
              return showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Add Skills'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          TextField(
                            controller: provider.skillController,
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Add'),
                        onPressed: () {
                          provider.addSkill();
                          Navigator.of(context).pop();
                          provider.skillController.clear();
                        },
                      ),
                    ],
                  );
                },
              );
            }

            final formKey = GlobalKey<FormState>();

            return 
            Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: InkWell(
                  onTap: () {
                    onTap.call();
                    if (kDebugMode) {
                      print("Tap click");
                    }
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                title: const Text(
                  "edit_employee",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ).tr(),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () => provider.pickImage(context),
                                child: Container(
                                  height: 110,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: const Color(0xFFE4E4E4),
                                          width: 8)),
                                  child: provider.imagePath == null
                                      ? ClipOval(
                                          child: Image.network(
                                          provider.profileImage!,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ))
                                      : ClipOval(
                                          child: Image.file(
                                          provider.imagePath!,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )),
                                ),
                              ),
                              Positioned(
                                bottom: 6,
                                right: 6,
                                child: Container(
                                  padding:  const EdgeInsets.all(4),
                                  decoration:  const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.colorPrimary),
                                  child: const  Icon(
                                    size: 18.0,
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const LavelText(
                          text: "Employee Name * ",
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddClientTextField(
                          hintText: "Enter Employee Name",
                          textController: provider.nameController,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LavelText(
                          text: "Designation * ",
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffEAEAEA)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          child: DropdownButton<Designation>(
                            isExpanded: true,
                            underline: Container(color: Colors.transparent),
                            hint: const Text('Select Designation'),
                            value: provider.designation,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (Designation? value) {
                              provider.selectDesignation(value!);
                            },
                            items: provider.designationList
                                ?.map<DropdownMenuItem<Designation>>(
                                    (Designation value) {
                              return DropdownMenuItem<Designation>(
                                value: value,
                                child: Text(
                                  value.title ?? '',
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LavelText(
                          text: "Department * ",
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffEAEAEA)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          child: DropdownButton<Department>(
                            isExpanded: true,
                            underline: Container(color: Colors.transparent),
                            hint: const Text('Select Department'),
                            value: provider.department,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (Department? value) {
                              provider.selectDepartment(value!);
                            },
                            items: provider.departmentsList
                                ?.map<DropdownMenuItem<Department>>(
                                    (Department value) {
                              return DropdownMenuItem<Department>(
                                value: value,
                                child: Text(
                                  value.title ?? '',
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LavelText(
                          text: "Phone Number * ",
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddClientTextField(
                          hintText: "xxxxxxxxxxx",
                          textController: provider.phoneController,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LavelText(
                          text: "Email * ",
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddClientTextField(
                          hintText: "example@gmail.com",
                          textController: provider.emailController,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LavelText(
                          text: "Location * ",
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddClientTextField(
                          hintText: "Enter Your Location",
                          textController: provider.locationController,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LavelText(
                          text: "Description * ",
                        ),

                        SizedBox(
                          height: 10.h,
                        ),
                        AddClientTextField(
                          hintText: "Write your description here...",
                          textController: provider.descriptionController,
                          maxLine: 4,
                        ),

                        SizedBox(
                          height: 16.h,
                        ),
                        const LavelText(
                          text: "Skills",
                        ),

                        SizedBox(
                          height: 10.h,
                        ),
                        Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ...List.generate(
                              provider.skillList.length,
                              (index) {
                                final data = provider.skillList[index];
                                return Wrap(
                                  spacing: 6,
                                  children: [
                                    Chip(
                                      label: Text(data),
                                      deleteIcon: const Icon(Icons.cancel),
                                      onDeleted: () {
                                        provider.removeSkillFromList(index);
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                            InkWell(
                              onTap: () => showMyDialog(context),
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30.h,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await provider.editEmployee(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              minimumSize: Size(double.infinity, 60.h),
                            ),
                            child: Text(
                              "edit_employee",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ).tr())
                      ],
                    ),
                  ),
                ),
              ),
            );
          
          },
        ),
      ),
    );
  }
}
