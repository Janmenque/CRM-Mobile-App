import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/schedule_overview_search_container.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/schedule_overview_table.dart';
import 'package:provider/provider.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/schedule_overview_provider.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/screens/custom_widgets/table_shimmer_list.dart';

class ScheduleOverviewScreen extends StatelessWidget {
  const ScheduleOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Schedule Overview",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ScheduleOverProvider(),
        child: Consumer<ScheduleOverProvider>(
          builder: (context, provider, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ScheduleOverviewSearchContainer(provider: provider),
                    const SizedBox(height: 12),
                    provider.isLoading ? const TableShimmerList() :
                        provider.scheduleOverviewResponse?.data?.timesheets?.isNotEmpty == true ?
                        ScheduleOverviewTable(provider: provider) :  const NoDataFoundWidget(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}