import 'package:flutter/material.dart';

class ProjectMemberListScreen extends StatelessWidget {
  final int projectId;
  const ProjectMemberListScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return  const Center(child: Padding(
      padding: EdgeInsets.symmetric(vertical: 14.0),
      child: Text("Project member list is working"),
    ));
  }
}
