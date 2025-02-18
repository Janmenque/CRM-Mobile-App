import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/campaign/content/campaign_multiselect_categories.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/campaign/content/campaign_multiselect_services.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/campaign/content/cmapaign_multiselect_zones.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/campaign/provider/create_campaign_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:provider/provider.dart';

class CreateCampaignScreen extends StatelessWidget {
  const CreateCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("Create Campaign", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CreateCampaignProvider(),
        child: Consumer<CreateCampaignProvider>(
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
                      const SizedBox(height: 8),
                      NewTextField(labelText: "Campaign Name", controller: provider.campaignNameController,),

                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: ()=> provider.pickThumbnailImageFile(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                      border: Border.all(color: Colors.grey, width: 1)
                                  ),
                                  child: const Text("Add Thumbnail Image", style: TextStyle(color: Colors.grey),),
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
                      provider.thumbNailImageFile != null ?
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 10),
                        child: Image.file(
                          provider.thumbNailImageFile!,
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
                                onTap: ()=> provider.pickCoverImageFile(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                      border: Border.all(color: Colors.grey, width: 1)
                                  ),
                                  child: const Text("Add Cover Image", style: TextStyle(color: Colors.grey),),
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
                      provider.coverImageFile != null ?
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 10),
                        child: Image.file(
                          provider.coverImageFile!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ) : const SizedBox(),



                      const Padding(
                        padding: EdgeInsets.only(left: 10, right : 10,  top: 10),
                        child: Text(
                          'Discount Type *',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ///discount Type
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio<String>(
                            value: 'Category',
                            groupValue: provider.selectDiscountType,
                            onChanged: (value) {
                              provider.setSelectedDiscountType(value!);
                            },
                          ),
                          const Text('Category '),
                          Radio<String>(
                            value: 'Service',
                            groupValue: provider.selectDiscountType,
                            onChanged: (value) {
                              provider.setSelectedDiscountType(value!);
                            },
                          ),
                          const Text('Service'),
                          Radio<String>(
                            value: 'Mixed',
                            groupValue: provider.selectDiscountType,
                            onChanged: (value) {
                              provider.setSelectedDiscountType(value!);
                            },
                          ),
                          const Text('Mixed'),
                        ],
                      ),
                      NewTextField(labelText: "Enter Discount Title", controller: provider.discountTitleController,),
                      const SizedBox(height: 8),
                      provider.selectDiscountType == "Category" ? CampaignMultiselectCategories(provider: provider,) : const SizedBox(),
                      provider.selectDiscountType == "Service" ? CampaignMultiselectService(provider: provider,) : const SizedBox(),
                      provider.selectDiscountType == "Mixed" ?
                      Column(
                        children: [
                          CampaignMultiselectCategories(provider: provider,),
                          const SizedBox(height: 8),
                          CampaignMultiselectService(provider:provider),
                        ],
                      ) : const SizedBox(),
                      const SizedBox(height: 8,),
                      CampaignMultiselectZones(provider:provider),
                      const SizedBox(height: 8,),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right : 10,  top: 10),
                        child: Text(
                          'Discount Amount Type *',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio<String>(
                            value: 'Percentage',
                            groupValue: provider.selectDiscountAmountType,
                            onChanged: (value) {
                              provider.setSelectedDiscountAmountType(value!);
                            },
                          ),
                          const Text('Percentage'),
                          Radio<String>(
                            value: 'Fixed',
                            groupValue: provider.selectDiscountAmountType,
                            onChanged: (value) {
                              provider.setSelectedDiscountAmountType(value!);
                            },
                          ),
                          const Text('Fixed'),
                        ],
                      ),
                      NewTextField(labelText: "Enter Discount Amount", controller: provider.amountController,),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      provider.selectDiscountAmountType == "Percentage" ?
                      Row(
                        children: [

                          Expanded(child: NewTextField(labelText: "Min Purchase Amount", controller: provider.minPurchaseController,)),
                          Expanded(child: NewTextField(labelText: "Max Purchase Amount", controller: provider.maxPurchaseController,)),
                        ],
                      ) :  NewTextField(labelText: "Min Purchase Amount", controller: provider.minPurchaseController,),

                      Padding(
                        padding: const EdgeInsets.symmetric( vertical: 14),
                        child: ElevatedButton(
                            onPressed: () {
                               provider.createCampaign(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              "Submit",
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