
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/create_project/create_project_provider.dart';
import 'package:hrm_app/screens/custom_widgets/create_task_textfield.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import '../../clients/model/client_list_model.dart';

class CreateProjectScreen extends StatefulWidget {

  const CreateProjectScreen({super.key, this.id});
  final int? id;



  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (context) => CrmCreateProjectProvider(),
      child: Consumer<CrmCreateProjectProvider>(
        builder: (BuildContext context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(56.h),
              child:  CustomTitleAppBar(
                title: "create_project".tr(),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 33.h, horizontal: 18),
              child: SingleChildScrollView(
                child:
                 Form(
                   key: formKey,
                   child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "name",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ).tr(),
                        SizedBox(
                          height: 5.h,
                        ),
                        CreateTaskTextField(
                          textController: provider.projectNameController,
                          hintText: "Project Title",
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "description",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ).tr(),
                        SizedBox(
                          height: 5.h,
                        ),
                        CreateTaskTextField(
                          textController: provider.projectDescriptionController,
                          hintText: "Write Project Description here...",
                          maxLine: 4,
                        ),
                             SizedBox(
                        height: 16.h,
                      ),
                       Text(
                          "Clients",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ).tr(),
                        SizedBox(
                          height: 5.h,
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
                              provider.selectClient(newValue!);
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
                          height: 15.h,
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
                              onTap:(){
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
                              '${provider.dateRange?.start.day ?? ""}.${provider.dateRange?.start.month ?? ""}.${provider.dateRange?.start.year ?? ""}',
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
                              '${provider.dateRange?.end.day ?? ""}.${provider.dateRange?.end.month ?? ""}.${provider.dateRange?.end.year ?? ""}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        widget.id == null
                            ? Column(
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
                                      title: Text(provider.allUserData?.name! ??
                                          "Assign Members"),
                                      subtitle: Text(
                                          provider.allUserData?.designation! ??
                                              "Assign Members"),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(provider
                                                .allUserData?.avatar! ??
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
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(100),
                                                  gradient: const LinearGradient(
                                                      colors: [
                                                        AppColors.primaryColor,
                                                        AppColors.primaryColor,
                                                      ],
                                                      begin: FractionalOffset(
                                                          2.0, 0.0),
                                                      end: FractionalOffset(
                                                          0.0, 1.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                                ),
                                                child:  Text(
                                                  //"",
                                                  provider.userNames[index],
                                                  style: const  TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )))),
                                  )
                                ],
                              )
                            : const SizedBox(),

                        SizedBox(
                          height: 16.h,
                        ),
                        ElevatedButton(
                               onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await provider.createProject(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              minimumSize: Size(double.infinity, 50.h),
                            ),
                            child: Text(
                              "create_project",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ).tr())
                      ]),
                 ),
              ),
            ),
          );
        },
      ),
    );
  }
}
