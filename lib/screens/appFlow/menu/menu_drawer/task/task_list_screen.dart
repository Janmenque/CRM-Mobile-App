import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/menu_drawer/task/task_create.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';

class TaskListScreenHrm extends StatelessWidget {
  const TaskListScreenHrm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: () => NavUtil.navigateScreen(context, const TaskCreate()),
      ),
      appBar: AppBar(
        title: const Text('Tasks List'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.more_horiz,
                          color: AppColors.colorPrimary)),
                  const Row(
                    children:  [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Task Management UI Component, Where Team Can Update Their',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildBottomRow(
                                iconData: Icons.calendar_today_outlined,
                                title: '21 Mar'),
                            buildBottomRow(iconData: Icons.message, title: '3'),
                            buildBottomRow(
                                iconData: Icons.attach_file, title: '7'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://www.w3schools.com/howto/img_avatar.png'),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://www.w3schools.com/howto/img_avatar.png'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child:
                        Icon(Icons.more_horiz, color: AppColors.colorPrimary),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Task Management UI Component, Where Team Can Update Their, Task Management UI Component, Where Team Can Update',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildBottomRow(
                                iconData: Icons.calendar_today_outlined,
                                title: '21 Mar'),
                            buildBottomRow(iconData: Icons.message, title: '3'),
                            buildBottomRow(
                                iconData: Icons.attach_file, title: '7'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://www.w3schools.com/howto/img_avatar.png'),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://www.w3schools.com/howto/img_avatar.png'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row buildBottomRow({IconData? iconData, String? title}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          iconData,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(title!)
      ],
    );
  }
}
