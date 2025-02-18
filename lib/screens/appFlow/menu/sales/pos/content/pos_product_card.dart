import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/pos_cart_service.dart';
import 'package:hrm_app/data/model/crm_sales/cart.dart';


class PosProductCard extends StatelessWidget {
  CartService cartProvider;
  int productId;
   PosProductCard({
    super.key, required this.productId, required this.cartProvider
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          height: 50, width: 50, fit: BoxFit.cover, imageUrl: "https://assets.turbologo.com/blog/en/2021/09/10093610/photo-camera-958x575.png",
                          placeholder: (context, url) => Center(child: Image.asset("assets/images/app_logo.png"),),
                          errorWidget: (context, url, error) => Image.asset("assets/images/no_image_placeholder.png",fit: BoxFit.cover,),
                        ),
                      ),
                      const SizedBox(width: 12,),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Camera 202", style: TextStyle(fontSize: 12),),
                          Row(
                            children: [
                              Text("\$102.00", style: TextStyle(fontSize: 12),),
                              SizedBox(width: 8,),
                              Text("stock 74", style: TextStyle(fontSize: 12, color: Colors.red),),
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
                            final isAlreadyInCart = cartProvider.isProductAlreadyInCart(productId);
                           if(!isAlreadyInCart){
                             final cartProduct = Cart(
                               id: productId,
                               title: "Camera 202",
                               image: "https://assets.turbologo.com/blog/en/2021/09/10093610/photo-camera-958x575.png",
                               quantity: cartProvider.productQuantity,
                               price: 102
                             );
                             cartProvider.addProductToCart(cartProduct);
                           }  else {
                             cartProvider.removeProductFromCart(id: productId);
                           }
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: cartProvider.isProductAlreadyInCart(productId)  ?  Colors.indigo : Colors.grey.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: cartProvider.isProductAlreadyInCart(productId)
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
  }
}