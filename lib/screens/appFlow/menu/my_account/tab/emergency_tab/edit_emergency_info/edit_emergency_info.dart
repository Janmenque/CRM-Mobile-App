import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/response_emergency.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/emergency_tab/edit_emergency_info/edit_emergency_provider.dart';
import 'package:provider/provider.dart';

class EditEmergencyInfo extends StatelessWidget {
  final ResponseEmergency? emergencyInfo;

 const EditEmergencyInfo({Key? key, this.emergencyInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditEmergencyProvider(emergencyInfo),
      child: Consumer<EditEmergencyProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                'Emergency Info Edit',
              ),
            ),
            body: SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.nameTextController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                        hintText: "Enter Name",
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Mobile Number",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.mobileTextController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                        hintText: "Enter Mobile Number",
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: context.watch<EditEmergencyProvider>().emergencyNumberError != null,
                        child: Text(
                          context.watch<EditEmergencyProvider>().emergencyNumberError ?? "",
                          style: const TextStyle(color: Colors.red),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Relationship",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.relationshipTextController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                        hintText: "Enter Relationship",
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          provider.updateEditEmergencyInfo(context);
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Text('Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

