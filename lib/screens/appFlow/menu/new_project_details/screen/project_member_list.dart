
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_member_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';



class ProjectMemberListScreen extends StatelessWidget {
  int projectId;
  ProjectMemberListScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectMemberProvider>(
        builder: (context, provider, _) {
          final members = provider.projectMemberListResponse?.data;
          return SingleChildScrollView(
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
                child: Column(
                  children: [
                    provider.isLoading ? const CustomListShimer() :
                    members?.isNotEmpty == true ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: members?.length ?? 0,
                        itemBuilder: (BuildContext context, int index){
                          final data  = members?[index];
                          return InkWell(
                              onTap: (){},
                              child: Card(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric( vertical: 6, horizontal: 12),
                                    child  : ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: ClipOval(
                                        child: CachedNetworkImage(
                                          height: 50, width: 50, fit: BoxFit.cover, imageUrl: data?.avatar ?? "",
                                          placeholder: (context, url) => Center(child: Image.asset("assets/images/app_logo.png"),),
                                          errorWidget: (context, url, error) => Image.asset("assets/images/no_image_placeholder.png",fit: BoxFit.cover,),
                                        ),
                                      ),
                                      title: Text(data?.name ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      subtitle: Text(data?.email ?? "", style: const TextStyle(fontSize: 14),),
                                    ),
                                  )));
                        }
                    )
                        : const NoDataFoundWidget(),
                  ],
                ),
              )
          );
        }
    );
  }

}