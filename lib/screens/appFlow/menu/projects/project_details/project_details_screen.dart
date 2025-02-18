import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/project_details_provider.dart';
import 'package:hrm_app/screens/custom_widgets/progress_indecator_with_persentage.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/api_response.dart';
import '../../../../../utils/res.dart';
import '../../clients/crm_clinet_repository/client_repository.dart';
import '../../clients/model/project_details_model.dart';
import 'content/attachment_tabview.dart';
import 'content/task_view/task_tabview.dart';

class ProjectDetailsScreen extends StatelessWidget {
  ProjectDetailsScreen({super.key, this.project, required this.projectId});

  final Project? project;
  final int? projectId;

  final List<Tab> myTabs = <Tab>[
     Tab(text: 'Tasks'.tr()),
     Tab(text: 'Attachment'.tr()),
  ];

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      value: title,
      child: Text(
        title,
        style: TextStyle(color: Colors.grey[600]),
      ).tr(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => ProjectDetailsProvider(projectId),
      child: Consumer<ProjectDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: AppBar(
              elevation: 0,
              actions: [
                Visibility(
                  visible: provider.isAdmin ?? false,
                  child: InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print(projectId);
                      }
                      provider.projectDelete(projectId, context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.colorPrimary),
                      child: Icon(
                        size: 14.0.r,
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )

              ],
              title: Text(
                "project_details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ).tr(),
            ),
            body: FutureBuilder<ApiResponse<ProjectDetailsModel>>(
              future:
                  CrmClientRepository.getProjectDetailsData(id: project?.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Widget> assigns = [];
                  final data = snapshot.data?.data?.data;

                  for (int i = 0; i < data!.projectDetailsMembers!.length; i++) {
                    assigns.add(Positioned(
                      left: i * 15,
                      top: 0.0,
                      bottom: 0.0,
                      child: InkWell(
                        onTap: (){
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title:  Text("name : ${data.projectDetailsMembers!.elementAt(i).name ?? ""}").tr(),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('ok').tr(),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: 30.0.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${data.projectDetailsMembers!.elementAt(i).avatar}'))),
                          child: const SizedBox.shrink(),
                        ),
                      ),
                    ));
                  }

                  return SingleChildScrollView(
                    //primary: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                '${data.name}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              )),
                              Visibility(
                                child: Visibility(
                                  visible: provider.isAdmin ?? false,
                                  child: PopupMenuButton(
                                    onSelected: (value) {
                                      provider.menuItemRoute(value, context, data);
                                    },
                                    itemBuilder: (BuildContext context) => [
                                       _buildPopupMenuItem('update'),
                                      _buildPopupMenuItem('delete'),
                                    ],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/task/task_menu_dot.png",
                                        height: 6.h,
                                        width: 18.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            '${data.description}',
                            textAlign: TextAlign.justify,
                            maxLines: 5,
                            style: TextStyle(
                                color: const Color(0xff8A8A8A),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                "Assigned : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ).tr(),
                              SizedBox(
                                width: 8.w,
                              ),
                              data.projectDetailsMembers != null ?
                                SizedBox(
                                  width: 25.0 * data.projectDetailsMembers!.length,
                                  height: 40.0.h,
                                  child: Stack(children: assigns),
                                ) : const SizedBox(),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                "Project Owner : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ).tr(),
                              SizedBox(
                                width: 8.w,
                              ),
                              InkWell(
                                  onTap: (){
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title:  Text("name :  '${data.projectOwner?.name}'").tr(),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'OK'),
                                            child: const Text('ok').tr(),
                                          ),
                                        ],
                                      ),
                                    );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Image.network(
                                    '${data.projectOwner?.avatar}',
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                "Project Client :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ).tr(),
                              SizedBox(
                                width: 8.w,
                              ),
                              InkWell(
                                onTap: (){
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title:  Text("name :  '${data.client?.name}'").tr(),
                                      //content: Text("Designation : ${data.owner!.elementAt(i).}\nDepartment : ${data.users!.elementAt(i).department ?? ""}"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'OK'),
                                          child: const Text('ok').tr(),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Image.network(
                                    '${data.projectOwner?.avatar}',
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                "Project Status : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ).tr(),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                '${data.status}',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: const Color(0xff8A8A8A),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ).tr(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                "Start Date : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ).tr(),
                              SizedBox(
                                width: 15.w,
                              ),
                              Image.asset(
                                "assets/projects/calender_black.png",
                                height: 20.h,
                                width: 20.w,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                '${data.startDate}',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: const Color(0xff8A8A8A),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                "End Date : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ).tr(),
                              SizedBox(
                                width: 15.w,
                              ),
                              Image.asset(
                                "assets/projects/calender_black.png",
                                height: 20.h,
                                width: 20.w,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                '${data.endDate}',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: const Color(0xff8A8A8A),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            "project_progress",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ).tr(),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ProgressIndeccatorWithPersentage(
                            persentageActiveColor: const Color(0xff615FFF),
                            persentageDisebleColor: const Color(0xffC9C9C9),
                            activeContainerWidth:
                                ((ScreenUtil.defaultSize.width - 80.0) *
                                        double.parse('${data.progress}')) /
                                    100,
                            deActivetContainerWidth: (ScreenUtil
                                        .defaultSize.width -
                                    80.0) -
                                ((ScreenUtil.defaultSize.width - 85.0) *
                                        double.parse('${data.progress}')) /
                                    100,
                            containerHeight: 12.h,
                            persentage: "${data.progress}%",
                            persentageTextHeight: 16.h,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.only(
                              top: 31.h, left: 17.w, right: 17.w),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: DefaultTabController(
                            length: myTabs.length,
                            child: Scaffold(
                              appBar: PreferredSize(
                                preferredSize: Size.fromHeight(56.h),
                                child: AppBar(
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  automaticallyImplyLeading: false,
                                  bottom: TabBar(
                                    indicatorColor: const Color(0xff615FFF),
                                    tabs: myTabs,
                                    labelColor: const Color(0xff615FFF),
                                    unselectedLabelColor: Colors.black,
                                  ),
                                ),
                              ),
                              body: TabBarView(

                                  children: [
                                TaskTabView(project: data),
                                AttachmentTabView(project: data),
                              ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return const Center(
                  child: Text(''),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
