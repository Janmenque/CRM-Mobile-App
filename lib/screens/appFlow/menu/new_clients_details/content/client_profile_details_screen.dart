import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/add_biller_country_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/profile_address_type_details.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_profile_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class ClientProfileDetailsScreen extends StatelessWidget {
  int clientId;
  ClientProfileDetailsScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientProfileProvider>(
      builder: (context, provider, _) {
        final data = provider.clientProfileDetailsResponse?.data;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:
                  provider.isLoading ? const CustomListShimer() :
                  Row(
                    children: [
                      const Expanded(
                        flex : 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Group", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Name", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Email", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Phone", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Address", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("City", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("State", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Zip", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Country", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Website", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Lead Status : ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Date Created", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                         ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(": ${data?.group?.name ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(": ${data?.profile?.name ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(": ${data?.profile?.email ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(": ${data?.profile?.phone ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(": ${data?.profile?.address ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(": ${data?.profile?.city ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(": ${data?.profile?.state ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(": ${data?.profile?.zip ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(": ${data?.country?.name ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(": ${data?.profile?.website ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(": ${data?.status?.name ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            Text(": ${data?.profile?.date ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14,),
                data?.billingAddress != null || data?.shippingAddress != null ?
                ProfileAddressTypeDetails(profileData: data)
                 : const SizedBox(),
                const SizedBox(height: 14,),
                //data?.billingAddress == null || data?.shippingAddress == null ?
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: ()=> createClientAddress(context, provider, "Billing", clientId ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          decoration: BoxDecoration(
                            color: AppColors.colorPrimary,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text(
                            data?.billingAddress != null ?
                            "Update Billing Address" : "Add Billing Address",
                            textAlign: TextAlign.center,  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: InkWell(
                        onTap: ()=> createClientAddress(context, provider, "Shipping", clientId),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          decoration: BoxDecoration(
                              color: AppColors.colorPrimary,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text(
                            data?.shippingAddress != null ?
                            "Update Shipping Address" : "Add Shipping Address",
                            textAlign: TextAlign.center,  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ],
                ) ,
                //: SizedBox(),
              ],
            ),
          ),
        );
      }
    );
  }


  void createClientAddress(BuildContext parentContext, ClientProfileProvider provider, String addressType, int clientId) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        //final provider = Provider.of<LeadCallProvider>(context, listen: true);
        return ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
              builder: (context) {
                return AlertDialog(
                  content: Consumer<ClientProfileProvider>(
                      builder: (_, provider, __) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(height: 5,),
                              Text("Add $addressType address", style: const TextStyle(fontWeight: FontWeight.bold),),
                              NewTextField( labelText: "Street", controller: provider.streetController,),
                              NewTextField( labelText: "City", controller: provider.cityController,),
                              NewTextField( labelText: "State", controller: provider.stateController,),
                              NewTextField( labelText: "Zip", controller: provider.zipController,),
                              const SizedBox(height: 8),
                              CustomDropdown<Country>(
                                value: provider.clientCountry,
                                labelText: 'Country',
                                items: provider.countryListResponse?.data ?? [],
                                onChanged: (Country? newValue) {
                                  provider.selectClientCountry(newValue!);
                                },
                                itemLabelBuilder: (Country value) => value.name ?? '',
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      // Form and Image Validation
                                      if (provider.streetController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Street is required."),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else if (provider.cityController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("City is required."),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else if (provider.stateController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("State is required."),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else if (provider.zipController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Zip is required."),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                      else {
                                        provider.createAddressType(context, clientId, addressType);
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