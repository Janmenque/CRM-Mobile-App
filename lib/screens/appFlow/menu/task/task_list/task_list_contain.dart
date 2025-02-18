
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/screen/new_task_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_list/task_list_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../utils/nav_utail.dart';
import '../task_details/task_details_screen.dart';
import 'content/task_assign_card_with_date.dart';

class TaskListContent extends StatelessWidget {
  final CrmTaskListProvider provider;
  const TaskListContent({
    super.key, required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(),
      footer: CustomFooter(
        builder: ( context, mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  const Text("Pull up load");
          }
          else if(mode==LoadStatus.loading){
            body =  const CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = const Text("Load Failed!Click retry!");
          }
          else if(mode == LoadStatus.canLoading){
            body = const Text("release to load more");
          }
          else{
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      controller: provider.refreshController,
      onRefresh: provider.loadItems,
      onLoading: provider.loadMoreItems,
      child:  ListView.builder(
          itemCount: provider.listOfTask.length ,
          itemBuilder: (BuildContext context, int index) {
            final data = provider.listOfTask[index];
            return TaskAssignListCardWithDate(
              onTap: () {
                NavUtil.navigateScreen(
                  context,
                  NewTaskDetailsScreen(taskId: data.id!),
                );
              },
              userCount: data.usersCount,
              userData: data,
              taskName: data.title,
              tapButtonColor: const Color(0xff5B58FF),
              taskStartDate: data.dateRange,
            );
          }),
    );
  }
}