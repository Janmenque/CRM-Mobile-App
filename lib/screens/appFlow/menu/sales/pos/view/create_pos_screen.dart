import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/content/drop_down_and_form_list.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/content/product_list_and_add_to_cart.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/content/product_search_with_category.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/provider/pos_provider.dart';
import 'package:provider/provider.dart';

class CreatePosScreen extends StatelessWidget {
  const CreatePosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("POS", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ChangeNotifierProvider(
        create: (_) => PosProvider(),
        child: Consumer<PosProvider>(
            builder: (context, provider, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    DropDownAndFormList(provider: provider,),
                    Container(
                      margin: const EdgeInsets.symmetric( horizontal: 14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductSearchWithCategory(),
                            SizedBox(height: 14,),
                            ProductListAndAddToCart(),
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