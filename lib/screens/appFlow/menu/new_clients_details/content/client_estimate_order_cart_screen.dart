import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/estimate_order_service.dart';
import 'package:hrm_app/api_service/invoice_order_service.dart';
import 'package:hrm_app/api_service/proposal_order_service.dart';
import 'package:hrm_app/data/model/client_estimate/estimateOrderCart.dart';
import 'package:hrm_app/data/model/client_invoice/invoiceOrderCart.dart';
import 'package:hrm_app/data/model/client_proposal/proposalOrderCart.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_estimate_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_invoice_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_proposal_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/content/cart_product.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';


class ClientEstimateOrderCartScreen extends StatelessWidget {
  ClientEstimateOrderCartScreen({super.key, required this.clientId, required this.wareHouseId});
  final int subtotal = 0;
  int clientId;
  int wareHouseId;
  @override
  Widget build(BuildContext context) {
    return Consumer<EstimateOrderService>(
        builder: (context, estimateOrderCartProvider, _) {
          final data = estimateOrderCartProvider.getAllEstimateCartProduct();
          return Scaffold(
            appBar: AppBar(
              title: const  Text("Estimate order cart product", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              leading:  Padding( padding: const EdgeInsets.only(left : 20),
                child:  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, size: 18,)),
              ),
            ),
            body: SingleChildScrollView(
              child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: estimateOrderCartProvider.getAllEstimateCartProduct().isNotEmpty ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      Container(
                        padding: const EdgeInsets.only( left: 12, right: 12, top: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              EstimateOrderCart? item = data[index];
                              return Slidable(
                                key: Key('$item'),
                                endActionPane: ActionPane(motion: const ScrollMotion(), children: [
                                  SlidableAction(onPressed: (context){
                                    estimateOrderCartProvider.removeProductFromCart(id: item.id!);
                                  },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete_outline,
                                  )
                                ],),
                                child: MyCardProductWidget(
                                  title: item.name,
                                  price: ((item.netUnitCost?.toDouble() ?? 1.0)  * (item.quantity ?? 1.0)),
                                  quantity: "${(item.quantity != null ? item.quantity.toString() : 1)}",
                                  incrementTap: (){
                                    if(item.quantity != null){
                                      int qty = item.quantity!;
                                      estimateOrderCartProvider.updateEstimateProductQuantity(quantity: qty + 1,productId: item.id!);
                                    }
                                  },
                                  decrementTap: (){
                                    if(item.quantity != null){
                                      int qty = item.quantity!;
                                      if(qty > 1){
                                        estimateOrderCartProvider.updateEstimateProductQuantity(quantity: qty -1,productId: item.id!);
                                      } else {
                                        Fluttertoast.showToast(msg: "Product can not be 0");
                                      }
                                    }
                                  },
                                ),
                              );
                            }
                        ),
                      ),

                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.grey),),
                          Text(" \$ ${estimateOrderCartProvider.calculateTotal().toStringAsFixed(2)}", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold,),),
                        ],
                      ),
                      const SizedBox(height: 14),
                      NewTextField(labelText: "Discount", controller: context.read<ClientCreateEstimateProvider>().discountController,),
                      const SizedBox(height: 8),
                      NewTextField(labelText: "Note", maxLine: 4, controller: context.read<ClientCreateEstimateProvider>().noteController,),
                      const SizedBox(height: 14,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        child: ElevatedButton(
                            onPressed: () {
                              final estimateCreateProvider = context.read<ClientCreateEstimateProvider>();
                              List<EstimateOrderCart> orderCartItems = estimateOrderCartProvider.getAllEstimateCartProduct();
                              estimateCreateProvider.createClientEstimate(context, clientId, orderCartItems, wareHouseId);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5B58FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ) :  const NoDataFoundWidget()
              ),
            ),
          );
        }
    );
  }
}



