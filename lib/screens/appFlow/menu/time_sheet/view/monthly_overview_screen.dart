import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/monthly_overview_seach_container.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/monthly_overview_table.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/monthly_overview_provider.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';
import '../../../../custom_widgets/table_shimmer_list.dart';

class MonthlyOverviewScreen extends StatelessWidget {
  const MonthlyOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MonthlyOverviewProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Monthly Overview", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Consumer<MonthlyOverviewProvider>(
            builder: (context, provider, child) {
              final data = provider.monthlyOverviewResponse?.data;
              final days = data?.monthDates ?? [];
              final timesheetData = data?.timesheetData ?? [];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    MonthlyOverviewSearchContainer(provider: provider),
                    provider.isLoading ? const TableShimmerList() :
                    provider.monthlyOverviewResponse?.data?.monthDates?.isNotEmpty == true ?
                    MonthlyOverviewTable(days: days, timesheetData: timesheetData, data: data) : const NoDataFoundWidget(),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}