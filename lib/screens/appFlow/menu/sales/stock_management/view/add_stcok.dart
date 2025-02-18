import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/data/model/crm_sales/add_product_all_dropdown_model.dart';
import 'package:hrm_app/data/model/crm_sales/warehouse_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/stock_management/provider/add_stock_provider.dart';
import 'package:provider/provider.dart';

class AddStockScreen extends StatelessWidget {
  const AddStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return  ChangeNotifierProvider(
      create: (_) => AddStockProvider(),
      child: Consumer<AddStockProvider>(
          builder: (context, provider, _) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Add Stock", style: TextStyle(fontWeight: FontWeight.bold),),
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
                            const SizedBox( height: 12,),
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
                            const SizedBox( height: 12,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomDropdown<String>(
                                      value: provider.type,
                                      labelText: 'Select Type',
                                      items: provider.typeList ?? [],
                                      onChanged: (String? newValue) {
                                        provider.selectType(newValue!);
                                      },
                                      itemLabelBuilder: (String value) => value ?? '', // Custom logic for item label
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox( height: 12,),
                            provider.type == "Partial" ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showCategoryMultiSelectDialog(context, provider.addProductAllDropdownResponse?.data?.categories ?? [], provider);
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
                                            'Select Categories',
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                          Icon(Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox( height: 6,),
                                provider.selectedCategories.isNotEmpty ?
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                                  child: Text(
                                    "Selected Categories:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ) : const SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                  child: Text(
                                    provider.selectedCategories.map((e) => e.name).join(", "),
                                  ),
                                ),


                                const SizedBox( height: 12,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showBrandMultiSelectDialog(context, provider.addProductAllDropdownResponse?.data?.brands ?? [], provider);
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
                                          Text('Select Brands', style: TextStyle(color: Colors.black54),),
                                          Icon(Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox( height: 6,),
                                provider.selectedBrands.isNotEmpty ?
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                                  child: Text("Selected Brands:", style: TextStyle(fontWeight: FontWeight.bold),),
                                ) : const SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                  child: Text(provider.selectedBrands.map((e) => e.title).join(", "),),
                                ),
                              ],
                            ) : const SizedBox(),
                            const SizedBox( height: 14,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
                        child: ElevatedButton(
                            onPressed: ()=> provider.addStock(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              minimumSize: Size(double.infinity, 50.h),
                            ),
                            child: Text(
                              "Add Stock", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
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


  void showCategoryMultiSelectDialog(BuildContext context, List<ProductCategory> items, AddStockProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text("Select Categories") ,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView(
                  children: items.map((category) {
                    return CheckboxListTile(
                      title: Text(category.name!),
                      value: provider.selectedCategories
                          .any((selected) => selected.id == category.id),
                      onChanged: (bool? value) {
                        provider.toggleCategory(category);
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


  void showBrandMultiSelectDialog(BuildContext context, List<Brand> items, AddStockProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text("Select Brands") ,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView(
                  children: items.map((brand) {
                    return CheckboxListTile(
                      title: Text(brand.title!),
                      value: provider.selectedBrands.any((selected) => selected.id == brand.id),
                      onChanged: (bool? value) {
                        provider.toggleBrand(brand);
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
