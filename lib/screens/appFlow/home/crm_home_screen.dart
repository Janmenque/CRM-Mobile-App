import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/live_traking/location_provider.dart';
import 'package:hrm_app/screens/appFlow/home/home_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/client_list/client_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/componets/menu_drawer.dart';
import 'package:hrm_app/screens/appFlow/menu/menu_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/my_account.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/new_project_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/screen/new_task_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/project_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_details/task_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_list/task_list_provider.dart';
import 'package:hrm_app/screens/appFlow/natification/notification_screen.dart';
import 'package:hrm_app/screens/custom_widgets/custom_tap_bar_button.dart';
import 'package:hrm_app/screens/custom_widgets/home_page_grid_card.dart';
import 'package:hrm_app/screens/custom_widgets/home_page_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/see_all_title.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../api_service/connectivity/no_internet_screen.dart';
import '../../custom_widgets/progress_indecator_with_persentage.dart';
import '../../custom_widgets/project_status_card.dart';
import '../menu/projects/project_list/project_list_screen.dart';
import '../menu/task/task_list/task_list_screen.dart';
import '../menu/task/widgets/task_assign_card_with_date.dart';

class CrmHomeScreen extends StatefulWidget {
  const CrmHomeScreen({super.key});

  @override
  State<CrmHomeScreen> createState() => _CrmHomeScreenState();
}

