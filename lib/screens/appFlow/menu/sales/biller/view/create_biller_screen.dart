import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/add_biller_country_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/biller/provider/create_biller_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:provider/provider.dart';

class AddBillerScreen extends StatelessWidget {
  const AddBillerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("Add Biller", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CreateBillerProvider(),
        child: Consumer<CreateBillerProvider>(
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
                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.billerNameController, labelText: "Name",),
                      const SizedBox(height: 8,),
                      ///upload images
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: ()=> provider.pickImage(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                      border: Border.all(color: Colors.grey, width: 1)
                                  ),
                                  child: const Text("Attach Document", style: TextStyle(color: Colors.grey),),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  border: Border.all(color: Colors.grey, width: 1)
                              ),
                              child: const Text("Browse", style: TextStyle(color: Colors.grey),),
                            ),
                          ],
                        ),
                      ),
                      provider.imagePath != null ?
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 10),
                        child: Image.file(
                          provider.imagePath!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ) : const SizedBox(),

                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.companyNameController, labelText: "Company Name",),

                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.vatNumberController, labelText: "Vat Name",),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(child: NewTextField(controller: provider.emailController, labelText: "Email",)),
                          const SizedBox(width: 8,),
                          Expanded(child: NewTextField(controller: provider.phoneNumberController, labelText: "Phone Number",)),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.addressController,labelText: "Address",),
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
                      const SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        child: ElevatedButton(
                            onPressed: () {
                              provider.addBiller(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              "Add Biller",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))),
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