import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/pos_cart_service.dart';
import 'package:hrm_app/data/model/crm_sales/cart.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/content/cart_product.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';


class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});
  final int subtotal = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartService>(
        builder: (context, cartProvider, _) {
          final data = cartProvider.getAllCartProduct();
          return Scaffold(
            appBar: AppBar(
              title: const  Text("Cart Product", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              leading:  Padding( padding: const EdgeInsets.only(left : 20),
                child:  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, size: 18,)),
              ),
            ),
            body: SingleChildScrollView(
              child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: cartProvider.getAllCartProduct().isNotEmpty ?
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
                              Cart? item = data[index];
                              return Slidable(
                                key: Key('$item'),
                                endActionPane: ActionPane(motion: const ScrollMotion(), children: [
                                  SlidableAction(onPressed: (context){
                                    cartProvider.removeProductFromCart(id: item.id!);
                                  },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete_outline,
                                  )
                                ],),
                                child: MyCardProductWidget(
                                  image: item.image,
                                  title: item.title,
                                  price: ((item.price ?? 1.0)  * (item.quantity ?? 1.0)),
                                  quantity: "${(item.quantity != null ? item.quantity.toString() : 1)}",
                                  incrementTap: (){
                                    if(item.quantity != null){
                                      int qty = item.quantity!;
                                      cartProvider.updateProductQuantity(quantity: qty + 1,productId: item.id!);
                                    }
                                  },
                                  decrementTap: (){
                                    if(item.quantity != null){
                                      int qty = item.quantity!;
                                      if(qty > 1){
                                        cartProvider.updateProductQuantity(quantity: qty -1,productId: item.id!);
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
                      const SizedBox(height: 14,),
                      const Text("Order Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 14),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),),],
                      ),
                      const SizedBox(height: 34,),
                    ],
                  ) :  const NoDataFoundWidget()
              ),
            ),
          );
        }
    );
  }
}



