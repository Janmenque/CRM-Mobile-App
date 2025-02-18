import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/timesheet_report_serach_container.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/timesheet_report_table.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/timesheet_report_provider.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/screens/custom_widgets/table_shimmer_list.dart';
import 'package:provider/provider.dart';

class TimesheetReportScreen extends StatelessWidget {
  const TimesheetReportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timesheet Report", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ChangeNotifierProvider(
        create: (_) => TimesheetReportProvider(),
        child: Consumer<TimesheetReportProvider>(
          builder: (context, provider, _) {
            final data = provider.timesheetReportListResponse?.data ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TimesheetReportSearchContainer(provider: provider),
                    provider.isLoading ? const TableShimmerList() :
                    data.isNotEmpty == true ?
                    TimesheetReportTable(data: data) : const NoDataFoundWidget(),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}