import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/coupon/coupon_customer_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/coupon/provider/create_coupon_provider.dart';


class CouponMultiselectCustomers extends StatelessWidget {
  CreateCouponProvider provider;
  CouponMultiselectCustomers({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              showCustomerMultiSelectDialog(context, provider.couponCustomerListResponse?.data ?? [], provider);
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
                    'Select Customer',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
        const SizedBox( height: 6,),
        provider.selectedCustomers.isNotEmpty ?
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            "Selected Customers:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ) : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            provider.selectedCustomers.map((e) => e.name).join(", "),
          ),
        ),
        const SizedBox(height: 8,),
      ],
    );
  }


  void showCustomerMultiSelectDialog(BuildContext context, List<CouponCustomer> items, CreateCouponProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text("Select Customer") ,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView(
                  children: items.map((customer) {
                    return CheckboxListTile(
                      title: Text(customer.name!),
                      value: provider.selectedCustomers.any((selected) => selected.id == customer.id),
                      onChanged: (bool? value) {
                        provider.toggleCustomer(customer);
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
