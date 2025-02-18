import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/service/service_create_compoment_model.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/service/provider/add_service_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:provider/provider.dart';
import 'package:simple_textfield_tag/simple_textfield_tag.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("Add Service", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => AddServiceProvider(),
        child: Consumer<AddServiceProvider>(
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
                      NewTextField(controller: provider.serviceNameController, labelText: "Service Name",),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdown<ServiceCategory>(
                              value: provider.category,
                              labelText: 'Category',
                              items: provider.serviceCreateComponentResponse?.data?.categories ?? [],
                              onChanged: (ServiceCategory? newValue) {
                                provider.selectCategory(newValue!);
                              },
                              itemLabelBuilder: (ServiceCategory value) => value.name ?? '',
                            ),
                          ),
                          Expanded(
                            child: CustomDropdown<ServiceSubCategory>(
                              value: provider.subCategory,
                              labelText: 'Sub Category',
                              items: provider.subCategories ?? [],
                              onChanged: (ServiceSubCategory? newValue) {
                                provider.selectSubCategory(newValue!);
                              },
                              itemLabelBuilder: (ServiceSubCategory value) => value.name ?? '',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(child: NewTextField(controller: provider.serviceTaxPercentageController, labelText: "Tax Percentage",)),
                          Expanded(child: NewTextField(controller: provider.minimumBiddingPriceController, labelText: "Min Bidding Price",)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: ()=> provider.pickThumbnailImage(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                      border: Border.all(color: Colors.grey, width: 1)
                                  ),
                                  child: const Text("Thumbnail Image", style: TextStyle(color: Colors.grey),),
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
                      provider.thumbnailImagePath != null ?
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 10),
                        child: Image.file(
                          provider.thumbnailImagePath!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ) : const SizedBox(),
                      const SizedBox(height: 14,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: ()=> provider.pickCoverImage(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                      border: Border.all(color: Colors.grey, width: 1)
                                  ),
                                  child: const Text("Cover Image", style: TextStyle(color: Colors.grey),),
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
                      provider.coverImagePath != null ?
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 10),
                        child: Image.file(
                          provider.coverImagePath!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ) : const SizedBox(),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdown<Zone>(
                              value: provider.zone,
                              labelText: 'Zone',
                              items: provider.serviceCreateComponentResponse?.data?.zone ?? [],
                              onChanged: (Zone? newValue) {
                                provider.selectZone(newValue!);
                              },
                              itemLabelBuilder: (Zone value) => value.name ?? '',
                            ),
                          ),
                          Expanded(
                            child: CustomDropdown<String>(
                              value: provider.status,
                              labelText: 'Status',
                              items: provider.statusList,
                              onChanged: (String? newValue) {
                                provider.selectStatus(newValue!);
                              },
                              itemLabelBuilder: (String value) => value ?? '',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      SimpleTextFieldTag(
                        initialTags: provider.tags ?? [],
                        onTagAdded: (tag) => provider.addTag(tag),
                        onTagRemoved: (tag) => provider.removeTag(tag),
                        chipBackgroundColor: Colors.white,
                        deleteIconColor: Colors.red,
                        chipBorderSide: const BorderSide(color: Colors.blue),
                      ),
                     const  SizedBox(height: 10),
                      NewTextField(controller: provider.shortDescriptionController, labelText: "Short Description", maxLine: 3,),
                      const SizedBox(height: 8,),
                      NewTextField(controller: provider.longDescriptionController,  labelText: "Long Description", maxLine: 4,),
                      const SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        child: ElevatedButton(
                            onPressed: () {
                              provider.createService(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              "Add Service",
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