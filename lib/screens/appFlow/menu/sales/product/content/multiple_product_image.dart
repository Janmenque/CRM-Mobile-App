import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/provider/add_product_provider.dart';
import 'package:provider/provider.dart';

class MultipleProductImage extends StatelessWidget {

  const   MultipleProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddProductProvider>();
    return  provider.productImages.isNotEmpty ?
    Wrap(
      children: List.generate(provider.productImages.length, (index){
        return
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 14, bottom: 14),
                child: Image.file(
                  provider.productImages[index],
                  height: 60, width: 60, fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 5,
                top: -10,
                child: InkWell(
                  onTap: ()=> provider.removeImage(index),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration:  BoxDecoration(
                        color:  Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Icon(Icons.close, color: Colors.red, size: 10,),
                    ),
                  ),
                ),
              ),
            ],
          );
      }),
    ) :
    SizedBox(
      height: 60,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index){
            return  SizedBox(
              height: 60,
              width: 60,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(14.sp),
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                        color: const Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child: const Icon(Icons.photo_camera_back, color: Colors.grey,),
                  ),
                  Positioned(
                    right: 0,
                    top: -3,
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration:  BoxDecoration(
                          color:  Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Icon(Icons.close, color: Colors.black,size: 10,),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );

  }
}