class _CrmHomeScreenState extends State<CrmHomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var providerMenu = context.watch<MenuProvider>();
    context.read<LocationProvider>();
          return NoInternetScreen(
            child: ChangeNotifierProvider(
              create: (context) => HomeProvider(context ),
              child: Consumer<HomeProvider>(builder: (context, provider, _) {
                return Scaffold(
                  backgroundColor: AppColors.backgroundColor,
                  key: scaffoldKey,
                  drawer: MenuDrawer(provider: providerMenu),
                  extendBody: true,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(70),
                    child: AppBar(
                      elevation: 0,
                      backgroundColor: AppColors.primaryColor,
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: InkWell(
                          onTap: () {
                            if (scaffoldKey.currentState!.isDrawerOpen) {
                              scaffoldKey.currentState?.openDrawer();
                            } else {
                              scaffoldKey.currentState?.openDrawer();
                            }
                          },
                          child: Container(
                            padding:  EdgeInsets.all(8.sp),
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.menu, color: AppColors.black,),
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          "home_screen",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ).tr(),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, right: 16),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  NavUtil.navigateScreen(context, const NotificationScreen());
                                },
                                child: Image.asset(
                                  "assets/task/notification_vector.png",
                                  height: 50.h, width: 45.w,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (_) => const MyAccount()));
                                },
                                child:  ClipOval(
                                  child: CachedNetworkImage(
                                    height: 50.h,
                                    width: 40.w,
                                    fit: BoxFit.cover,
                                    imageUrl: "${provider.profileImage}",
                                    placeholder: (context, url) => Center(
                                      child:
                                      Image.asset("assets/images/placeholder_image.png"),
                                    ),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: provider.crmResponseData?.data?.projectSummary?.data != null ?
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 24.h, horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Hi, ${provider.userName ?? ""}", style: TextStyle( fontSize: 18.sp),).tr(),
                            Text("welcome_back".tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
                          SizedBox(
                            height: 21.h,
                          ),
                          SizedBox(
                          height: 260.h,
                          //color: Colors.ger,
                          child: GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children:  [
                              HomePageDashboardCard(
                                cardColor: AppColors.white,
                                cardLogo: "assets/images/crm_project.png",
                                title: "projects",
                                count: "${provider.crmResponseData?.data?.projectCount?.count ?? 0}",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const ProjectListScreen()));
                                },
                              ),
                              HomePageDashboardCard(
                                cardColor: AppColors.white,
                                cardLogo: "assets/images/crm_client.png",
                                title: "Clients",
                                count: "${provider.crmResponseData?.data?.clientCount?.count ?? 0}",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const ClientListScreen()));
                                },
                              ),
                              HomePageDashboardCard(
                                cardColor: AppColors.white,
                                cardLogo: "assets/images/crm_task.png",
                                title: "Task",
                                count: "${provider.crmResponseData?.data?.taskCount?.count ?? 0}",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const TaskListScreen()));
                                },
                              ),
                            const HomePageDashboardCard(
                                cardColor: AppColors.white,
                                cardLogo: "assets/images/crm_income.png",
                                title: "Income",
                                count: "00",
                              ),
                              const  HomePageDashboardCard(
                                cardColor: AppColors.white,
                                cardLogo: "assets/images/crm_expense.png",
                                title: "Expense",
                                count: "00",
                              ),
                              const HomePageDashboardCard(
                                cardColor: AppColors.white,
                                cardLogo: "assets/images/crm_expense.png",
                                title: "Profit",
                                count: "00",
                              ),
                            ],
                          ),
                        ),
                            SizedBox(
                              height: 24.h,
                            ),

                            ///projct title
                            SeeAllTitle(
                              titile: "my_projects",
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const ProjectListScreen()));
                              },
                            ),
                            SizedBox(
                              height: 02.h,
                            ),
                            ///project list
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.crmResponseData?.data
                                    ?.projects?.length ??
                                    0,
                                itemBuilder: (BuildContext context, index) {
                                  final data = provider
                                      .crmResponseData?.data?.projects?[index];
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
                                              title:  Text("name : ${data.members!.elementAt(i).name ?? ""}").tr(),
                                              content: Text("designation : ${data.members!.elementAt(i).designation ?? ""}\nDepartment : ${data.members!.elementAt(i).department ?? ""}\nPhone : ${data.members!.elementAt(i).phone ?? ""}\nEmail : ${data.members!.elementAt(i).email ?? ""}").tr(),
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
                                      ;
                                    },
                                    tapBarButton1:  CustomTapBarButton(
                                      buttonColor: const Color(0xffF4EFFD),
                                      textColor: const Color(0xff5B58FF),
                                      buttonText: data.status,
                                      borderColor: const Color(0xffF4EFFD),
                                    ),
                                    tapBarButton2:  CustomTapBarButton(
                                      buttonColor: const Color(0xffFDEFEF),
                                      textColor: const Color(0xffE96161),
                                      buttonText: data.priority,
                                      borderColor: const Color(0xffFDEFEF),
                                    ),
                                    //startData: data?.dateRange,
                                    rightIconArrowColor:
                                    const Color(0xff00606F),
                                    projectName: data.title,
                                    usersImage: users,
                                    userCount: data.userCount,
                                    startData: data.dateRange,
                                    endDate: "",

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
                            SeeAllTitle(
                              titile: "task_in_progress",
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TaskListScreen()));
                              },
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            ///Tasklist
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.crmResponseData?.data?.tasks
                                        ?.data?.length ??
                                    0,
                                itemBuilder: (BuildContext context, index) {
                                  final data = provider.crmResponseData?.data
                                      ?.tasks?.data?[index];
                                  return TaskAssignCardWithDate(
                                    onTap: () {
                                      NavUtil.navigateScreen(
                                        context,
                                        NewTaskDetailsScreen(taskId: data!.id!
                                        ),
                                      );
                                    },
                                    taskName: data?.title,
                                    userCount: data?.usersCount,
                                    tapButtonColor: const Color(0xff5B58FF),
                                    taskStartDate: data?.dateRange,
                                    userData: data,
                                    //taskEndDate: "20 Aug",
                                  );
                                }),
                            SizedBox(
                              height: 02.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.white),
                              child: TableCalendar(
                                firstDay: DateTime.utc(2010, 10, 16),
                                lastDay: DateTime.utc(2030, 3, 14),
                                focusedDay: DateTime.now(),
                              ),
                            ),
                            SizedBox(
                              height: 100.h,
                            )
                          ],
                        )),
                  ) :
                  const HomeShimmerEffect()

                );
              }),
            ),
          );
        // }));
  }
}
