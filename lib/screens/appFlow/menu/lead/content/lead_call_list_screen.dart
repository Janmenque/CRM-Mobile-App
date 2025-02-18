import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_call_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/empty_message.dart';
import 'package:provider/provider.dart';


class LeadCallListScreen extends StatelessWidget {
  int leadId;
  LeadCallListScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadCallProvider>(
      builder: (context, provider, _) {
        final leadCalls = provider.leadCallListResponse?.data;
        return SingleChildScrollView(
            child:  Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Calls", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      InkWell(
                        onTap: ()=> createCallDialog(context, provider),
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
                ),
                Container(
                  padding: const EdgeInsets.symmetric( vertical: 16, horizontal: 12),
                  margin: const EdgeInsets.symmetric( horizontal: 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: leadCalls?.length != 0 ?
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: leadCalls?.length ?? 0,
                      itemBuilder: (BuildContext context, int index){
                        final data = leadCalls?[index];
                        return InkWell(
                          onTap: (){},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Call Date: ${data?.callDate ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Subject: ${data?.subject ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Number: ${data?.number ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Type: ${data?.callType ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Duration: ${data?.duration ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Message: ${data?.message ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Author: ${data?.author ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                        Text("Date: ${data?.date ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: PopupMenuButton(
                                      iconSize: 18,
                                      icon: const Icon(Icons.more_vert_rounded, color: Colors.grey,),
                                      onSelected: (value) {},
                                      itemBuilder: (BuildContext context) => [],
                                    ),
                                  ),],),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 14),
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                color: Colors.grey.withOpacity(0.4),
                              ),
                            ],),
                        );}) : const EmptyMessageWidget(),
                ),
              ],
            )
        );
      }
    );
  }

  void createCallDialog(BuildContext parentContext, LeadCallProvider provider) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) {
              return AlertDialog(
                content: Consumer<LeadCallProvider>(
                  builder: (_, provider, __) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          InkWell(
                            onTap: () => provider.selectDate(parentContext),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                              margin: const EdgeInsets.symmetric( horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey, width: 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text( provider.monthYear ??  "Select Date",style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                                  const Icon(Icons.calendar_month_outlined, color: Colors.grey,)
                                ],
                              ),
                            ),),
                          NewTextField( labelText: "Number", controller: provider.numberController,),
                          NewTextField( labelText: "Duration (minute)", controller: provider.durationController,),
                          const SizedBox(height: 8),
                          CustomDropdown<String>(
                            value: provider.callType,
                            labelText: 'Status',
                            items: provider.callTypeList,
                            onChanged: (String? newValue) {
                              provider.selectCallType(newValue!);
                            },
                            itemLabelBuilder: (String value) => value ?? '',
                          ),
                          const SizedBox(height: 8),
                          NewTextField( labelText: "Subject", controller: provider.subjectController,),
                          NewTextField( labelText: "Message", maxLine: 3, controller: provider.messageController,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (provider.monthYear == "") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Date is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (provider.numberController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Number is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (provider.subjectController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("subject is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (provider.messageController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("message is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  else {
                                    provider.createCall(context, leadId);
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
