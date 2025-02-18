import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/provider/task_checklist_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/provider/task_comment_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/provider/task_file_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/provider/task_info_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/provider/task_reminder_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/provider/task_timer_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/screen/task_check_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/screen/task_comment_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/screen/task_details_info_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/screen/task_file_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/screen/task_reminder_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/screen/task_timer_screen.dart';
import 'package:provider/provider.dart';



class NewTaskDetailsScreen extends StatelessWidget {
  final int taskId;
  const NewTaskDetailsScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskInfoProvider(taskId)),
        ChangeNotifierProvider(create: (_) => TaskCommentProvider(taskId)),
        ChangeNotifierProvider(create: (_) => TaskReminderProvider(taskId)),
        ChangeNotifierProvider(create: (_) => TaskCheckListProvider(taskId)),
        ChangeNotifierProvider(create: (_) => TaskTimerProvider(taskId)),
        ChangeNotifierProvider(create: (_) => TaskFileProvider(taskId)),
      ],
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Task Details"),
            bottom: const PreferredSize(
              preferredSize: Size(double.infinity, 24),
              child: Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                    labelPadding: EdgeInsets.only(left: 0, right: 20),
                    isScrollable: true,
                    tabs: [
                      Text("Details"),
                      Text("Comments"),
                      Text("Reminders"),
                      Text("Checklist"),
                      Text("Timer"),
                      Text("Files"),
                    ]),
              ),
            ),
          ),
          body: TabBarView(
              children: [
                TaskDetailsInfoScreen(taskId: taskId),
                TaskCommentScreen(taskId: taskId),
                TaskReminderScreen(taskId: taskId),
                TaskCheckListScreen(taskId: taskId),
                TaskTimerScreen(taskId: taskId),
                TaskFileScreen(taskId: taskId),
              ]),
        ),
      ),
    );
  }
}
