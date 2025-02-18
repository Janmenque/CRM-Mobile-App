import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/screen/new_project_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_list/project_list_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../utils/nav_utail.dart';
import '../../../../custom_widgets/custom_tap_bar_button.dart';
import '../../../../custom_widgets/progress_indecator_with_persentage.dart';
import '../../../../custom_widgets/project_status_card.dart';
import '../../clients/model/client_details_model.dart';
import '../project_details/project_details_screen.dart';

class ProjectListContent extends StatelessWidget {
  final CrmProjectListProvider provider;
  const ProjectListContent({
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
      child: ListView.builder(
          itemCount: provider.listOfProjects.length,
          itemBuilder: (BuildContext context, int index) {
            final data = provider.listOfProjects[index];
            List<Widget> users = [];
            for (int i = 0; i < data.members!.length; i++) {
              users.add(Positioned(
                left: i * 15,
                top: 0.0,
                bottom: 0.0,
                child: InkWell(
                  onTap: (){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title:  Text("Name : ${data.members!.elementAt(i).name ?? ""}"),
                        content: Text("Designation : ${data.members!.elementAt(i).designation}\nDepartment : ${data.members!.elementAt(i).department ?? ""}\nPhone : ${data.members!.elementAt(i).phone ?? ""}\nemail : ${data.members!.elementAt(i).email ?? ""}"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    width: 30.0.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                '${data.members!.elementAt(i).avatar}'))),
                    child: const SizedBox.shrink(),
                  ),
                ),
              ));
            }
            return  ProjectStatusCard(
              ontap: () {
                Project project = Project(
                  id: data.id,
                  name: data.title,
                  status: data.status,
                  color: data.color,

                );
                NavUtil.navigateScreen(context, NewProjectDetailsScreen(projectId: project.id ?? 0,));
              },
              tapBarButton1: CustomTapBarButton(
                buttonColor: const Color(0xffF4EFFD),
                textColor: const Color(0xff5B58FF),
                buttonText: data.status,
                borderColor: const Color(0xffF4EFFD),
              ),
              tapBarButton2: CustomTapBarButton(
                buttonColor: const Color(0xffFDEFEF),
                textColor: const Color(0xffE96161),
                buttonText: data.priority,
                borderColor: const Color(0xffFDEFEF),
              ),
              startData: data.dateRange,
              rightIconArrowColor: const Color(0xff00606F),
              projectName: data.title,
              usersImage: users,
              userCount: data.userCount,
              actualCount: data.actualCount,
              progressBar: ProgressIndeccatorWithPersentage(
                persentageActiveColor:
                const Color(0xff00606F),
                persentageDisebleColor:
                const Color(0xffEAEAEA),
                activeContainerWidth: ((ScreenUtil.defaultSize.width - 80.0) * double.parse('${data.progress}'))/100,
                deActivetContainerWidth: (ScreenUtil.defaultSize.width- 80.0) - ((ScreenUtil.defaultSize.width - 85.0) * double.parse('${data.progress}'))/100,
                persentage: "${data.progress ?? 0}%",
              ),
            );
          }),
    );
  }
}