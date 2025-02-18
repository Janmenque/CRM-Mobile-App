import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/edit_client/edit_client_provider.dart';
import 'package:hrm_app/screens/custom_widgets/add_client_textfield.dart';
import 'package:hrm_app/screens/custom_widgets/label_text.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/res.dart';
import '../model/client_details_model.dart';

class EditClientScreen extends StatelessWidget {
  const EditClientScreen({
    super.key,
    this.clientDetails,
  });

  final ClientDetailsModel? clientDetails;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return EditClientProvider(clientDetails);
      },
      child: Consumer<EditClientProvider>(
        builder: (BuildContext context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                "Update Client",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          provider.pickImage(context);
                        },
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xFFE4E4E4),
                                        width: 8)),
                                child: provider.imagePath == null
                                    ? ClipOval(
                                        child: Image.network(
                                            clientDetails?.data?.client?.avater ?? '',
                                            fit: BoxFit.cover),
                                      )
                                    : ClipOval(
                                        child: Image.file(
                                        provider.imagePath!,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )),
                              ),
                              provider.imagePath == null
                                  ? Positioned(
                                      bottom: 6,
                                      right: 6,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.colorPrimary),
                                        child: const Icon(
                                          size: 18.0,
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Positioned(
                                      bottom: 6,
                                      right: 6,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.colorPrimary),
                                        child: const Icon(
                                          size: 18.0,
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const LavelText(
                        text: "Client's Name * ",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AddClientTextField(
                          hintText: "Enter Client's Name",
                          textController: provider.clientNameController),
                      SizedBox(
                        height: 16.h,
                      ),
                      const LavelText(
                        text: "Phne Number * ",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AddClientTextField(
                          hintText: "Enter Client's Phone Number",
                          textController: provider.clientPhoneNumberController),
                      SizedBox(
                        height: 16.h,
                      ),
                      const LavelText(
                        text: "Email * ",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AddClientTextField(
                          hintText: "Enter Client's Email",
                          textController: provider.clientEmailController),
                      SizedBox(
                        height: 16.h,
                      ),
                      const LavelText(
                        text: "Address * ",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AddClientTextField(
                          hintText: "Enter Client's Address",
                          textController: provider.clientAddressController),
                      SizedBox(
                        height: 16.h,
                      ),
                      const LavelText(
                        text: "Descriptin * ",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AddClientTextField(
                        hintText: "Write Client's description here...",
                        textController: provider.clientDescriptionController,
                        maxLine: 4,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await provider.editClient(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5B58FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            minimumSize: Size(double.infinity, 60.h),
                          ),
                          child: Text(
                            "Update Client",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
