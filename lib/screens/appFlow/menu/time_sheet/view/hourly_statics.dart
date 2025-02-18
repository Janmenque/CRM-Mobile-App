import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/hourly_statics_search_container.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/hourly_statics_table.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/hourly_statistics_provider.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/screens/custom_widgets/table_shimmer_list.dart';
import 'package:provider/provider.dart';

class HourlyStaticsScreen extends StatelessWidget {

  const HourlyStaticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hourly Statics",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => HourlyStatisticsProvider(),
        child: Consumer<HourlyStatisticsProvider>(
          builder: (context, provider, _) {
            final data = provider.hourlyStaticsListResponse?.data;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HourlyStaticsSearchContainer(provider: provider),
                    provider.isLoading ? const TableShimmerList() :
                    data?.users?.isNotEmpty == true ?
                    HourlyStaticsTable(hourlyStaticsListResponse: provider.hourlyStaticsListResponse) :
                    const NoDataFoundWidget(),
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