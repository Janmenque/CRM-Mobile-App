import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/discount/discount_create_component_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/coupon/content/coupon_multiselect_categories.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/coupon/content/coupon_multiselect_customers.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/coupon/content/coupon_multiselect_services.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/coupon/content/coupon_multiselect_zones.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/coupon/provider/create_coupon_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:provider/provider.dart';

class CreateCouponScreen extends StatelessWidget {
  const CreateCouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("Create Coupon", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CreateCouponProvider(),
        child: Consumer<CreateCouponProvider>(
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
                      Row(
                        children: [
                          Expanded(child: CustomDropdown<CouponType>(
                            value: provider.couponType,
                            labelText: 'Coupon Type',
                            items: provider.discountComponentListResponse?.data?.couponTypes ?? [],
                            onChanged: (CouponType? newValue) {
                              provider.selectedCouponType(newValue!);
                            },
                            itemLabelBuilder: (CouponType value) => value.name ?? '',
                          ),),
                          Expanded(child: NewTextField(labelText: "Coupon Code", controller: provider.couponCodeController,)),
                        ],
                      ),
                      provider.couponType?.name == "Customer Wise" ?
                      CouponMultiselectCustomers(provider:provider) : const SizedBox(),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right : 10,),
                        child: Text(
                          'Discount Type *',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
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
                      NewTextField(labelText: "Discount Title", controller: provider.titleController,),
                      const SizedBox(height: 8),
                      provider.selectDiscountType == "Category" ? CouponMultiselectCategories(provider: provider,) : const SizedBox(),
                      provider.selectDiscountType == "Service" ? CouponMultiselectService(provider: provider,) : const SizedBox(),
                      provider.selectDiscountType == "Mixed" ?
                      Column(
                        children: [
                          CouponMultiselectCategories(provider: provider,),
                          const SizedBox(height: 8),
                          CouponMultiselectService(provider:provider),
                        ],
                      ) : const SizedBox(),
                      const SizedBox(height: 8,),
                      CouponMultiselectZones(provider:provider),
                      const SizedBox(height: 8),
                      const Padding(
                        padding:  EdgeInsets.only(left: 10, right : 10,  top: 10),
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

                      const SizedBox(height: 8),
                      NewTextField(labelText: "Limit For Same User", controller: provider.limitForSameUserController,),
                      Padding(
                        padding: const EdgeInsets.symmetric( vertical: 14),
                        child: ElevatedButton(
                            onPressed: () {
                               provider.createCoupon(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              "Create Coupon",
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