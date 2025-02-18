import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/content/activity_feed_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/content/lead_attachment_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/content/lead_call_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/content/lead_email_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/content/lead_note_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/content/lead_profile_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/content/lead_reminder_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/content/lead_tag_list_screnn.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/content/lead_task_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_activity_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_attachment_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_call_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_email_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_note_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_reminder_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_tag_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_task_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/leads_profile_view_provider.dart';
import 'package:provider/provider.dart';

class LeadViewScreen extends StatelessWidget {
  int leadId;
  LeadViewScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LeadsProfileViewProvider(leadId)),
        ChangeNotifierProvider(create: (_) => LeadAttachmentProvider(leadId)),
        ChangeNotifierProvider(create: (_) => LeadEmailProvider(leadId)),
        ChangeNotifierProvider(create: (_) => LeadCallProvider(leadId)),
        ChangeNotifierProvider(create: (_) => LeadActivityProvider(leadId)),
        ChangeNotifierProvider(create: (_) => LeadNoteProvider(leadId)),
        ChangeNotifierProvider(create: (_) => LeadTaskProvider(leadId)),
        ChangeNotifierProvider(create: (_) => LeadReminderProvider(leadId)),
        ChangeNotifierProvider(create: (_) => LeadTagProvider(leadId)),
      ],
      child: DefaultTabController(
        length: 9,
        child: Scaffold(
          appBar: AppBar(
          title: const Text("Lead View"),
          bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 24),
            child: Align(
              alignment: Alignment.topLeft,
              child: TabBar(
                  labelPadding: EdgeInsets.only(left: 0, right: 20),
                  isScrollable: true,
                  tabs: [
                    Text("Profile"),
                    Text("Attachments"),
                    Text("Emails"),
                    Text("Calls"),
                    Text("Activities "),
                    Text("Notes"),
                    Text("Tasks"),
                    Text("Reminders"),
                    Text("Tags")
                  ]),
            ),
          ),
        ),
          body: TabBarView(
              children: [
                LeadProfileDetailsScreen(leadId: leadId),
                LeadAttachmentListScreen(leadId: leadId),
                LeadEmailListScreen(leadId: leadId,),
                LeadCallListScreen(leadId: leadId,),
                const LeadActivityListScreen(),
                LeadNoteListScreen(leadId: leadId,),
                LeadTaskListScreen(leadId: leadId,),
                LeadReminderListScreen(leadId: leadId,),
                LeadTagListScreen(leadId: leadId,),
              ]),
        ),
      ),
    );
  }
}
