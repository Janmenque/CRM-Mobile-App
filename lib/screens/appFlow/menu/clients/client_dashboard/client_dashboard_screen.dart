import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/add_client/add_client_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/client_list/client_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/provider/client_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/widgets/client_list_card.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/screen/new_client_details_screen.dart';
import 'package:hrm_app/screens/custom_widgets/dashboard.dart';
import 'package:hrm_app/screens/custom_widgets/dashboard_shimer_effect.dart';
import 'package:hrm_app/screens/custom_widgets/see_all_title.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/connectivity/no_internet_screen.dart';

class ClientDashboard extends StatelessWidget {
  const ClientDashboard({super.key});
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
                          ])),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                Text(
                  title.tr(),
                  style: TextStyle(color: Colors.grey[600]),
                )
              ]),
          const Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => CrmClientProvider(context),
        child: Consumer<CrmClientProvider>(builder: (context, provider, _) {
          return Scaffold(
              backgroundColor: const Color(0xffF5F6FA),
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  "Clients",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ).tr(),
                actions: [
                  Visibility(
                    visible: provider.isAdmian ?? false,
                    child: PopupMenuButton(
                      onSelected: (value) {
                        menuItemRoute(value, context);
                      },
                      itemBuilder: (BuildContext context) => [
                        _buildPopupMenuItem('add_client'),
                      ],
                    ),
                  )
                ],
              ),
              body: provider.crmClientDashboardResponse?.data != null
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 24.h, horizontal: 17.w),
                        child: Column(
                          children: [
                            GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.crmClientDashboardResponse
                                        ?.data?.staticstics?.length ??
                                    0,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 140,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0),
                                itemBuilder: (BuildContext context, int index) {
                                  final data = provider
                                      .crmClientDashboardResponse
                                      ?.data
                                      ?.staticstics?[index];
                                  return DashboardCard(
                                    backgroundImage: data!.image!,
                                    title: data.text ?? "",
                                    amount: data.count ?? "",
                                    amountTop: 35.0.h,
                                    amountRight: 15.0.w,
                                    titleTop: 58.0.h,
                                    titleRight: 20.0.w,
                                  );
                                }),

                            ///list title
                            SeeAllTitle(
                              titile: "Clients",
                              ontap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientListScreen()),);
                              },
                            ),
                            SizedBox(height: 2.h),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.crmClientDashboardResponse?.data?.clients?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  final data = provider.crmClientDashboardResponse?.data?.clients?[index];
                                  return ClientListCard(
                                    ontap: () {
                                      NavUtil.navigateScreen(context, NewClientDetailsScreen(clientId: data!.id!));
                                    },
                                    name: data?.name,
                                    email: data?.email,
                                    profileImage: data?.avater,
                                    number: data?.phone,
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
  }


  menuItemRoute(value, context) {
    switch (value) {
      case "add_client":
        return NavUtil.navigateScreen(context, AddClientScreen());

      default:
        if (kDebugMode) {
          print('value miss math');
        }
    }
  }
}
