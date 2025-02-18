import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/invoice_order_service.dart';
import 'package:hrm_app/api_service/proposal_order_service.dart';
import 'package:hrm_app/data/model/client_invoice/client_invoice_warehouse_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_invoice_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_proposal_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:provider/provider.dart';

class ClientProposalDropDownAndFormList extends StatelessWidget {
  final ClientCreateProposalProvider provider;

  const ClientProposalDropDownAndFormList({
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
          Row(
            children: [
              Expanded(child:  InkWell(
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
              ),),
              Consumer<ProposalOrderService>(
                  builder: (context, proposalCartProvider, _) {
                    return Expanded(
                      child: CustomDropdown<ClientInvoiceWarehouse>(
                        value: provider.clientInvoiceWarehouse,
                        labelText: 'Select warehouse',
                        items: provider.clientInvoiceWarehouseListResponse?.data ?? [],
                        onChanged: (ClientInvoiceWarehouse? newValue) {
                          provider.selectWarehouse(newValue!);
                          proposalCartProvider.clearProductFromCart();
                        },
                        itemLabelBuilder: (ClientInvoiceWarehouse value) => value.name ?? '',
                      ),
                    );
                  }
              ),
            ],
          ),
        ],
      ),
    );
  }
}