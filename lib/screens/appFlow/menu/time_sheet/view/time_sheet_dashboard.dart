import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/sales_dashboard/content/sales_dashboard_card.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/approve_hours_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/hourly_statistics_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/monthly_overview_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/schedule_overview_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/timesheet_overview_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/view/approve_hours.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/view/hourly_statics.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/view/monthly_overview_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/view/resource_plan_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/view/schedule_overview.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/view/time_sheet_overview_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/view/timesheet_report.dart';
import 'package:provider/provider.dart';


class TimeSheetDashboardScreen extends StatelessWidget {
  const TimeSheetDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimeSheetOverviewProvider()),
        ChangeNotifierProvider(create: (_) => MonthlyOverviewProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleOverProvider()),
        ChangeNotifierProvider(create: (_) => ApproveHoursProvider()),
        ChangeNotifierProvider(create: (_) => HourlyStatisticsProvider()),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: const Text("TimeSheet Dashboard", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
              children: [
                SalesDashboardCard(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => TimeSheetOverviewScreen())),
                  title: 'Timesheet', image: "assets/images/product.png",),
                SalesDashboardCard(
                    onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) =>  MonthlyOverviewScreen())),
                    title: 'Monthly\nOverview', image: "assets/images/adjustment.png"),
                SalesDashboardCard(
                    onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) =>  ScheduleOverviewScreen())),
                    title: 'Schedule\nOverview', image: "assets/images/stock.png"),
                SalesDashboardCard(
                    onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => ApproveHoursScreen())),
                    title: 'Approve\nHours', image: "assets/images/purchase.png"),
                SalesDashboardCard(
                    onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) =>  HourlyStaticsScreen())),
                    title: 'Hourly\nStatistics', image: "assets/images/quotation.png"),
                SalesDashboardCard(
                    onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) =>  ResourcePlanScreen())),
                    title: 'Resource\nPlan', image: "assets/images/biller.png"),
                SalesDashboardCard(
                    onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => TimesheetReportScreen())),
                    title: 'Timesheet\nReport', image: "assets/images/customer.png"),
              ]),
        ),
      ),
    );
  }
}