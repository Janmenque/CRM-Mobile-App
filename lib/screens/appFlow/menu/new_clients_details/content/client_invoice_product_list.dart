import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/invoice_order_service.dart';
import 'package:hrm_app/data/model/client_invoice/invoiceOrderCart.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_invoice_order_cart_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_invoice_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';

class ClientInvoiceProductList extends StatelessWidget {

  ClientCreateInvoiceProvider? clientCreateInvoiceProvider;
  int clientId;
  int wareHouseId;

  ClientInvoiceProductList({super.key, this.clientCreateInvoiceProvider, required this.clientId, required this.wareHouseId});

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceOrderService>(
        builder: (context, invoiceOrderCartProvider, _)  {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Product List", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              context.read<ClientCreateInvoiceProvider>().clientInvoiceProductListResponse?.data != null
                  ? const SizedBox() :
              const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical:  30),
                child: Center(child: Text( textAlign: TextAlign.center, "Select Warehouse for get the product list", style: TextStyle(fontSize: 12),)),
              ),
              const SizedBox(height: 14,),
              context.read<ClientCreateInvoiceProvider>().isLoading == true ? const CustomListShimer() :
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: clientCreateInvoiceProvider?.clientInvoiceProductListResponse?.data?.length ?? 0,
                  itemBuilder:(BuildContext context, int index) {
                    final invoiceProduct = clientCreateInvoiceProvider?.clientInvoiceProductListResponse?.data?[index];
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
                                      Text(invoiceProduct?.name ?? "", style: const TextStyle(fontSize: 12),),
                                      Row(
                                        children: [
                                          Text("\$${invoiceProduct?.price ?? ""}", style: const TextStyle(fontSize: 12),),
                                          const SizedBox(width: 8,),
                                          Text("Code No : ${invoiceProduct?.code ?? ""}", style: const TextStyle(fontSize: 12, color: Colors.orange),),
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
                                    final isAlreadyInCart = invoiceOrderCartProvider.isProductAlreadyInCart(invoiceProduct?.id ?? 0);
                                    if(!isAlreadyInCart){
                                      final cartProduct = InvoiceOrderCart(
                                          name: invoiceProduct?.name,
                                          id: invoiceProduct?.id,
                                          quantity: invoiceOrderCartProvider.productQuantity,
                                          netUnitCost: invoiceProduct?.price,


                                      );
                                      invoiceOrderCartProvider.addProductToInvoiceOrderCart(cartProduct);
                                    }  else {
                                      invoiceOrderCartProvider.removeProductFromCart(id: invoiceProduct?.id ?? 0);
                                    }
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                      color: invoiceOrderCartProvider.isProductAlreadyInCart( invoiceProduct?.id ?? 0)  ?  Colors.indigo : Colors.grey.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: invoiceOrderCartProvider.isProductAlreadyInCart( invoiceProduct?.id ?? 0)
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

              invoiceOrderCartProvider.getAllInvoiceCartProduct().isNotEmpty ?
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                    onPressed: () {
                      NavUtil.navigateScreen(context, ClientInvoiceOrderCartScreen(clientId: clientId, wareHouseId: wareHouseId,));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5B58FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text("Next", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                         SizedBox(width: 8,),
                         Icon(Icons.skip_next_outlined, color: Colors.white,),
                      ],
                    )),
              ) : const SizedBox(),
            ],
          );
        }
    );
  }
}