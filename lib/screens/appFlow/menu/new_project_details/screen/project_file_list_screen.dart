
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_email_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_file_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/res.dart';


class ProjectFileScreen extends StatelessWidget {
  int projectId;
  ProjectFileScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectFileProvider>(
        builder: (context, provider, _) {
          final files = provider.projectFileListResponse?.data?.data;
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
                          const Text(" File", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          InkWell(
                            onTap: ()=> createProjectFile(context, provider, projectId ),
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
                    files?.isNotEmpty == true ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: files?.length ?? 0,
                        itemBuilder: (BuildContext context, int index){
                          final data  = files?[index];
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
                                              Text("Subject ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Last Activity ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Comments ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                              Text("Date Created ", style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                                            ],
                                          ),
                                        ),

                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(": ${data?.subject ?? "N/A"}", style: const TextStyle(fontSize: 12,  fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.lastActivity ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.commentsCount.toString() ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
                                              Text(": ${data?.createdAt ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.colorPrimary),),
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

  void createProjectFile(BuildContext parentContext, ProjectFileProvider provider, int clientId) {
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
                  child: Consumer<ProjectFileProvider>(
                    builder: (_, provider, __) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 5),
                            const Text(
                              "Add File",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            NewTextField(
                              labelText: "Subject",
                              controller: provider.subjectController,
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
                                  if (provider.subjectController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Note is required."),
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
                                    provider.createProjectFile(context, projectId);
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