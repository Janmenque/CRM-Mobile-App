import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_contract/crm_create_contract_component.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_item_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';

class ContractItemListScreen extends StatelessWidget {
  int contractId;
  ContractItemListScreen({super.key, required this.contractId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContractItemProvider>(
        builder: (context, provider, _) {
          final items = provider.contractItemListResponse?.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductCreateAndSearchContent(
                        onTap: ()=> createContractItemDialog(context, provider, contractId),
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
                            const Text("Contract Item", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text("Total : ${items?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 14,),
                        Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                        items?.isNotEmpty == true ?
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items?.length ?? 0,
                            itemBuilder: (BuildContext context, int index){
                              final data = items?[index];
                              return InkWell(
                                onTap: (){},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 14,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("service name: ${data?.serviceName ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                            Text("Created: ${data?.created ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                          ],
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

  void createContractItemDialog(BuildContext parentContext, ContractItemProvider provider, int contractId) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        //final provider = Provider.of<LeadCallProvider>(context, listen: true);
        return ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
              builder: (context) {
                return AlertDialog(
                  title: const Center(
                    child: Text(
                      'Add Item',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  content: Consumer<ContractItemProvider>(
                      builder: (_, provider, __) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showServiceMultiSelectDialog(context, provider.crmCreateContractComponentResponse?.data?.services ?? [], provider);
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
                                              'Select Services',
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                            Icon(Icons.arrow_drop_down),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox( height: 6,),
                                  provider.selectedServices.isNotEmpty ?
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                                    child: Text(
                                      "Selected Services:",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ) : const SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                    child: Text(
                                      provider.selectedServices.map((e) => e.name).join(", "),
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      provider.addItem(context, contractId);
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


  void showServiceMultiSelectDialog(BuildContext context, List<ContractComponent> items, ContractItemProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text("Select Services") ,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView(
                  children: items.map((service) {
                    return CheckboxListTile(
                      title: Text(service.name!),
                      value: provider.selectedServices.any((selected) => selected.id == service.id),
                      onChanged: (bool? value) {
                        provider.toggleService(service);
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

