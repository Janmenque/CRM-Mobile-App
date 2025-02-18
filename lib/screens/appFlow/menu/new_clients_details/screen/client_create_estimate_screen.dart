import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_estimate_dropdown_and_form_list.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_estimate_product_list.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_estimate_provider.dart';
import 'package:provider/provider.dart';


class ClientCreateEstimateScreen extends StatelessWidget {
  int clientId;
  ClientCreateEstimateScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Estimate", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ClientCreateEstimateProvider(),
        child: Consumer<ClientCreateEstimateProvider>(
            builder: (context, provider, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ClientEstimateDropDownAndFormList(provider: provider,),
                    Container(
                      margin: const EdgeInsets.symmetric( horizontal: 14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 14,),
                             ClientEstimateProductList(clientCreateEstimateProvider: provider, clientId: clientId, wareHouseId: provider.clientInvoiceWarehouse?.id ?? 0 ,),
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