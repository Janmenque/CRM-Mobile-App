import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/income/income_dashboard/components/history_card.dart';
import 'package:hrm_app/screens/appFlow/menu/income/income_dashboard/components/income_earning_fl_chart.dart';
import 'package:hrm_app/screens/appFlow/menu/income/income_dashboard/transactions_list.dart';
import 'package:hrm_app/screens/appFlow/menu/income/provider/income_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/screens/custom_widgets/dashboard.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/connectivity/no_internet_screen.dart';
import '../../../../../live_traking/location_provider.dart';

class IncomeDashboardScreen extends StatelessWidget {
  const IncomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocationProvider(),
        child:
            Consumer<LocationProvider>(builder: (context, locationProvider, _) {
          return NoInternetScreen(
            child: ChangeNotifierProvider(
              create: (context) => CrmIncomeProvider(context, locationProvider),
              child:
                  Consumer<CrmIncomeProvider>(builder: (context, provider, _) {
                return Scaffold(
                  backgroundColor: const Color(0xffF5F6FA),
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(56.h),
                    child: const CustomTitleAppBar(
                      title: "Income",
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
                            itemCount: provider.crmIncomeDashboardResponse?.data
                                    ?.staticstics?.length ??
                                0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 140,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0),
                            itemBuilder: (BuildContext context, int index) {
                              final data = provider.crmIncomeDashboardResponse
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
                        SizedBox(
                          height: 22.h,
                        ),
                        const IncomeEarningWidget(),
                        Card(
                          elevation: 0,
                          child: Container(
                            width: double.infinity,
                            height: 264.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Transactions history",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const TransactionsList(),
                                    ));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const HistoryCard(
                          image: 'assets/stocks/upwork.png',
                          title: "Upwork",
                          amount: "+ \$ 850.00",
                          color: Color(0xff25A969),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const HistoryCard(
                          image: 'assets/stocks/paypal.png',
                          title: "Paypal",
                          amount: "+ \$ 1150.00",
                          color: Color(0xffF95B51),
                        ),
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
