import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/request_leave_update/request_leave_update_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class RequestLeaveUpdate extends StatelessWidget {
  final int? requestId;

  const RequestLeaveUpdate({Key? key, this.requestId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RequestLeaveUpdateProvider(requestId),
      child: Consumer<RequestLeaveUpdateProvider>(
        builder: (context, providerUpdate, _) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                tr("request_leave_update"),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.black),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
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
                  TextField(
                    controller: providerUpdate.updateNoteController,
                    maxLines: 5,
                    keyboardType: TextInputType.name,
                    decoration:  InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: tr("write_reason"),
                      hintStyle: const TextStyle(fontSize: 14),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                   Text(
                    tr("attachment"),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      providerUpdate.updateAttachmentImage(context);
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 14),
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

                  ///When update, attachments initial imagePath will be null
                  ///First image will show from api when update
                  providerUpdate.attachmentPath != null
                      ///When update, attachments initial imagePath will be null
                      ///First image will show from api when update
                      ? Image.file(
                          providerUpdate.attachmentPath!,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          height: 60,
                          width: 60,
                          imageUrl: providerUpdate.attachment ?? "",
                          placeholder: (context, url) => Center(
                            child: Image.asset("assets/images/ic_loader.gif"),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                  const SizedBox(
                    height: 25,
                  ),
                   Text(
                    tr("substitute"),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
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
                  Container(
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
                      child: Text(
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
          );
        },
      ),
    );
  }
}
