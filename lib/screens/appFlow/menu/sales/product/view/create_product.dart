import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/data/model/crm_sales/add_product_all_dropdown_model.dart';
import 'package:hrm_app/data/model/other_unit_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/provider/add_product_provider.dart';
import 'package:provider/provider.dart';

class CreateProduct extends StatelessWidget {
  const CreateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (_) => AddProductProvider(),
      child: Consumer<AddProductProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Add Product", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:  Column(
                        children: [
                          NewTextField(controller: provider.productNameController, labelText: "Product Name",),
                          Row(
                            children: [

                              Expanded(
                                child: CustomDropdown<ProductType>(
                                  value: provider.productType,
                                  labelText: 'Product Type',
                                  items: provider.addProductAllDropdownResponse?.data?.productTypes != null &&
                                         provider.addProductAllDropdownResponse!.data!.productTypes!.isNotEmpty
                                      ?  [provider.addProductAllDropdownResponse!.data!.productTypes![0]]
                                      :  [],
                                  onChanged: (ProductType? newValue) {
                                    provider.selectProductType(newValue!);
                                  },
                                  itemLabelBuilder: (ProductType value) => value.value ?? '', // Custom logic for item label
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text(provider.productCode, style: const TextStyle(fontSize: 12, color:  Color(0xff5B58FF), fontWeight: FontWeight.bold))),
                                          InkWell(
                                              onTap: provider.generateCode,
                                              child: const Icon(Icons.cached, color:  Color(0xff5B58FF)))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6,),
                          Row(
                            children: [
                              Expanded(
                                child:  CustomDropdown<BarcodeSymbology>(
                                  value: provider.barcodeSymbology,
                                  labelText: 'BarCode',
                                  items: provider.addProductAllDropdownResponse?.data?.barcodeSymbologies ?? [],
                                  onChanged: (BarcodeSymbology? newValue) {
                                    provider.selectBarcodeSymbology(newValue!);
                                  },
                                  itemLabelBuilder: (BarcodeSymbology value) => value.value ?? '',
                                ),
                              ),
                              Expanded(
                                child:  CustomDropdown<Brand>(
                                  value: provider.brand,
                                  labelText: 'Brand',
                                  items: provider.addProductAllDropdownResponse?.data?.brands ?? [],
                                  onChanged: (Brand? newValue) {
                                    provider.selectBrand(newValue!);
                                  },
                                  itemLabelBuilder: (Brand value) => value.title ?? '',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child:  CustomDropdown<ProductCategory>(
                                  value: provider.category,
                                  labelText: 'Categories',
                                  items: provider.addProductAllDropdownResponse?.data?.categories ?? [],
                                  onChanged: (ProductCategory? newValue) {
                                    provider.selectProductCategory(newValue!);
                                  },
                                  itemLabelBuilder: (ProductCategory value) => value.name ?? '',
                                ),
                              ),
                              Expanded(
                                child:  CustomDropdown<ProductUnit>(
                                  value: provider.productUnit,
                                  labelText: 'Product Unit',
                                  items: provider.addProductAllDropdownResponse?.data?.productUnits ?? [],
                                  onChanged: (ProductUnit? newValue) {
                                    provider.selectProductUnit(newValue!);
                                  },
                                  itemLabelBuilder: (ProductUnit value) => value.unitName ?? '',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child:  CustomDropdown<OtherUnit>(
                                  value: provider.saleUnit,
                                  labelText: 'Sale Unit',
                                  items: provider.otherUnitResponse?.otherUnit ?? [],
                                  onChanged: (OtherUnit? newValue) {
                                    provider.selectSaleUnit(newValue!);
                                  },
                                  itemLabelBuilder: (OtherUnit value) => value.unitName ?? '',
                                ),
                              ),
                              Expanded(
                                child:  CustomDropdown<OtherUnit>(
                                  value: provider.purchaseUnit,
                                  labelText: 'Purchase Unit',
                                  items: provider.otherUnitResponse?.otherUnit ?? [],
                                  onChanged: (OtherUnit? newValue) {
                                    provider.selectPurchaseUnit(newValue!);
                                  },
                                  itemLabelBuilder: (OtherUnit value) => value.unitName ?? '',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          NewTextField(controller: provider.productCostController,  labelText: "Product Cost",),
                          NewTextField(controller: provider.productPriceController, labelText: "Product Price",),
                          NewTextField(controller: provider.dailySaleController, labelText: "daily sale Objective",),
                          NewTextField(controller: provider.alertQuantityController, labelText: "Alert Quantity",),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child:  CustomDropdown<TaxLists>(
                                  value: provider.taxLists,
                                  labelText: 'Product Tax',
                                  items: provider.addProductAllDropdownResponse?.data?.taxLists ?? [],
                                  onChanged: (TaxLists? newValue) {
                                    provider.selectTaxLists(newValue!);
                                  },
                                  itemLabelBuilder: (TaxLists value) => value.name ?? '',
                                ),
                              ),
                              Expanded(
                                child:  CustomDropdown<TaxMethod>(
                                  value: provider.taxMethod,
                                  labelText: 'Tax Method',
                                  items: provider.addProductAllDropdownResponse?.data?.taxMethod ?? [],
                                  onChanged: (TaxMethod? newValue) {
                                    provider.selectTaxMethod(newValue!);
                                  },
                                  itemLabelBuilder: (TaxMethod value) => value.label ?? '',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                Checkbox(
                                  value: provider.isFeatured,
                                  onChanged: (bool? value) =>  provider.toggleFeatured(value!),
                                  side: const BorderSide(color: Colors.grey, width: 1),
                                ),
                                const Text("Featured", style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: provider.isBarCode,
                                  onChanged: (bool? value) =>  provider.toggleBarcode(value!),
                                  side: const BorderSide(color: Colors.grey, width: 1),
                                ),
                                const Text(overflow: TextOverflow.ellipsis, " Barcode", style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      margin: const EdgeInsets.symmetric( horizontal: 14),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///upload images
                          InkWell(
                            onTap: () => provider.pickProductImage(context),
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
                          const SizedBox(height: 12,),
                          provider.productImages.isNotEmpty ?
                          Wrap(
                            children: List.generate(provider.productImages.length, (index){
                              return
                                Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 14, bottom: 14),
                                    child: Image.file(
                                      provider.productImages[index],
                                      height: 60, width: 60, fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    top: -10,
                                    child: InkWell(
                                      onTap: ()=> provider.removeImage(index),
                                      child: Card(
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration:  BoxDecoration(
                                            color:  Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: const Offset(1, 1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: const Icon(Icons.close, color: Colors.red, size: 10,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ) :
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index){
                                  return  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(14.sp),
                                          margin: const EdgeInsets.only(top: 6),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF5F5F5),
                                              borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: const Icon(Icons.photo_camera_back, color: Colors.grey,),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: -3,
                                          child: Card(
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration:  BoxDecoration(
                                                color:  Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white.withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: const Offset(1, 1), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: const Icon(Icons.close, color: Colors.black,size: 10,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),

                          const SizedBox(height: 12,),
                          NewTextField(controller: provider.productDetailsController, labelText: "Product Details", maxLine: 3, formHeight : 100),
                          Row(
                            children: [
                              Checkbox(
                                value: provider.isDifferentPrice,
                                onChanged: (bool? value) =>  provider.toggleDifferentPrice(value!),
                                side: const BorderSide(color: Colors.grey, width: 1),
                              ),
                              const Expanded(
                                child:  Text("This product has different price for different warehouse", style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: provider.isBatch,
                                onChanged: (bool? value) =>  provider.toggleBatch(value!),
                                side: const BorderSide(color: Colors.grey, width: 1),
                              ),
                              const Expanded(
                                child:  Text("This product has batch and expired date", style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: provider.isImei,
                                onChanged: (bool? value) =>  provider.toggleImei(value!),
                                side: const BorderSide(color: Colors.grey, width: 1),
                              ),
                              const Expanded(
                                child:  Text("This product has IMEI or Serial numbers", style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: provider.isPromotionPrice,
                                onChanged: (bool? value) =>  provider.togglePromotionPrice(value!),
                                side: const BorderSide(color: Colors.grey, width: 1),
                              ),
                              const Expanded(
                                child:  Text("Add Promotional Price", style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
                      child: ElevatedButton(
                          onPressed: () {
                            provider.addProduct(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5B58FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                          child: Text(
                            "Add Product",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
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