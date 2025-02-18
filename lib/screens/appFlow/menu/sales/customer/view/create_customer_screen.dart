import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/add_biller_country_list_model.dart';
import 'package:hrm_app/data/model/crm_sales/customer_group_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/customer/provider/create_customer_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:provider/provider.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("Add Customer", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => AddCustomerProvider(),
        child: Consumer<AddCustomerProvider>(
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
                          Checkbox(
                            value: provider.isBothCustomerAndSupplier,
                            onChanged: (bool? value) =>  provider.toggleCustomerAndSupplier(value!),
                            side: const BorderSide(color: Colors.grey, width: 1),
                          ),
                          const Expanded(
                            child:  Text("Both Customer and Supplier", style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      CustomDropdown<CustomerGroup>(
                        value: provider.customerGroup,
                        labelText: 'Select Customer Group',
                        items: provider.customerGroupListResponse?.data ?? [],
                        onChanged: (CustomerGroup? newValue) {
                          provider.selectCustomerGroup(newValue!);
                        },
                        itemLabelBuilder: (CustomerGroup value) => value.name ?? '',
                      ),
                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.customerNameController, labelText: "Customer Name",),
                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.companyNameController, labelText: "Company Name",),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(child: NewTextField( controller: provider.emailController, labelText: "Email",)),
                          const SizedBox(width: 8,),
                          Expanded(child: NewTextField(controller: provider.phoneController, labelText: "Phone Number",)),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.taxController, labelText: "Tax Number",),
                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.addressController, labelText: "Address",),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(child: NewTextField(controller: provider.cityController, labelText: "City",)),
                          const SizedBox(width: 8,),
                          Expanded(child: NewTextField(controller: provider.stateController, labelText: "State",)),
                        ],
                      ),

                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(child: NewTextField(controller: provider.postalCodeController, labelText: "Postal Code",)),
                          const SizedBox(width: 8,),
                          Expanded(child:  CustomDropdown<Country>(
                            value: provider.country,
                            labelText: 'Select Country',
                            items: provider.countryListResponse?.data ?? [],
                            onChanged: (Country? newValue) {
                              provider.selectCountry(newValue!);
                            },
                            itemLabelBuilder: (Country value) => value.name ?? '',
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: provider.isAddUser,
                            onChanged: (bool? value) =>  provider.toggleAddUser(value!),
                            side: const BorderSide(color: Colors.grey, width: 1),
                          ),
                          const Expanded(
                            child:  Text("Add USer", style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),

                      provider.isAddUser == true ?
                      Row(
                        children: [
                          Expanded(child: NewTextField(controller: provider.userNameController, labelText: "Name",)),
                          const SizedBox(width: 8,),
                          Expanded(child: NewTextField(controller: provider.userPasswordController, labelText: "Password",)),
                        ],
                      ) : const SizedBox(),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        child: ElevatedButton(
                            onPressed: () {
                              provider.addCustomer(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              "Add Customer",
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