import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_tag_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';

class LeadTagListScreen extends StatelessWidget {
  int leadId;
  LeadTagListScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadTagProvider>(
      builder: (context, provider, _) {
        final leadTags = provider.leadTagListResponse?.data;
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
                      const Text("Tags", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      InkWell(
                        onTap: ()=> addTagDialog(context, provider ),
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
                  provider.isLoading == true ? const CustomListShimer() :
                  leadTags?.isNotEmpty == true ?
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: leadTags?.length,
                      itemBuilder: (BuildContext context, int index){
                        final data = leadTags?[index];
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Name: ${data?.name ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                      Text("Author: ${data?.author ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                      Text("Date : ${data?.date ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),

                                    ],
                                  ),],),],),
                        );}) : const NoDataFoundWidget(),
                ],
              ),
            )
        );
      }
    );
  }

  void addTagDialog(BuildContext parentContext, LeadTagProvider provider) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) {
              return Consumer<LeadTagProvider>(
                builder: (_,provider,__) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          NewTextField( labelText: "Name", controller: provider.tagNameController,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  // Form and Image Validation
                                  if (provider.tagNameController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("name is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    provider.createTag(context, leadId);
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
                    ),
                  );
                }
              );
            }
          ),
        );
      },
    );
  }
}
