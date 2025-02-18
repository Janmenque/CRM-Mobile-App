import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/discussioin_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_activity_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_email_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_file_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_member_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_milestone_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_note_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_overview_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_task_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/project_activity_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/project_discussion_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/project_email_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/project_file_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/project_member_list.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/project_milestone_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/project_note_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/project_overview_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/project_task_screen.dart';
import 'package:provider/provider.dart';



class NewProjectDetailsScreen extends StatelessWidget {
  final int projectId;
  const NewProjectDetailsScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProjectOverViewProvider(projectId)),
        ChangeNotifierProvider(create: (_) => ProjectTaskProvider(projectId)),
        ChangeNotifierProvider(create: (_) => ProjectMilestoneProvider(projectId)),
        ChangeNotifierProvider(create: (_) => ProjectEmailProvider(projectId)),
        ChangeNotifierProvider(create: (_) => ProjectFileProvider(projectId)),
        ChangeNotifierProvider(create: (_) => ProjectDiscussionProvider(projectId)),
        ChangeNotifierProvider(create: (_) => ProjectNoteProvider(projectId)),
        ChangeNotifierProvider(create: (_) => ProjectMemberProvider(projectId)),
        ChangeNotifierProvider(create: (_) => ProjectActivityProvider(projectId)),
      ],
      child: DefaultTabController(
        length: 9,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Project Details"),
            bottom: const PreferredSize(
              preferredSize: Size(double.infinity, 24),
              child: Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                    labelPadding: EdgeInsets.only(left: 0, right: 20),
                    isScrollable: true,
                    tabs: [
                      Text("Overview"),
                      Text("Tasks"),
                      Text("Milestones"),
                      Text("Emails"),
                      Text("Files"),
                      Text("Discussion"),
                      Text("Notes"),
                      Text("Members"),
                      Text("Activity"),
                    ]),
              ),
            ),
          ),
          body: TabBarView(
              children: [
                ProjectOverviewScreen(projectId: projectId),
                ProjectTaskScreen(projectId: projectId),
                ProjectMilestoneScreen(projectId: projectId),
                ProjectEmailScreen(projectId: projectId),
                ProjectFileScreen(projectId: projectId),
                ProjectDiscussionScreen(projectId: projectId),
                ProjectNoteScreen(projectId: projectId),
                ProjectMemberListScreen(projectId: projectId),
                ProjectActivityScreen(projectId: projectId),
              ]),
        ),
      ),
    );
  }
}
