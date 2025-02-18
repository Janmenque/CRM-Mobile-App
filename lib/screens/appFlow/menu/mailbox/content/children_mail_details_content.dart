import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/provider/mail_details_provider.dart';

class ChildrenMailDetailsContent extends StatelessWidget {
  MailDetailsProvider provider;
  ChildrenMailDetailsContent({
    super.key,
    required this.provider
  });

  @override
  Widget build(BuildContext context) {
    final data = provider.mailDetailsResponse?.data;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data?.childrens?.length ?? 0,
        itemBuilder: (BuildContext context, index){
          final childrenData = data?.childrens?[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(childrenData?.subject ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, ),),
              const SizedBox(height: 4,),
              Row(
                children: [
                  const Icon(Icons.calendar_month, size: 16, ),
                  const SizedBox(width: 4,),
                  Text(childrenData?.createdAt ?? "", style: const TextStyle(fontSize: 12,  ),),
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("To : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, ),),
                  Expanded(
                      child:ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: childrenData?.recipients?.length ?? 0,
                          itemBuilder: (BuildContext context, index){
                            final childrenRecipient = childrenData?.recipients?[index];
                            return Text(childrenRecipient?.email ?? "", style: const TextStyle(fontSize: 14 ),);
                          })
                  ),
                ],
              ),
              const SizedBox(width: 4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("CC : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, ),),
                  Expanded(
                      child:ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: childrenData?.mailboxCc?.length ?? 0,
                          itemBuilder: (BuildContext context, index){
                            final childrenMailboxCc = childrenData?.recipients?[index];
                            return Text(childrenMailboxCc?.email ?? "", style: const TextStyle(fontSize: 14 ),);
                          })
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              const Text("Attachments", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, ),),
              const SizedBox(height: 8,),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: childrenData?.attachments?.length ?? 0,
                    itemBuilder: (BuildContext context, index){
                      final childrenAttachment = childrenData?.attachments?[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect( borderRadius: BorderRadius.circular(12), child: CachedNetworkImage( height: 50, width: 50, fit: BoxFit.cover, imageUrl: childrenAttachment?.path ?? "", placeholder: (context, url) => Center( child: Image.network(childrenAttachment?.path ?? ""), ), errorWidget: (context, url, error) => Image.asset( "assets/images/no_image_placeholder.png", fit: BoxFit.cover, ), ), ),
                      );
                    }),
              ),

              const SizedBox(height: 8,),
              const  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Message : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, ),),
                  Expanded(child: Text("sdfdsfsdf43 56345gdg sdfdsfsdf43 5634 5gdg sdfdsf sdf4356345 gdg sdfdsfsdf4356 345gdg", style: TextStyle(fontSize: 14 ),)),
                ],
              ),
              const SizedBox(height: 12,),
              Container(
                width: double.infinity,
                height: 0.2,
                color: Colors.black,
              ),
              const SizedBox(height: 12,),
            ],
          );
        });
  }
}