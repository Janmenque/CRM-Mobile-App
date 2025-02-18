
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/provider/task_comment_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/res.dart';


class TaskCommentScreen extends StatelessWidget {
  int taskId;
  TaskCommentScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCommentProvider>(
        builder: (context, provider, _) {
          final comments = provider.taskCommentListResponse?.data?.data;
          return SingleChildScrollView(
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Comments", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          InkWell(
                            onTap: ()=> createTaskComment(context, provider, taskId ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                              decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8)),
                              child: const Row(
                                children: [
                                  Icon(Icons.add, size: 14, color: Colors.white,),
                                  Text("Create", style: TextStyle(color: Colors.white, fontSize: 12),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    provider.isLoading ? const CustomListShimer() :
                    comments?.isNotEmpty == true ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: comments?.length ?? 0,
                        itemBuilder: (BuildContext context, int index){
                          final data  = comments?[index];
                          return InkWell(
                            onTap: (){},
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric( vertical: 12, horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Date Created ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              SizedBox(height: 8,),
                                              Text("Comments ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              SizedBox(height: 8,),
                                              Text("Image ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),

                                            ],
                                          ),
                                        ),

                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(": ${data?.createdAt ?? "N/A"}", style: const TextStyle(fontSize: 12,  fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              const SizedBox(height: 8,),
                                              Text(": ${data?.comment.toString() ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              const SizedBox(height: 8,),
                                              ClipRRect( borderRadius: BorderRadius.circular(12), child: CachedNetworkImage( height: 50, width: 50, fit: BoxFit.cover, imageUrl:data?.attachmentId ?? "", placeholder: (context, url) => Center( child: Image.asset("assets/images/app_logo.png"), ), errorWidget: (context, url, error) => Image.asset( "assets/images/no_image_placeholder.png", fit: BoxFit.cover, ), ), ),
                                            ],
                                          ),
                                        ),
                                      ],),
                                  ],),
                              ),
                            ),
                          );}) : const NoDataFoundWidget(),
                  ],
                ),
              )
          );
        }
    );
  }

  void createTaskComment(BuildContext parentContext, TaskCommentProvider provider, int clientId) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(12.0),
                  child: Consumer<TaskCommentProvider>(
                    builder: (_, provider, __) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 5),
                            const Text(
                              "Add Comment",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            NewTextField(
                              labelText: "Comment",
                              controller: provider.commentController,
                              maxLine: 4,
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: ()=> provider.pickProfileImageFile(context),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                            ),
                                            border: Border.all(color: Colors.grey, width: 1)
                                        ),
                                        child: const Text("Add Image", style: TextStyle(color: Colors.grey),),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF5F5F5),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        border: Border.all(color: Colors.grey, width: 1)
                                    ),
                                    child: const Text("Browse", style: TextStyle(color: Colors.grey),),
                                  ),
                                ],
                              ),
                            ),
                            provider.attachImageFile != null ?
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0, top: 10),
                              child: Image.file(
                                provider.attachImageFile!,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ) : const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (provider.commentController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Comment is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (provider.attachImageFile == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("File is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  else {
                                    provider.createTaskComment(context, taskId);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff5B58FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: const Text(
                                  "Create",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}