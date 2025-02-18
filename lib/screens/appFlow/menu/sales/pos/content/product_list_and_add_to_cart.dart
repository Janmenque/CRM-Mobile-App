import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/pos_cart_service.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/content/pos_product_card.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/view/pos_cart_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';

class ProductListAndAddToCart extends StatelessWidget {
  const ProductListAndAddToCart({super.key,});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartService>(
        builder: (context, cartProvider, _)  {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Product List", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            const SizedBox(height: 14,),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder:(BuildContext context, int index) {
                  return PosProductCard(cartProvider : cartProvider, productId: index ?? 1,);
                }),
            cartProvider.getAllCartProduct().isNotEmpty ?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ElevatedButton(
                        onPressed: () {
                          NavUtil.navigateScreen(context, const MyCartScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff5B58FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Go to cart", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                            const SizedBox(width: 8,),
                            const Icon(Icons.shopping_cart_outlined, color: Colors.white,),
                            const SizedBox(width: 8,),
                            Text("( ${cartProvider.getAllCartProduct().length} )", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                          ],
                        )),
                  ) : const SizedBox(),
          ],
        );
      }
    );
  }
}