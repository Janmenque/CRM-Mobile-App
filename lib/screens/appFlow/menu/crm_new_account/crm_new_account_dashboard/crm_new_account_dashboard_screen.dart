import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/crm_new_account/provider/rm_new_account_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/screens/custom_widgets/dashboard.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/connectivity/no_internet_screen.dart';
import '../../../../../live_traking/location_provider.dart';

class CrmNewAccountDashboard extends StatelessWidget {
  const CrmNewAccountDashboard({super.key});

  @override
  Widget build(BuildContext context) {
      return ChangeNotifierProvider(
        create: (context) => LocationProvider(),
        child:
            Consumer<LocationProvider>(builder: (context, locationProvider, _) {
          return NoInternetScreen(
            child: ChangeNotifierProvider(
              create: (context) => CrmNewAccountProvider(context, locationProvider),
              child:
                  Consumer<CrmNewAccountProvider>(builder: (context, provider, _) {
                return Scaffold(
                  backgroundColor: const Color(0xffF5F6FA),
                  appBar: const PreferredSize(
                    preferredSize: Size.fromHeight(70),
                    child: CustomTitleAppBar(
                      title: "Accounts",
                    ),
                  ),
                  body: SingleChildScrollView(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.h, horizontal: 17.w),
                    child: Column(
                      children: [
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.crmNewAccountDashboardResponse
                                      ?.data?.staticstics?.length ??
                                  0,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 140,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 4.0),
                              itemBuilder: (BuildContext context, int index) {
                                final data = provider.crmNewAccountDashboardResponse
                                    ?.data?.staticstics?[index];
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
                      ],
                    ),
                  )),
                );
                
              }),
            ),
          );
        }));
  }
}