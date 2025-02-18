import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/add_sale_all_dropdown_list_model.dart';
import 'package:hrm_app/data/model/crm_sales/sale_product_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/sale/provider/add_sale_provider.dart';
import 'package:provider/provider.dart';
import '../../product/content/custom_dropdown.dart';

class AddSaleScreen extends StatelessWidget {
  const AddSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Sale", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => AddSaleProvider(),
        child: Consumer<AddSaleProvider>(
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
                      InkWell(
                        onTap: () => provider.selectDate(context),
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
                              Text( provider.monthYear ??  "Select Date",style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                              const Icon(Icons.calendar_month_outlined, color: Colors.grey,)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      NewTextField(labelText: "Reference No",controller: provider.referenceController,),
                      const SizedBox(height: 8,),
                      CustomDropdown<SaleData>(
                        value: provider.customer,
                        labelText: 'Select Customer',
                        items: provider.addSalesAllDropdownListResponse?.data?.customer ?? [],
                        onChanged: (SaleData? newValue) {
                          provider.selectCustomer(newValue!);
                        },
                        itemLabelBuilder: (SaleData value) => value.name ?? '',
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Expanded(child: CustomDropdown<SaleData>(
                            value: provider.warehouse,
                            labelText: 'Warehouse',
                            items: provider.addSalesAllDropdownListResponse?.data?.warehouse ?? [],
                            onChanged: (SaleData? newValue) {
                              provider.selectWarehouse(newValue!);
                            },
                            itemLabelBuilder: (SaleData value) => value.name ?? '',
                          ),),
                          Expanded(child: CustomDropdown<SaleData>(
                            value: provider.biller,
                            labelText: 'Select Biller',
                            items: provider.addSalesAllDropdownListResponse?.data?.biller ?? [],
                            onChanged: (SaleData? newValue) {
                              provider.selectBiller(newValue!);
                            },
                            itemLabelBuilder: (SaleData value) => value.name ?? '',
                          ),),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdown<SaleProduct>(
                              value: provider.saleProduct,
                              labelText: 'Select Product',
                              items: provider.saleProductListResponse?.data ?? [],
                              onChanged: (SaleProduct? newValue) {
                                provider.selectSaleProduct(newValue!);
                              },
                              itemLabelBuilder: (SaleProduct value) => value.productName ?? '',
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextField(
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
                                      provider.setQuantity(quantity, provider.saleProduct, provider.customer?.id);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      provider.quantity > 0 && provider.saleProduct != null ?
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(provider.saleProductInfoResponse?.data?.name ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            Text("Batch No : ${provider.saleProductInfoResponse?.data?.code ?? ''}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                            Text("Net Unit Cost: ${provider.saleProductInfoResponse?.data?.code ?? ''}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                            Text("Tax: ${provider.saleProductInfoResponse?.data?.tax ?? ''}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                            Text("Sub Total: ${provider.saleProductInfoResponse?.data?.subTotal ?? ''}", style: const TextStyle(fontSize: 12, color: Colors.grey),),
                          ],
                        ),
                      ) : const SizedBox(),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Expanded(child: CustomDropdown<SaleData>(
                            value: provider.tax,
                            labelText: 'Order tax',
                            items: provider.addSalesAllDropdownListResponse?.data?.taxList ?? [],
                            onChanged: (SaleData? newValue) {
                              provider.selectTax(newValue!);
                            },
                            itemLabelBuilder: (SaleData value) => value.name ?? '',
                          ),),
                          Expanded(child: CustomDropdown<DiscountType>(
                            value: provider.discountType,
                            labelText: 'Document Type',
                            items: provider.addSalesAllDropdownListResponse?.data?.discountTypeList ?? [],
                            onChanged: (DiscountType? newValue) {
                              provider.selectDiscountType(newValue!);
                            },
                            itemLabelBuilder: (DiscountType value) => value.name ?? '',
                          ),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(child: NewTextField(labelText: "Value", controller: provider.discountValueController,)),
                          Expanded(child: NewTextField(labelText: "Shipping Cost", controller: provider.shippingCostController,)),
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
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Expanded(child: CustomDropdown<SaleData>(
                            value: provider.saleStatus,
                            labelText: 'Sale Status',
                            items: provider.addSalesAllDropdownListResponse?.data?.saleStatusList ?? [],
                            onChanged: (SaleData? newValue) {
                              provider.selectSaleStatus(newValue!);
                            },
                            itemLabelBuilder: (SaleData value) => value.name ?? '',
                          ),),
                          Expanded(child: CustomDropdown<SaleData>(
                            value: provider.paymentStatus,
                            labelText: 'Payment Status',
                            items: provider.addSalesAllDropdownListResponse?.data?.paymentStatusList ?? [],
                            onChanged: (SaleData? newValue) {
                              provider.selectPaymentStatus(newValue!);
                            },
                            itemLabelBuilder: (SaleData value) => value.name ?? '',
                          ),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      NewTextField(labelText: "Sale Note", controller: provider.saleNoteController,),
                      NewTextField(labelText: "Staff Note", controller: provider.staffNoteController,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        child: ElevatedButton(
                            onPressed: () {
                              provider.addSale(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              "Add Sale",
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