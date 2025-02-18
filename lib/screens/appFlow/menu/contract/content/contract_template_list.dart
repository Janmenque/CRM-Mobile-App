
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hrm_app/data/model/crm_contract/crm_create_contract_component.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_template_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';

class ContractTemplateList extends StatelessWidget {
  int contractId;
  ContractTemplateList({super.key, required this.contractId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContractTemplateProvider>(
        builder: (context, provider, _) {
          final templates = provider.contractTemplateListResponse?.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductCreateAndSearchContent(
                    onTap: ()=> createContractTemplatesDialog(context, provider, contractId),
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
                            const Text("Contract Template", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text("Total : ${templates?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                          ],
                        ),
                        templates?.isNotEmpty == true ?
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: templates?.length ?? 0,
                            itemBuilder: (BuildContext context, int index){
                              final data = templates?[index];
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
                                               Text("Title: ${data?.title ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                                Row(
                                                  children: [
                                                    const Text("Status: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                                    Text(data?.status ?? "", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: data?.status == "Active" ? Colors.green : Colors.red),),
                                                  ],
                                                ),
                                                HtmlWidget(  'Content: ${data?.content ?? ""}',),
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
                                          ),],),],),
                              );}) : const NoDataFoundWidget(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }


  void createContractTemplatesDialog(BuildContext parentContext, ContractTemplateProvider provider, int contractId) {
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
                      'Add Template',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  content: Consumer<ContractTemplateProvider>(
                      builder: (_, provider, __) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              NewTextField(labelText: "Title", controller: provider.titleController,),
                              NewTextField(labelText: "Content", controller: provider.contentController,),
                              const SizedBox(height: 8,),
                              CustomDropdown<ContractComponent>(
                                value: provider.client,
                                labelText: 'Select Client',
                                items: provider.crmCreateContractComponentResponse?.data?.clients ?? [],
                                onChanged: (ContractComponent? newValue) {
                                  provider.selectClient(newValue!);
                                },
                                itemLabelBuilder: (ContractComponent value) => value.name ?? '',
                              ),
                              const SizedBox(height: 14,),
                              CustomDropdown<String>(
                                value: provider.status,
                                labelText: 'Select Status',
                                items: provider.statusList ?? [],
                                onChanged: (String? newValue) {
                                  provider.selectStatus(newValue!);
                                },
                                itemLabelBuilder: (String value) => value ?? '',
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      provider.addContractTemplate(context, contractId);
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
