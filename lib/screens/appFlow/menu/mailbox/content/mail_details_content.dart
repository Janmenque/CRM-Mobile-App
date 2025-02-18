
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/content/children_mail_details_content.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/provider/mail_details_provider.dart';

class DetailsContent extends StatelessWidget {
  MailDetailsProvider provider;
  DetailsContent({
    super.key, required this.provider
  });

  @override
  Widget build(BuildContext context) {
    final data = provider.mailDetailsResponse?.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data?.subject ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, ),),
        const SizedBox(height: 4,),
        Row(
          children: [
            const Icon(Icons.calendar_month, size: 16, ),
            const SizedBox(width: 4,),
            Text(data?.createdAt ?? "", style: const TextStyle(fontSize: 12,  ),),
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
                    itemCount: data?.recipients?.length ?? 0,
                    itemBuilder: (BuildContext context, index){
                      final recipient = data?.recipients?[index];
                      return Text(recipient?.email ?? "", style: const TextStyle(fontSize: 14 ),);
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
                    itemCount: data?.mailboxCc?.length ?? 0,
                    itemBuilder: (BuildContext context, index){
                      final mailboxCc = data?.recipients?[index];
                      return Text(mailboxCc?.email ?? "", style: const TextStyle(fontSize: 14 ),);
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
              itemCount: data?.attachments?.length ?? 0,
              itemBuilder: (BuildContext context, index){
                final attachment = data?.attachments?[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ClipRRect( borderRadius: BorderRadius.circular(12), child: CachedNetworkImage( height: 50, width: 50, fit: BoxFit.cover, imageUrl: attachment?.path ?? "", placeholder: (context, url) => Center( child: Image.network(attachment?.path ?? ""), ), errorWidget: (context, url, error) => Image.asset( "assets/images/no_image_placeholder.png", fit: BoxFit.cover, ), ), ),
                );
              }),
        ),

        const SizedBox(height: 8,),
        const Row(
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

        ChildrenMailDetailsContent(provider: provider),

      ],
    );
  }
}

