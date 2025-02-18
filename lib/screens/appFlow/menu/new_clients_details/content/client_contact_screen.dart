import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/email_notification_custom_switch_list.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/permission_custome_switchlist.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_contact_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';


class ClientContactListScreen extends StatelessWidget {
int clientId;
ClientContactListScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientContactProvider>(
      builder: (context, provider, _) {
        final contacts = provider.clientContactListResponse?.data?.data;
        return SingleChildScrollView(
            child:  Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Contacts", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      InkWell(
                          onTap: ()=> createClientContacts(context, provider, clientId ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8)),
                          child: const Row(
                            children: [
                              Icon(Icons.add, size: 14, color: Colors.white,),
                              Text("Create", style: TextStyle(color: Colors.white, fontSize: 12),)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric( horizontal: 12),
                  child:
                  provider.isLoading ? const CustomListShimer() :
                  contacts?.isNotEmpty == true ?
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: contacts?.length ?? 0,
                      itemBuilder: (BuildContext context, int index){
                        final data = contacts?[index].user;
                        return Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                            color: Colors.white,
                            child: Padding(
                            padding: const EdgeInsets.symmetric( vertical: 12, horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    flex : 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Name", style:  TextStyle(fontSize: 12,  fontWeight: FontWeight.bold, color: Colors.black),),
                                        Text("Email", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                        Text("Phone", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                                        Text("Position", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),

                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex : 8,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(": ${data?.name ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:AppColors.colorPrimary),),
                                        Text(": ${data?.email ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:AppColors.colorPrimary),),
                                        Text(": ${data?.phone ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:AppColors.colorPrimary),),
                                        Text(": ${data?.position ?? ""}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:AppColors.colorPrimary),),

                                      ],
                                    ),
                                  ),
                               ],),
                              ],),
                        ));}) : const NoDataFoundWidget(),
                ),
              ],
            )
        );
      }
    );
  }


void createClientContacts(BuildContext parentContext, ClientContactProvider provider, int clientId) {
  showDialog(
    context: parentContext,
    builder: (BuildContext context) {
      return ChangeNotifierProvider.value(
        value: provider,
        child: Builder(
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(12.0),
                child: Consumer<ClientContactProvider>(
                  builder: (_, provider, __) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 5),
                          const Center(
                            child:  Text(
                              "Add Contact",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          NewTextField(labelText: "Name", controller: provider.nameController,),
                          const SizedBox(height: 8,),
                          NewTextField(labelText: "Position", controller: provider.positionController,),
                          const SizedBox(height: 8,),
                          NewTextField(labelText: "Email", controller: provider.emailController,),
                          const SizedBox(height: 8,),
                          NewTextField(labelText: "Phone", controller: provider.phoneController,),
                          const SizedBox(height: 8,),
                          NewTextField(labelText: "Password", controller: provider.passwordController,),
                          const SizedBox(height: 8,),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: ()=> provider.pickProfileImageFile(context),
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
                          provider.profileImage != null ?
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 10),
                            child: Image.file(
                              provider.profileImage!,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ) : const SizedBox(),
                          PermissionCustomSwitchList(provider: provider,),
                          EmailNotificationsCustomSwitchList(provider: provider,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                            child: ElevatedButton(
                                onPressed: () {
                                  provider.clientCreateContact(context, clientId ?? 0);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff5B58FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: const Text(
                                  "Add Contract",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
}
