import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/view/compose_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/content/important_list.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/content/inbox_list.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/content/sent_list.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/content/starred_list.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/content/trash_list.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';

class MailBoxScreen extends StatelessWidget {
  const MailBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mailbox", style: TextStyle(fontWeight: FontWeight.bold),),
          bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 24),
            child: TabBar(
                labelPadding: EdgeInsets.only(left: 0, right: 20),
                isScrollable: true,
                tabs: [
                  Text("Inbox"),
                  Text("Sent"),
                  Text("Starred"),
                  Text("important"),
                 // Text("Draft"),
                  Text("Trash"),
                ]),
          ),
        ),
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: FloatingActionButton(
            hoverColor: AppColors.colorPrimary,
            onPressed: ()=> NavUtil.navigateScreen(context, const ComposeScreen()),
            backgroundColor:AppColors.colorPrimary.withOpacity(0.5),
            child:  Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.white, size: 16,),
                  SizedBox(width: 4,),
                  Text("Compose", style: TextStyle(color:AppColors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
            children: [
              InboxList(),
              SentList(),
              StarredList(),
              ImportantList(),
              TrashList(),
            ]),
      ),
    );
  }
}
