import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_appointment/appointment_user_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/crm_appoinment/provider/create_appointment_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:provider/provider.dart';


class CreateAppointmentScreen extends StatelessWidget {
  const CreateAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddAppointmentProvider(),
      child: Consumer<AddAppointmentProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Create Appointment", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric( horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8,),
                    NewTextField( labelText: "Title", controller: provider.titleController,),
                    const SizedBox(height: 8,),
                    NewTextField( labelText: "Description ", maxLine: 4, controller: provider.descriptionController,),
                    const SizedBox(height: 8,),
                    NewTextField( labelText: "Location ", controller: provider.locationController,),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: ()=> provider.pickAttachmentFile(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                    border: Border.all(color: Colors.grey, width: 1)
                                ),
                                child: const Text("Add Image", style: TextStyle(color: Colors.grey),),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            decoration: BoxDecoration(
                                color: const Color(0xffF5F5F5),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                border: Border.all(color: Colors.grey, width: 1)
                            ),
                            child: const Text("Browse", style: TextStyle(color: Colors.grey),),
                          ),
                        ],
                      ),
                    ),
                    provider.imageFile != null ?
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 10),
                      child: Image.file(
                        provider.imageFile!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ) : const SizedBox(),
                    const SizedBox(height: 14,),
                    InkWell(
                      onTap: () => provider.selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                        margin: const EdgeInsets.symmetric( horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text( provider.date ??  "Date Schedule",style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                            const Icon(Icons.calendar_month_outlined, color: Colors.grey,)
                          ],
                        ),
                      ),),
                    const SizedBox(height: 14,),
                    CustomDropdown<AppointmentUser>(
                      value: provider.appointmentUser,
                      labelText: 'Appointment with',
                      items: provider.appointmentListResponse?.data ?? [],
                      onChanged: (AppointmentUser? newValue) {
                        provider.selectAppointmentUser(newValue!);
                      },
                      itemLabelBuilder: (AppointmentUser value) => value.name ?? '',
                    ),
                    const SizedBox(height: 14,),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric( horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Start Time", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4,),
                                InkWell(
                                  onTap: () async{
                                    final pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      provider.selectStartTime(pickedTime);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey, width: 1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(  provider.formatTime(provider.startTime) ,style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                                        const Icon(Icons.watch_later_outlined, color: Colors.grey,)
                                      ],
                                    ),
                                  ),),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric( horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("End Time", style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                                SizedBox(height: 4,),
                                InkWell(
                                  onTap: () async {
                                    final pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      provider.selectEndTime(pickedTime);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey, width: 1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(  provider.formatTime(provider.endTime) ,style: const  TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                                        const Icon(Icons.watch_later_outlined, color: Colors.grey,)
                                      ],
                                    ),
                                  ),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                   
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                      child: ElevatedButton(
                          onPressed: () {
                            provider.createAppointment(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5B58FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            "Create Appointment",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            )
          );
        }
      ),
    );
  }



}
