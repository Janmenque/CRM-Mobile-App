import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/create_resource_plan_widget.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/resource_plan_table.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/resource_plan_provider.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/screens/custom_widgets/table_shimmer_list.dart';
import 'package:provider/provider.dart';

class ResourcePlanScreen extends StatelessWidget {
  const ResourcePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Resource Plan",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ResourcePlanProvider(),
        child: Consumer<ResourcePlanProvider>(
          builder: (context, provider, _) {
            final data = provider.resourcePlanListResponse?.data ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                  CreateResourcePlanWidget(),
                  provider.isLoading ?  const TableShimmerList() :
                  data.isNotEmpty == true ?
                  ResourcePlanTable(data: data) : const NoDataFoundWidget(),
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
