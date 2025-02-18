import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/estimate_order_service.dart';
import 'package:hrm_app/api_service/proposal_order_service.dart';
import 'package:hrm_app/data/model/client_estimate/estimateOrderCart.dart';
import 'package:hrm_app/data/model/client_proposal/proposalOrderCart.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_estimate_order_cart_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_proposal_order_cart_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_estimate_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_proposal_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';

class ClientEstimateProductList extends StatelessWidget {

  ClientCreateEstimateProvider? clientCreateEstimateProvider;
  int clientId;
  int wareHouseId;

  ClientEstimateProductList({super.key, this.clientCreateEstimateProvider, required this.clientId, required this.wareHouseId});

  @override
  Widget build(BuildContext context) {
    return Consumer<EstimateOrderService>(
        builder: (context, estimateOrderCartProvider, _)  {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Product List", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              context.read<ClientCreateEstimateProvider>().clientInvoiceProductListResponse?.data != null
                  ? const SizedBox() :
              const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical:  30),
                child: Center(child: Text( textAlign: TextAlign.center, "Select Warehouse for get the product list", style: TextStyle(fontSize: 12),)),
              ),
              const SizedBox(height: 14,),
              context.read<ClientCreateEstimateProvider>().isLoading == true ? const CustomListShimer() :
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: clientCreateEstimateProvider?.clientInvoiceProductListResponse?.data?.length ?? 0,
                  itemBuilder:(BuildContext context, int index) {
                    final estimateProduct = clientCreateEstimateProvider?.clientInvoiceProductListResponse?.data?[index];
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(8),
                                  //   child: CachedNetworkImage(
                                  //     height: 50, width: 50, fit: BoxFit.cover, imageUrl: "https://assets.turbologo.com/blog/en/2021/09/10093610/photo-camera-958x575.png",
                                  //     placeholder: (context, url) => Center(child: Image.asset("assets/images/app_logo.png"),),
                                  //     errorWidget: (context, url, error) => Image.asset("assets/images/no_image_placeholder.png",fit: BoxFit.cover,),
                                  //   ),
                                  // ),
                                  const SizedBox(width: 12,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(estimateProduct?.name ?? "", style: const TextStyle(fontSize: 12),),
                                      Row(
                                        children: [
                                          Text("\$${estimateProduct?.price ?? ""}", style: const TextStyle(fontSize: 12),),
                                          const SizedBox(width: 8,),
                                          Text("Code No : ${estimateProduct?.code ?? ""}", style: const TextStyle(fontSize: 12, color: Colors.orange),),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right : 8.0),
                                child: InkWell(
                                  onTap: () {
                                    final isAlreadyInCart = estimateOrderCartProvider.isProductAlreadyInCart(estimateProduct?.id ?? 0);
                                    if(!isAlreadyInCart){
                                      final cartProduct = EstimateOrderCart(
                                        name: estimateProduct?.name,
                                        id: estimateProduct?.id,
                                        quantity: estimateOrderCartProvider.productQuantity,
                                        netUnitCost: estimateProduct?.price,


                                      );
                                      estimateOrderCartProvider.addProductToEstimateOrderCart(cartProduct);
                                    }  else {
                                      estimateOrderCartProvider.removeProductFromCart(id: estimateProduct?.id ?? 0);
                                    }
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                      color: estimateOrderCartProvider.isProductAlreadyInCart( estimateProduct?.id ?? 0)  ?  Colors.indigo : Colors.grey.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: estimateOrderCartProvider.isProductAlreadyInCart( estimateProduct?.id ?? 0)
                                          ? const Icon(Icons.check, color: Colors.white, size: 14)
                                          : const Icon(Icons.add, color: Colors.indigo, size: 14),
                                    ),
                                  ),),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }),

              estimateOrderCartProvider.getAllEstimateCartProduct().isNotEmpty ?
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                    onPressed: () {
                      NavUtil.navigateScreen(context, ClientEstimateOrderCartScreen(clientId: clientId, wareHouseId: wareHouseId,));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5B58FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Next", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 8,),
                        const Icon(Icons.skip_next_outlined, color: Colors.white,),
                        const SizedBox(width: 8,),
                        Text("( ${estimateOrderCartProvider.getAllEstimateCartProduct().length} )", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                      ],
                    )),
              ) : const SizedBox(),
            ],
          );
        }
    );
  }
}