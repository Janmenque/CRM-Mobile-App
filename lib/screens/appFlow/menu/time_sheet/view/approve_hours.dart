import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/approve_hour_search_container.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/approve_hour_table.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/approve_hours_provider.dart';
import 'package:provider/provider.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/screens/custom_widgets/table_shimmer_list.dart';

class ApproveHoursScreen extends StatelessWidget {
  const ApproveHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Approve Hours", style: TextStyle(fontWeight: FontWeight.bold),),),
      body: ChangeNotifierProvider(
        create: (_) => ApproveHoursProvider(),
        child: Consumer<ApproveHoursProvider>(
          builder: (context, provider, _) {
            final data = provider.approveHourListResponse?.data ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ApproveHoursSearchContainer(provider: provider),
                    provider.isLoading ? const TableShimmerList() :
                    data.isNotEmpty == true ?
                    ApproveHourTable(provider: provider) :  const NoDataFoundWidget(),
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