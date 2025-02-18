import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hrm_app/screens/appFlow/menu/drawer/support_policy/support_policy_provider.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class SupportPolicyScreen extends StatelessWidget {
  const SupportPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SupportPolicyProvider(),
      child: Consumer<SupportPolicyProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title:  Text(tr("support_policy")),
              elevation: 0,
            ),
            body: SingleChildScrollView(
                child: provider.contentsData?.data?.contents?.length != 0 
                    ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                      child: Html(
                        data: provider.contentsData?.data?.contents?.first.content ?? "",
                        shrinkWrap: true,
                      ),
                    ) : const NoDataFoundWidget()),
          );
        },
      ),
    );
  }
}
