import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/task/create_task/create_task_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/create_task_model.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/connectivity/no_internet_screen.dart';
import '../../../../custom_widgets/create_task_textfield.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key, this.id});

  final int? id;

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

final formKey = GlobalKey<FormState>();

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => CrmCreateTaskProvider(),
        child: Consumer<CrmCreateTaskProvider>(builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Create Task',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ).tr(),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 33.h, horizontal: 18),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create New Task",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp),
                      ).tr(),
                      SizedBox(
                        height: 15.h,
                      ),

                      ///Client select dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffEBEBEB)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Client?>(
                            isExpanded: true,
                            hint: Text(
                              "select_client",
                              style: TextStyle(
                                  color: const Color(0xff8A8A8A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ).tr(),
                            value: provider.client,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.primaryColor,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (Client? newValue) {
                              provider.selectclien(newValue!);
                            },
                            items: provider.clientList
                                ?.map<DropdownMenuItem<Client>>((Client value) {
                              return DropdownMenuItem<Client>(
                                value: value,
                                child: Text(
                                  value.name ?? '',
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 16.h,
                      ),

                      ///project select dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffEBEBEB)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Project?>(
                            isExpanded: true,
                            hint: Text(
                              "select_project",
                              style: TextStyle(
                                  color: const Color(0xff8A8A8A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ).tr(),
                            value: provider.project,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.primaryColor,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (Project? newValue) {
                              provider.selectProject(newValue!);
                            },
                            items: provider.projectList
                                ?.map<DropdownMenuItem<Project>>(
                                    (Project value) {
                              return DropdownMenuItem<Project>(
                                value: value,
                                child: Text(
                                  value.name ?? '',
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                      CreateTaskTextField(
                        hintText: "Task Title".tr(),
                        textController: provider.tiitleController,
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                      CreateTaskTextField(
                        hintText: "Description".tr(),
                        textController: provider.projectDescriptiionController,
                        maxLine: 5,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        "Deadline",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      ).tr(),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              provider.pickDateRange(context);
                            },
                            child: Image.asset(
                              "assets/projects/light_calender_new.png",
                              height: 44.h,
                              width: 44.w,
                            ),
                          ),
                          SizedBox(
                            width: 23.w,
                          ),
                          Text(
                            '${provider.dateRange.start.day}.${provider.dateRange.start.month}.${provider.dateRange.start.year}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: 23.w,
                          ),
                          Image.asset(
                            "assets/projects/dark_calender.png",
                            height: 44.h,
                            width: 44.w,
                          ),
                          SizedBox(
                            width: 23.w,
                          ),
                          Text(
                            '${provider.dateRange.end.day}.${provider.dateRange.end.month}.${provider.dateRange.end.year}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            "assign",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp),
                          ).tr(),
                          SizedBox(
                            height: 5.h,
                          ),
                          Card(
                            elevation: 0,
                            child: ListTile(
                              onTap: () => provider.getAllUserData(context),
                              title: Text(provider.allMemberData?.name! ??
                                  "Assign Members"),
                              subtitle: Text(provider.allMemberData?.name! ??
                                  "Assign Members"),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(provider
                                        .allMemberData?.avatar! ??
                                    'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                              ),
                              trailing: const Icon(Icons.edit),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                                children: List.generate(
                                    provider.userNames.length,
                                    (index) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          gradient: const LinearGradient(
                                              colors: [
                                                AppColors.primaryColor,
                                                AppColors.primaryColor,
                                              ],
                                              begin: FractionalOffset(2.0, 0.0),
                                              end: FractionalOffset(0.0, 1.0),
                                              stops: [0.0, 1.0],
                                              tileMode: TileMode.clamp),
                                        ),
                                        child: Text(
                                          //"",
                                          provider.userNames[index],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )))),
                          )
                        ],
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffEBEBEB)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Priority?>(
                            isExpanded: true,
                            hint: Text(
                              "Select status",
                              style: TextStyle(
                                  color: const Color(0xff8A8A8A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ).tr(),
                            value: provider.priority,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.primaryColor,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (Priority? newValue) {
                              provider.selectPriority(newValue!);
                            },
                            items: provider.priorityList
                                ?.map<DropdownMenuItem<Priority>>(
                                    (Priority value) {
                              return DropdownMenuItem<Priority>(
                                value: value,
                                child: Text(
                                  value.title ?? '',
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.w,
                      ),

                      ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await provider.createTask(context);
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
                            "Create Task",
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
        }),
      ),
    );
  }
}
