import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/new_project_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/create_project/create_project_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/project_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_list/project_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/provider/project_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/widgets/total_project_card.dart';
import 'package:hrm_app/screens/custom_widgets/custom_tap_bar_button.dart';
import 'package:hrm_app/screens/custom_widgets/dashboard_shimer_effect.dart';
import 'package:hrm_app/screens/custom_widgets/project_status_card.dart';
import 'package:hrm_app/screens/custom_widgets/see_all_title.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../api_service/connectivity/no_internet_screen.dart';
import '../../../../../live_traking/location_provider.dart';
import '../../../../../utils/nav_utail.dart';
import '../../../../custom_widgets/progress_indecator_with_persentage.dart';

class ProjectDashboardScreen extends StatelessWidget {
  const ProjectDashboardScreen({super.key});

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      value: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
              spacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0XFF004D96),
                          Color(0XFF0082FF),
                        ]),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[600]),
                ).tr()
              ]),
          const Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocationProvider(),
        child: Consumer<LocationProvider>(builder: (context, locationProvider, _) {
          return NoInternetScreen(
            child: ChangeNotifierProvider(
              create: (context) =>
                  CrmProjectProvider(context, locationProvider),
              child:
                  Consumer<CrmProjectProvider>(builder: (context, provider, _) {
                var statistics =
                    provider.crmProjectDashboardResponse?.data?.staticstics;
                return Scaffold(
                    backgroundColor: const Color(0xffF5F6FA),
                    appBar: AppBar(
                      elevation: 0,
                      title: Text(
                        'Projects',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold),
                      ).tr(),
                      actions: [
                        Visibility(
                          visible: provider.isAdmin ?? false,
                          child: PopupMenuButton(
                            icon: const Icon(
                              Icons.more_vert_rounded,
                            ),
                            onSelected: (value) {
                              menuItemRoute(value, context);
                            },
                            itemBuilder: (BuildContext context) => [
                              _buildPopupMenuItem('add_project'),
                            ],
                          ),
                        )
                      ],
                    ),
                    body: provider.crmProjectDashboardResponse?.data != null
                        ? SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 24.h, horizontal: 17.w),
                              child: Column(
                                children: [
                                  statistics?.isNotEmpty == true
                                      ? GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: statistics?.length ?? 0,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisExtent: 140,
                                                  crossAxisSpacing: 4.0,
                                                  mainAxisSpacing: 4.0),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final data = statistics?[index];
                                            return TotalProjectCard(
                                              image: data?.image,
                                              count: data?.count.toString(),
                                              label: data?.label,
                                            );
                                          })
                                      : GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: 4,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisExtent: 140,
                                                  crossAxisSpacing: 4.0,
                                                  mainAxisSpacing: 4.0),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Shimmer.fromColors(
                                              baseColor: const Color.fromARGB(
                                                  223, 232, 232, 232),
                                              highlightColor: Colors.white,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(16.0),
                                                height: 120.w,
                                                width: 120.w,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFE8E8E8),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // radius of 10// green as background color
                                                ),
                                              ),
                                            );
                                          }),

                                  ///list title
                                  SeeAllTitle(
                                    titile: "Projects".tr(),
                                    ontap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ProjectListScreen()),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),

                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: provider
                                              .crmProjectDashboardResponse
                                              ?.data
                                              ?.projects
                                              ?.length ??
                                          0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final data = provider
                                            .crmProjectDashboardResponse
                                            ?.data
                                            ?.projects?[index];
                                        List<Widget> users = [];

                                        for (int i = 0;
                                        i < data!.members!.length;
                                        i++) {
                                          users.add(Positioned(
                                            left: i * 15,
                                            top: 0.0,
                                            bottom: 0.0,
                                            child: InkWell(
                                              onTap: (){
                                                showDialog<String>(
                                                  context: context,
                                                  builder: (BuildContext context) => AlertDialog(
                                                    title:  Text("name : ${data.members!.elementAt(i).name ?? ""}"),
                                                    content: Text("designation : ${data.members!.elementAt(i).designation}\nDepartment : ${data.members!.elementAt(i).department ?? ""}\nPhone : ${data.members!.elementAt(i).phone ?? ""}\nemail : ${data.members!.elementAt(i).email ?? ""}").tr(),
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
                                                            '${data.members!.elementAt(i).avatar}'))),
                                                child: const SizedBox.shrink(),
                                              ),
                                            ),
                                          ));
                                        }
                                        return ProjectStatusCard(
                                          ontap: () {
                                            Project project = Project(
                                              id: data.id,
                                              name: data.title,
                                              status: data.status,
                                              color: data.color,
                                            );
                                            NavUtil.navigateScreen(context, NewProjectDetailsScreen(projectId: project.id ?? 0));

                                          },
                                          tapBarButton1: CustomTapBarButton(
                                            buttonColor:
                                                const Color(0xffF4EFFD),
                                            textColor: const Color(0xff5B58FF),
                                            buttonText: data.status,
                                            borderColor:
                                                const Color(0xffF4EFFD),
                                          ),
                                          tapBarButton2: CustomTapBarButton(
                                            buttonColor:
                                                const Color(0xffFDEFEF),
                                            textColor: const Color(0xffE96161),
                                            buttonText: data.priority,
                                            borderColor:
                                                const Color(0xffFDEFEF),
                                          ),
                                          startData: data.dateRange,
                                          rightIconArrowColor:
                                              const Color(0xff00606F),
                                          projectName: data.title,
                                          usersImage: users,
                                          userCount: data.userCount,
                                          progressBar:
                                              ProgressIndeccatorWithPersentage(
                                            persentageActiveColor:
                                                const Color(0xff00606F),
                                            persentageDisebleColor:
                                                const Color(0xffEAEAEA),
                                            activeContainerWidth: ((ScreenUtil
                                                            .defaultSize.width -
                                                        80.0) *
                                                    double.parse(
                                                        '${data.progress}')) /
                                                100,
                                            deActivetContainerWidth: (ScreenUtil
                                                        .defaultSize.width -
                                                    80.0) -
                                                ((ScreenUtil.defaultSize.width -
                                                            85.0) *
                                                        double.parse(
                                                            '${data.progress}')) /
                                                    100,
                                            persentage:
                                                "${data.progress ?? 0}%",
                                          ),
                                        );
                                      }),

                                  SizedBox(
                                    height: 82.h,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const DashboardShimerEffect());
              }),
            ),
          );
        }));
  }

  menuItemRoute(value, context) {
    switch (value) {
      case "add_project":
        return NavUtil.navigateScreen(context, const CreateProjectScreen());
      default:
        if (kDebugMode) {
          print('value miss math');
        }
    }
  }
}
