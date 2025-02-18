
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_activity_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_file_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/res.dart';


class ProjectActivityScreen extends StatelessWidget {
  int projectId;
  ProjectActivityScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectActivityProvider>(
        builder: (context, provider, _) {
          final activities = provider.projectActivityListResponse?.data?.data;
          return SingleChildScrollView(
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
                child: Column(
                  children: [
                    provider.isLoading ? const CustomListShimer() :
                    activities?.isNotEmpty == true ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: activities?.length ?? 0,
                        itemBuilder: (BuildContext context, int index){
                          final data  = activities?[index];
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
                                         height: 50, width: 50, fit: BoxFit.cover, imageUrl: data?.user?.avatar ?? "",
                                            placeholder: (context, url) => Center(child: Image.asset("assets/images/app_logo.png"),),
                                            errorWidget: (context, url, error) => Image.asset("assets/images/no_image_placeholder.png",fit: BoxFit.cover,),
                                            ),
                                          ),
                                      title: Row(
                                        children: [
                                          Text(data?.user?.name ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                         // const SizedBox(width: 06),
                                        //  Text(data?.createdAt.toString() ?? "", style: const TextStyle(fontSize: 12),),
                                        ],
                                      ),
                                      subtitle: Text(data?.description ?? "", style: const TextStyle(fontSize: 14),),
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