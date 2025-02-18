import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_client_model/client_profile_details_model.dart';
import 'package:hrm_app/utils/res.dart';

class ProfileAddressTypeDetails extends StatelessWidget {
  const ProfileAddressTypeDetails({
    super.key, required this.profileData,
  });
  final Data? profileData;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileData?.billingAddress != null ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Billing Address", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),) ,
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                       const Expanded(
                          flex : 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Street", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                              Text("City", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                              Text("Sate", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                              Text("Zip", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            ],),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(": ${profileData?.billingAddress?.street ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:AppColors.colorPrimary),),
                              Text(": ${profileData?.billingAddress?.city ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                              Text(": ${profileData?.billingAddress?.state ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                              Text(": ${profileData?.billingAddress?.zip ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            ],),
                        ),
                      ],
                    ),
                  ],
                ) : const SizedBox(),
                const SizedBox(height : 20),
                profileData?.shippingAddress != null ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Shipping Address", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),) ,
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Street", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                              Text("City", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                              Text("Sate", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                              Text("Zip", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                            ],),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(profileData?.shippingAddress?.street ?? "N/A", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                              Text(profileData?.shippingAddress?.city ?? "N/A", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                              Text(profileData?.shippingAddress?.state ?? "N/A", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                              Text(profileData?.shippingAddress?.zip ?? "N/A", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                            ],),
                        ),
                      ],
                    ),
                  ],
                ) : const SizedBox()
              ],
            ),
          )
        ]
    );
  }
}