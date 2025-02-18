import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_contract/crm_create_contract_component.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/add_contract_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:provider/provider.dart';

class AddContract extends StatelessWidget {

  const AddContract({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (_) => AddContractProvider(),
      child: Consumer<AddContractProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Add Contract", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric( horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8,),
                      CustomDropdown<ContractComponent>(
                        value: provider.client,
                        labelText: 'Client Name',
                        items: provider.crmCreateContractComponentResponse?.data?.clients ?? [],
                        onChanged: (ContractComponent? newValue) {
                          provider.selectClient(newValue!);
                        },
                        itemLabelBuilder: (ContractComponent value) => value.name ?? '',
                      ),
                      const SizedBox(height: 8,),
                      NewTextField(labelText: "Subject", controller: provider.subjectController,),
                      const SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Contract Amount',
                              style: TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Service based',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Transform.scale(
                                  scale: 0.5,
                                  child: SizedBox(
                                    height: 20,
                                    child: Switch(
                                      value: provider.isServiceBased,
                                      onChanged: (value) {
                                        provider.toggleServiceBased();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14,),
                      provider.isServiceBased ?
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
                      ) :
                      NewTextField(labelText: "Contract Amount", controller: provider.contractAmountController,),
                      const SizedBox(height: 14,),
                      CustomDropdown<ContractComponent>(
                        value: provider.contractType,
                        labelText: 'Contract Type',
                        items: provider.crmCreateContractComponentResponse?.data?.contractType ?? [],
                        onChanged: (ContractComponent? newValue) {
                          provider.selectContractType(newValue!);
                        },
                        itemLabelBuilder: (ContractComponent value) => value.name ?? '',
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => provider.selectStartDate(context),
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
                                    Text( provider.startDate ??  "Start Date",style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                                    const Icon(Icons.calendar_month_outlined, color: Colors.grey,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => provider.selectEndDate(context),
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
                                    Text( provider.endDate ??  "End Date",style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                                    const Icon(Icons.calendar_month_outlined, color: Colors.grey,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      NewTextField(labelText: "Description", maxLine: 3, controller: provider.contractDescriptionController,),
                      const SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        child: ElevatedButton(
                            onPressed: () {
                              provider.addContract(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              "Add Contract",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          );
        }
      ),
    );
  }

  void showServiceMultiSelectDialog(BuildContext context, List<ContractComponent> items, AddContractProvider provider) {
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
