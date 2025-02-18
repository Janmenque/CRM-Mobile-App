
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/content/mail_details_content.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/content/mail_reply_content.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/provider/mail_details_provider.dart';
import 'package:provider/provider.dart';

class MailDetailsScreen extends StatelessWidget {
  int mailBoxId;
  MailDetailsScreen({super.key, required this.mailBoxId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MailDetailsProvider(mailBoxId),
      child: Consumer<MailDetailsProvider>(
        builder: (context, provider, _) {

          return Scaffold(
            appBar: AppBar(
              title: const Text("Details", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            body: provider.mailDetailsResponse?.data != null ?
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailsContent(provider: provider),
                    MailReplyContent(provider: provider),
                    Padding(
                      padding: const EdgeInsets.symmetric( vertical: 14),
                      child: ElevatedButton(
                          onPressed: () {
                            provider.postMailReply(context, mailBoxId );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5B58FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Send",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 4,),
                              Icon(Icons.send, color: Colors.white,size: 14,)
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ) : const SizedBox(),
          );
        }
      ),
    );
  }
}

