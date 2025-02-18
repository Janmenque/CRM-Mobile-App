import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/all_leave_request_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_note/create_leave_request_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class CreateLeaveRequest extends StatelessWidget {
  final String? starDate;
  final String? endDate;
  final int? leaveTypeId;

  const CreateLeaveRequest({super.key, this.starDate, this.endDate, this.leaveTypeId});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    CreateLeaveRequestProvider provider =
        context.watch<CreateLeaveRequestProvider>();

    AllLeaveRequestProvider providerUpdate =
        context.watch<AllLeaveRequestProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          starDate != null ? tr("request_leave") : tr("request_leave_update"),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, color: AppColors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                tr("note"),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: formKey,
                child: TextFormField(
                  controller: starDate != null
                      ? provider.noteTextController
                      : providerUpdate.updateNoteController,
                  maxLines: 5,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Write Reason",
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr("this_field_is_required");
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
               Text(
                tr("attachment"),
                style:
                    const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  if (starDate != null) {
                    provider.pickAttachmentImage(context);
                  } else {
                    providerUpdate.updateAttachmentImage(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      style: BorderStyle.solid,
                      width: 0.0,
                    ),
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: DottedBorder(
                    color: const Color(0xffC7C7C7),
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(3),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                    strokeWidth: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Icon(
                          Icons.upload_file,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          tr("upload_your_file"),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              starDate != null
                  ? Container(
                      child: provider.attachmentPath == null
                          ? const SizedBox()
                          : Image.file(
                              provider.attachmentPath!,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                    )
                  : providerUpdate.attachmentPath != null

                      ? Image.file(
                          providerUpdate.attachmentPath!,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          providerUpdate.attachment!,
                          height: 60,
                          width: 60,
                        ),
              const SizedBox(
                height: 25,
              ),
               Text(
                tr("substitute"),
                style:
                    const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              starDate != null
                  ? InkWell(
                      onTap: () => providerUpdate.getAllUserData(context),
                      child: Card(
                        child: ListTile(
                          title: Text(providerUpdate.allUserData?.name! ??
                              providerUpdate
                                  .leaveDetails?.data?.substitute?.name ??
                              tr("add_a_Substitute")),
                          subtitle: Text(
                              providerUpdate.allUserData?.designation! ??
                                  providerUpdate.leaveDetails?.data?.substitute
                                      ?.designation ??
                                  tr("add_a_Designation")),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(providerUpdate
                                    .allUserData?.avatar! ??
                                providerUpdate
                                    .leaveDetails?.data?.substitute?.avatar ??
                                'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                          ),
                          trailing: const Icon(Icons.edit),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () => providerUpdate.getAllUserData(context),
                      child: Card(
                        child: ListTile(
                          title: Text(providerUpdate.allUserData?.name! ??
                              providerUpdate
                                  .leaveDetails?.data?.substitute?.name ??
                              tr("add_a_Substitute")),
                          subtitle: Text(
                              providerUpdate.allUserData?.designation! ??
                                  providerUpdate.leaveDetails?.data?.substitute
                                      ?.designation ??
                                  tr("add_a_Designation")),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(providerUpdate
                                    .allUserData?.avatar! ??
                                providerUpdate
                                    .leaveDetails?.data?.substitute?.avatar ??
                                'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                          ),
                          trailing: const Icon(Icons.edit),
                        ),
                      ),
                    ),

              const SizedBox(
                height: 25,
              ),
              starDate != null
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(

                        onPressed: () async{
                          if(formKey.currentState!.validate()){
                            provider.createLeaveRequest(context, starDate, endDate,
                                leaveTypeId, providerUpdate.allUserData?.id);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child:  Text(tr("next"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            )),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await providerUpdate.updateLeaveRequest(context);
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child:  Text(
                          tr("update"),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
