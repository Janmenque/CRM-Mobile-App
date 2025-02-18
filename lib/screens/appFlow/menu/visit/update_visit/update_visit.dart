import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/custom_widgets/custom_buttom.dart';
import 'package:hrm_app/data/model/response_visit_details.dart';
import 'package:provider/provider.dart';

import 'update_visit_provider.dart';

class UpdateVisitScreen extends StatelessWidget {
  final ResponseVisitDetails? responseVisitList;
  final int? visitID;

  const UpdateVisitScreen({Key? key, this.responseVisitList, this.visitID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UpdateVisitProvider(responseVisitList),
      child: Consumer<UpdateVisitProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title:  Text(tr("update_visit")),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                      child: Text(
                        tr("title*"),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    TextField(
                      controller: provider.visitTitleTextController,
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      decoration:  InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: tr("give_a_title_to_your_visit"),
                        hintStyle: const TextStyle(fontSize: 14),
                        isDense: true,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: provider.titleError != null,
                        child: Text(
                          provider.titleError ?? "",
                          style: const TextStyle(color: Colors.red),
                        )),
                    Visibility(
                        visible: provider.errorMassage != null &&
                            provider.titleError == null,
                        child: Text(
                          provider.errorMassage ?? "",
                          style: const TextStyle(color: Colors.red),
                        )),
                     Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                      child: Text(
                        tr("description_optional"),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    TextField(
                      controller: provider.visitDescriptionTextController,
                      maxLines: 5,
                      keyboardType: TextInputType.name,
                      decoration:  InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: tr("write_a_note"),
                        hintStyle: const TextStyle(fontSize: 14),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                     Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                      child: Text(
                        tr("phone_optional"),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                      child: InkWell(
                        onTap: () {
                          provider.pickImage(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: DottedBorder(
                                  color: Colors.blue,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(2),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  strokeWidth: 1,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                  )),
                            ),
                            Expanded(
                              flex: 4,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: provider.imageListSever?.length ?? 0,
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                      imageUrl: provider
                                              .imageListSever?[index] ??
                                          "https://www.w3schools.com/howto/img_avatar.png",
                                      placeholder: (context, url) => Center(
                                        child: Image.asset(
                                            "assets/images/placeholder_image.png"),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomButton(
                        title: tr("create_visit"),
                        clickButton: () {
                          provider.updateVisitApi(context,visitID);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
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
