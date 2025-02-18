import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_invoice_dropdown_and_formlist.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_invoice_product_list.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_invoice_provider.dart';
import 'package:provider/provider.dart';

class ClientCreateInvoiceScreen extends StatelessWidget {
  int clientId;
  ClientCreateInvoiceScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Invoice", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ClientCreateInvoiceProvider(),
        child: Consumer<ClientCreateInvoiceProvider>(
            builder: (context, provider, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ClientInvoiceDropDownAndFormList(provider: provider,),
                    Container(
                      margin: const EdgeInsets.symmetric( horizontal: 14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //ProductSearchWithCategory(),
                            const SizedBox(height: 14,),

                            ClientInvoiceProductList(clientCreateInvoiceProvider: provider, clientId: clientId, wareHouseId: provider.clientInvoiceWarehouse?.id ?? 0 ,),
                          ],
                        ),
                      ),
                    ),
                    const  SizedBox(height: 20,)
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}