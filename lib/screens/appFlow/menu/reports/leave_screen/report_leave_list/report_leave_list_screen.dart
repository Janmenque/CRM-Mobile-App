import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/leave_screen/report_leave_approvals/report_leave_approval_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';

class ReportLeaveListScreen extends StatelessWidget {
  const ReportLeaveListScreen({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: ()=> NavUtil.navigateScreen(context, const ReportLeaveApprovalScreen()),
                  dense: true,
                  leading: const FlutterLogo(
                    size:30,
                  ),
                  title: const Text('Rasheduzzaman', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                  subtitle: const Text('Project Manager'),
                  trailing: Text('$index days'),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1.2,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
