import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/create_quotation_all_dropdown_list_model.dart';
import 'package:hrm_app/data/model/crm_sales/quotation_product_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/quotation/provider/add_quotation_provider.dart';
import 'package:provider/provider.dart';

class AddQuotationScreen extends StatelessWidget {
  const AddQuotationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("Add Quotation", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => AddQuotationProvider(),
        child: Consumer<AddQuotationProvider>(
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
                       Row(
                        children: [
                          Expanded(child: CustomDropdown<Value>(
                            value: provider.quotationBiller,
                            labelText: 'Select Biller',
                            items: provider.createQuotationAllDropdownListResponse?.data?.biller ?? [],
                            onChanged: (Value? newValue) {
                              provider.selectQuotationBiller(newValue!);
                            },
                            itemLabelBuilder: (Value value) => value.name ?? '',
                          ),),
                          Expanded(child: CustomDropdown<Value>(
                            value: provider.quotationSupplier,
                            labelText: 'Select Supplier',
                            items: provider.createQuotationAllDropdownListResponse?.data?.supplier ?? [],
                            onChanged: (Value? newValue) {
                              provider.selectQuotationSupplier(newValue!);
                            },
                            itemLabelBuilder: (Value value) => value.name ?? '',
                          ),),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Expanded(child: CustomDropdown<Value>(
                            value: provider.customer,
                            labelText: 'Select Customer',
                            items: provider.createQuotationAllDropdownListResponse?.data?.customer ?? [],
                            onChanged: (Value? newValue) {
                              provider.selectCustomer(newValue!);
                            },
                            itemLabelBuilder: (Value value) => value.name ?? '',
                          ),),
                          Expanded(child: CustomDropdown<Value>(
                            value: provider.warehouse,
                            labelText: 'Warehouse',
                            items: provider.createQuotationAllDropdownListResponse?.data?.warehouse ?? [],
                            onChanged: (Value? newValue) {
                              provider.selectWarehouse(newValue!);
                            },
                            itemLabelBuilder: (Value value) => value.name ?? '',
                          ),),
                        ],
                      ),
                      const SizedBox(height: 14,),

                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdown<QuotationProduct>(
                              value: provider.quotationProduct,
                              labelText: 'Product',
                              items: provider.quotationProductListResponse?.data?? [],
                              onChanged: (QuotationProduct? newValue) {
                                provider.selectQuotationProduct(newValue!);
                              },
                              itemLabelBuilder: (QuotationProduct value) => value.productName ?? '',
                            ),
                          ),
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
                                    provider.setQuantity(quantity, provider.quotationProduct, provider.customer?.id);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height:8),
                      provider.quantity > 0 && provider.quotationProduct != null ?
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            color: const Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(provider.quotationProductInfoResponse?.data?.name ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                               Text("Product Code : ${provider.quotationProductInfoResponse?.data?.code ?? ""}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                               Text("Net Unit Cost: ${provider.quotationProductInfoResponse?.data?.netUnitPrice ?? ""}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                               Text("Tax: ${provider.quotationProductInfoResponse?.data?.tax ?? ""}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                               Text("Sub Total: ${provider.quotationProductInfoResponse?.data?.subTotal ?? ""}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                               Text("Total: ${provider.quotationProductInfoResponse?.data?.subTotal ?? ""}", style: const TextStyle(fontSize: 12, color: Colors.grey),)
                            ],
                          ),
                        ),
                      ) : const SizedBox(),
                      Row(
                        children: [
                          Expanded(child: CustomDropdown<Value>(
                            value: provider.tax,
                            labelText: 'Order Tax',
                            items: provider.createQuotationAllDropdownListResponse?.data?.taxList ?? [],
                            onChanged: (Value? newValue) {
                              provider.selectTax(newValue!);
                            },
                            itemLabelBuilder: (Value value) => value.name ?? '',
                          ),),
                          Expanded(child: NewTextField(controller: provider.orderDiscountController,labelText: "Order Discount",)),
                        ],
                      ),
                       Row(
                        children: [
                          Expanded(child: NewTextField(controller: provider.shippingCostController, labelText: "Shipping Cost",)),
                          Expanded(child: CustomDropdown<Value>(
                            value: provider.status,
                            labelText: 'Status',
                            items: provider.createQuotationAllDropdownListResponse?.data?.quotationStatusList ?? [],
                            onChanged: (Value? newValue) {
                              provider.selectStatus(newValue!);
                            },
                            itemLabelBuilder: (Value value) => value.name ?? '',
                          ),),
                        ],
                      ),
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
                                  child: const Text("Upload Product Image", style: TextStyle(color: Colors.grey),),
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
                      NewTextField(controller: provider.noteController, labelText: "Note",),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        child: ElevatedButton(
                            onPressed: () {
                              provider.addQuotation(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              "Add Quotation",
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
