import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_reminder_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';


class LeadReminderListScreen extends StatelessWidget {
  int leadId;
  LeadReminderListScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadReminderProvider>(
      builder: (context, provider, _) {
        final leadReminders = provider.leadReminderListResponse?.data;
        return SingleChildScrollView(
            child:  Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Reminders", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      InkWell(
                        onTap: ()=> addReminderDialog(context, provider),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8)),
                          child: const Row(
                            children: [
                              Icon(Icons.add, size: 14, color: Colors.white,),
                              Text("Create", style: TextStyle(color: Colors.white, fontSize: 12),)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  leadReminders?.length != 0 ?
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: leadReminders?.length ?? 0,
                      itemBuilder: (BuildContext context, int index){
                        final data = leadReminders?[index];
                        return InkWell(
                          onTap: (){},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 14,),
                              Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                              const SizedBox(height: 14,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Subject: ${data?.subject ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Message: ${data?.message ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Row(
                                          children: [
                                            const Text("Status: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                            Text(data?.status ?? "N/A", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryColor),),
                                          ],
                                        ),
                                        Text("Author: ${data?.author ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Date : ${data?.date ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                      ],
                                    ),
                                  ),],),],),
                        );}) : const NoDataFoundWidget(),
                ],
              ),
            )
        );
      }
    );
  }

  void addReminderDialog(BuildContext parentContext, LeadReminderProvider provider) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) {
              return AlertDialog(
                title: const Center(
                  child: Text(
                    'Add Reminder',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                content: Consumer<LeadReminderProvider>(
                  builder: (_, provider, __) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          NewTextField( labelText: "Subject", controller: provider.reminderSubjectController,),
                          NewTextField( labelText: "Message", maxLine: 3, controller: provider.reminderMessageController,),
                          CustomDropdown<String>(
                            value: provider.reminderStatus,
                            labelText: 'Status',
                            items: provider.reminderStatusList ?? [],
                            onChanged: (String? newValue) {
                              provider.selectReminderStatus(newValue!);
                            },
                            itemLabelBuilder: (String? value) => value ?? '',
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  // Form and Image Validation
                                  if (provider.reminderSubjectController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Subject is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (provider.reminderMessageController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Note is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    provider.createReminder(context, leadId);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff5B58FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: const Text(
                                  "Create",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      ),
                    );
                  }
                ),
              );
            }
          ),
        );
      },
    );
  }
}
