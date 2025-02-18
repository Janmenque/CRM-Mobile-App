import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/purchase_product_list_model.dart';
import 'package:hrm_app/data/model/crm_sales/supplier_list_model.dart';
import 'package:hrm_app/data/model/crm_sales/warehouse_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/purchase/provider/create_purchase_provider.dart';
import 'package:provider/provider.dart';

class CreatePurchaseScreen extends StatelessWidget {
  const CreatePurchaseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Purchase", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CreatePurchaseProvider(),
        child: Consumer<CreatePurchaseProvider>(
          builder: (context, provider, _) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric( horizontal: 14, vertical: 14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => provider.selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                        margin: const EdgeInsets.symmetric( horizontal: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey, width: 1),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text( provider.selectedDate ??  "Select Date",style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                            const Icon(Icons.calendar_month_outlined, color: Colors.grey,)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    CustomDropdown<Warehouse>(
                      value: provider.warehouse,
                      labelText: 'Select Warehouse',
                      items: provider.wareHouseListResponse?.data?.warehouse ?? [],
                      onChanged: (Warehouse? newValue) {
                        provider.selectWarehouse(newValue!);
                      },
                      itemLabelBuilder: (Warehouse value) => value.name ?? '',
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child:  CustomDropdown<Supplier>(
                          value: provider.supplier,
                          labelText: 'Supplier',
                          items: provider.supplierListResponse?.data ?? [],
                          onChanged: (Supplier? newValue) {
                            provider.selectSupplier(newValue!);
                          },
                          itemLabelBuilder: (Supplier value) => value.name ?? '',
                        ),),
                        Expanded(child:  CustomDropdown<Tax>(
                          value: provider.purchaseStatus,
                          labelText: 'Purchase Status',
                          items: provider.purchaseProductListResponse?.data?.purchaseStatusList ?? [],
                          onChanged: (Tax? newValue) {
                            provider.selectPurchaseStatus(newValue!);
                          },
                          itemLabelBuilder: (Tax value) => value.name ?? '',
                        ),),
                      ],
                    ),
                    const SizedBox( height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: ()=> provider.pickImage(context),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8),),
                                    border: Border.all(color: Colors.grey, width: 1)
                                ),
                                child: const Text("Upload Product Image", style: TextStyle(color: Colors.grey),),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8),),
                                  border: Border.all(color: Colors.grey, width: 1)),
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
                        height: 80, width: 80, fit: BoxFit.cover,
                      ),
                    ) : const SizedBox(),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(child: CustomDropdown<PurchaseProduct>(
                          value: provider.purchaseProduct,
                          labelText: 'Select Product',
                          items: provider.purchaseProductListResponse?.data?.purchaseProductList ?? [],
                          onChanged: (PurchaseProduct? newValue) {
                            provider.selectPurchaseProduct(newValue!);
                          },
                          itemLabelBuilder: (PurchaseProduct value) => value.name ?? '',
                        ),),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: TextField(
                              controller: provider.quantityController,
                              decoration: InputDecoration(
                              labelText: 'Enter Quantity',
                              labelStyle: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(8.0),
                          ),),
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              int? quantity = int.tryParse(value);
                              if (quantity != null) {
                                provider.setQuantity(quantity, provider.purchaseProduct);
                              }
                            },
                          ),
                          ),
                        ),
                        //const Expanded(child: NewTextField(labelText: "Enter Quantity",)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    provider.quantity > 0 && provider.purchaseProduct != null ?
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(color: const Color(0xfff5f5f5), borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(provider.purchaseProductInfoResponse?.data?.name ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                           Text("Batch No : ${provider.purchaseProductInfoResponse?.data?.code ?? ""}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                           Text("Net Unit Cost: ${provider.purchaseProductInfoResponse?.data?.netUnitCost ?? ""}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                           Text("Tax: ${provider.purchaseProductInfoResponse?.data?.tax ?? ""}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                           Text("Total: ${provider.purchaseProductInfoResponse?.data?.subTotal ?? ""}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                        ],
                      ),
                    ) : const SizedBox(),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: CustomDropdown<Tax>(
                          value: provider.tax,
                          labelText: 'Select Order Tax',
                          items: provider.purchaseProductListResponse?.data?.taxList ?? [],
                          onChanged: (Tax? newValue) {
                            provider.selectTax(newValue!);
                          },
                          itemLabelBuilder: (Tax value) => value.name ?? '',
                        ),),
                        Expanded(child: NewTextField(labelText: "Shipping Cost", controller: provider.shippingCostController,)),
                      ],
                    ),
                    NewTextField(labelText: "Note", controller: provider.noteController,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                      child: ElevatedButton(
                          onPressed: () { provider.addPurchase(context);},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5B58FF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            minimumSize: const Size(double.infinity, 50),
                          ), child: const Text(
                            "Add Purchase", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))),
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