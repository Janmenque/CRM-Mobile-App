
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/crm_appoinment/provider/appointment_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/crm_appoinment/view/create_appoinment_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class AppointmentListScreen extends StatelessWidget {
  const AppointmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CrmAppointmentListProvider>(
        builder: (context, provider, _) {
          final appointments = provider.crmAppointmentListResponse?.data?.items;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Appointment List", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProductCreateAndSearchContent(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CreateAppointmentScreen()));
                        }
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Appointments", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text("Total : ${appointments?.length ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),

                          appointments?.isNotEmpty == true ?
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: appointments?.length ?? 0,
                              itemBuilder: (BuildContext context, int index){
                                final data = appointments?[index];
                                return InkWell(
                                  onTap: (){},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 14,),
                                      Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                                      const SizedBox(height: 14,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Title: ${data?.title ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Appointment With: ${data?.appoinmentWith ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Start Date : ${data?.startAt ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("End Date : ${data?.endAt ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              Text("Location : ${data?.location ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              InkWell(
                                                onTap: () {},
                                                child: Row(
                                                  children: [
                                                    const Text("Status : ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                                    Text(data?.status ?? "", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            child: PopupMenuButton(
                                              iconSize: 18,
                                              icon: const Icon(Icons.more_vert_rounded, color: Colors.grey,),
                                              onSelected: (value) {},
                                              itemBuilder: (BuildContext context) => [],
                                            ),
                                          ),],),],),
                                );}) : const NoDataFoundWidget(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
