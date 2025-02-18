import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/allocate_resource_provider.dart';


class ResourcePlanMultiselectEmployeeList extends StatelessWidget {
  AllocateResourceProvider? provider;
  ResourcePlanMultiselectEmployeeList({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              showEmployeeMultiSelectDialog(context, provider?.timesheetRelatedResponse?.data?.employees ?? [], provider);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Employee',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
        const SizedBox( height: 6,),
        provider?.selectedEmployeeList.isNotEmpty == true ?
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            "Selected Employee list:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ) : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            provider!.selectedEmployeeList.map((e) => e.name).join(", "),
          ),
        ),
      ],
    );
  }

  void showEmployeeMultiSelectDialog(BuildContext context, List<TimesheetEmployee>? items, AllocateResourceProvider? provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text("Select Employee") ,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView(
                  children: items!.map((employee) {
                    return CheckboxListTile(
                      title: Text(employee.name!),
                      value: provider?.selectedEmployeeList.any((selected) => selected.id == employee.id),
                      onChanged: (bool? value) {
                        provider?.toggleEmployee(employee);
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

}
