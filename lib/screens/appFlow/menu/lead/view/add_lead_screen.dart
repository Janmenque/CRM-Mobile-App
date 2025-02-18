import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/add_biller_country_list_model.dart';
import 'package:hrm_app/data/model/lead/add_lead_all_component_model.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/add_lead_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:provider/provider.dart';

class AddLeadScreen extends StatelessWidget {
  const AddLeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("Add Lead", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => AddLeadProvider(),
        child: Consumer<AddLeadProvider>(
            builder: (context, provider, _) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric( horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdown<LeadComponent>(
                              value: provider.leadType,
                              labelText: 'Lead Type',
                              items: provider.addLeadAllComponentResponse?.data?.leadTypes ?? [],
                              onChanged: (LeadComponent? newValue) {
                                provider.selectLeadType(newValue!);
                              },
                              itemLabelBuilder: (LeadComponent value) => value.title ?? '',
                            ),
                          ),
                          Expanded(
                            child: CustomDropdown<LeadComponent>(
                              value: provider.leadZone,
                              labelText: 'Lead Zone',
                              items: provider.addLeadAllComponentResponse?.data?.leadZone ?? [],
                              onChanged: (LeadComponent? newValue) {
                                provider.selectLeadZone(newValue!);
                              },
                              itemLabelBuilder: (LeadComponent value) => value.title ?? '',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      CustomDropdown<LeadComponent>(
                        value: provider.leadStatus,
                        labelText: 'Lead Status',
                        items: provider.addLeadAllComponentResponse?.data?.leadStatus ?? [],
                        onChanged: (LeadComponent? newValue) {
                          provider.selectLeadStatus(newValue!);
                        },
                        itemLabelBuilder: (LeadComponent value) => value.title ?? '',
                      ),
                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.leadNameController, labelText: "Name",),
                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.leadTitleController, labelText: "Title",),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(child: NewTextField(controller: provider.leadCityController, labelText: "City",)),
                          Expanded(child: NewTextField(controller: provider.leadZipCodeController, labelText: "Zip Code",)),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(child: NewTextField(controller: provider.leadEmailController, labelText: "Email",)),
                          Expanded(child: NewTextField(controller: provider.leadStateController, labelText: "State",)),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(child: NewTextField( controller: provider.leadWebsiteController, labelText: "Website",)),
                          Expanded(
                            child: CustomDropdown<Country>(
                              value: provider.country,
                              labelText: 'Country',
                              items: provider.countryListResponse?.data ?? [],
                              onChanged: (Country? newValue) {
                                provider.selectCountry(newValue!);
                              },
                              itemLabelBuilder: (Country value) => value.name ?? '',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(child: NewTextField(controller: provider.leadPhoneController, labelText: "Phone",)),
                          Expanded(child: NewTextField(controller: provider.leadAddressController, labelText: "Address",)),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.leadDescriptionController, labelText: "Description ", maxLine: 4,),
                      const SizedBox(height: 8,),
                      InkWell(
                      onTap: () => provider.selectDate(context),
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
                            Text( provider.monthYear ??  "Next Followup",style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                            const Icon(Icons.calendar_month_outlined, color: Colors.grey,)
                          ],
                        ),
                      ),),
                      const SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        child: ElevatedButton(
                            onPressed: () {
                              provider.createLead(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              "Add Lead",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
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