import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../clients/model/project_details_model.dart';
import 'attachment_item.dart';


class AttachmentTabView extends StatelessWidget {

  final ProjectDetails? project;

  const AttachmentTabView({Key? key,this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 14.w),
      shrinkWrap: true,
      itemCount: project?.files?.length,
      itemBuilder: (BuildContext context, int index) {
        return AttachmentItem(file: project?.files?.elementAt(index),);
      },
    );
  }
}