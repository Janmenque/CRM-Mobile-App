import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/data/model/crm_sales/product_list_accourding_warehouse_model.dart';
import 'package:hrm_app/data/model/crm_sales/warehouse_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/adjustment/provider/add_adjustment_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:provider/provider.dart';
import '../../product/content/new_form_field.dart';

class CreateAdjustmentScreen extends StatelessWidget {
   const CreateAdjustmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return  ChangeNotifierProvider(
      create: (_) => AddAdjustmentProvider(),
      child: Consumer<AddAdjustmentProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Add Adjustment", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric( horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox( height: 16,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: CustomDropdown<Warehouse>(
                              value: provider.warehouse,
                              labelText: 'Select Warehouse',
                              items: provider.wareHouseListResponse?.data?.warehouse ?? [],
                              onChanged: (Warehouse? newValue) {
                                provider.selectWarehouse(newValue!);
                              },
                              itemLabelBuilder: (Warehouse value) => value.name ?? '', // Custom logic for item label
                            ),
                          ),
                          const SizedBox( height: 16,),
                          ///upload images
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14.0),
                            child: InkWell(
                              onTap: ()=> provider.pickImage(context),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                          border: Border.all(color: Colors.grey, width: 1)
                                      ),
                                      child: const Text("Upload Product Image", style: TextStyle(color: Colors.grey),),
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
                          const SizedBox(height: 16,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: CustomDropdown<WareHouseProduct>(
                              value: provider.wareHouseProduct,
                              labelText: 'Select product',
                              items: provider.productListAccordingWarehouseResponse?.data ?? [],
                              onChanged: (WareHouseProduct? newValue) {
                                provider.selectWarehouseProduct(newValue!);
                              },
                              itemLabelBuilder: (WareHouseProduct value) => value.name ?? '',
                            ),
                          ),
                          const SizedBox(height: 12,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomDropdown<String>(
                                    value: provider.action,
                                    labelText: 'Select Action',
                                    items: provider.actionList ?? [],
                                    onChanged: (String? newValue) {
                                      provider.selectAction(newValue!);
                                    },
                                    itemLabelBuilder: (String value) => value ?? '',
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 48,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: provider.quantityController,
                                        cursorHeight: 18,
                                        decoration: InputDecoration(
                                          labelText:  'Quantity',
                                          labelStyle: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                          const SizedBox(height: 12,),
                           Padding(
                            padding: const  EdgeInsets.symmetric(horizontal: 6.0),
                            child:  NewTextField( controller: provider.noteController, labelText: "Note", maxLine: 3, formHeight : 100),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
                      child: ElevatedButton(
                          onPressed:()=> provider.addAdjustment(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5B58FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                          child: Text(
                            "Add Adjustment", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
