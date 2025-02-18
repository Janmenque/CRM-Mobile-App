import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/provider/pos_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';

class DropDownAndFormList extends StatelessWidget {
  final PosProvider provider;
  const DropDownAndFormList({
    super.key, required this.provider
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Row(
            children: [
              Expanded(child: NewTextField(labelText: "Reference Number",)),
              Expanded(child: NewTextField(labelText: "Warehouse",)),
            ],
          ),
          const Row(
            children: [
              Expanded(child: NewTextField(labelText: "Select Biller",)),
              Expanded(child: NewTextField(labelText: "Cistomer",)),
            ],
          ),
        ],
      ),
    );
  }
}