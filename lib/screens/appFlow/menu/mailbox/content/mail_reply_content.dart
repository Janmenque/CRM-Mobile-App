import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/provider/mail_details_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';

class MailReplyContent extends StatelessWidget {
  MailDetailsProvider provider;
  MailReplyContent({
    super.key, required this.provider
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.reply),
            SizedBox(width: 4,),
            Text("Reply", style: TextStyle(fontSize: 16 ),),
            //Icon(Icons.arrow_drop_down),
          ],
        ),
        const SizedBox(height: 14,),
        ///upload images
        InkWell(
          onTap: () => provider.pickComposeAttachment(context),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      border: Border.all(color: Colors.grey, width: 1)
                  ),
                  child: const Text("Upload Attachments", style: TextStyle(color: Colors.grey),),
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
        const SizedBox(height: 12,),
        provider.replyAttachmentImages.isNotEmpty ?
        Wrap(
          children: List.generate(provider.replyAttachmentImages.length, (index){
            return
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 14, bottom: 14),
                    child: Image.file(
                      provider.replyAttachmentImages[index],
                      height: 60, width: 60, fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: -10,
                    child: InkWell(
                      onTap: ()=> provider.removeImage(index),
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration:  BoxDecoration(
                            color:  Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Icon(Icons.close, color: Colors.red, size: 10,),
                        ),
                      ),
                    ),
                  ),
                ],
              );
          }),
        ) :
        SizedBox(
          height: 60,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index){
                return  SizedBox(
                  height: 60,
                  width: 60,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical :14.sp),
                        margin: const EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                            color: const Color(0xffF5F5F5),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: const Icon(Icons.photo_camera_back, color: Colors.grey,),
                      ),
                      Positioned(
                        right: 0,
                        top: -3,
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration:  BoxDecoration(
                              color:  Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(1, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: const Icon(Icons.close, color: Colors.black,size: 10,),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        NewTextField(labelText: "Message", maxLine: 4, controller: provider.messageController ),
      ],
    );
  }
}