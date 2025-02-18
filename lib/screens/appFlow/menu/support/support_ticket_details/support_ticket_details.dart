import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/support/support_ticket_details/support_ticket_details_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class SupportTicketDetails extends StatelessWidget {
  final int? supportId;

  const SupportTicketDetails({Key? key, this.supportId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SupportTicketDetailsProvider(supportId),
      child: Consumer<SupportTicketDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              title: Text(
                tr('support_ticket_details'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Text(
                      tr("id"),
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          provider.responseSupportDetails?.data?.subject ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(int.parse(provider
                                      .responseSupportDetails?.data?.typeColor ??
                                  "0xFF000000")),
                              style: BorderStyle.solid,
                              width: 3.0,
                            ),
                            color: Color(int.parse(provider
                                    .responseSupportDetails?.data?.typeColor ??
                                "0xFF000000")),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DottedBorder(
                            color: Colors.white,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            strokeWidth: 1,
                            child: Text(
                              provider.responseSupportDetails?.data?.typeName ??
                                  "",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(int.parse(provider
                                      .responseSupportDetails
                                      ?.data
                                      ?.priorityColor ??
                                  "0xFF000000")),
                              style: BorderStyle.solid,
                              width: 3.0,
                            ),
                            color: Color(int.parse(provider.responseSupportDetails
                                    ?.data?.priorityColor ??
                                "0xFF000000")),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DottedBorder(
                            color: Colors.white,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            strokeWidth: 1,
                            child: Text(
                              provider.responseSupportDetails?.data
                                      ?.priorityName ??
                                  "",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                     Text(
                      tr("created_on"),
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      provider.responseSupportDetails?.data?.date ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                     Text(
                      tr("details"),
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      provider.responseSupportDetails?.data?.description ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                     Text(
                      tr("photos"),
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.responseSupportDetails?.data?.attachments?.length ?? 0,
                          itemBuilder: (BuildContext context, int index){
                            return  Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CachedNetworkImage(
                                height: 200,
                                width : 150,
                                fit: BoxFit.cover,
                                imageUrl: provider.responseSupportDetails?.data?.attachments?[index].attachmentId ?? "",
                                placeholder: (context, url) => Center(
                                  child: Image.asset(
                                      "assets/images/placeholder_image.png"),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/images/placeholder_image.png"),
                              ),
                            );
                          }),
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
