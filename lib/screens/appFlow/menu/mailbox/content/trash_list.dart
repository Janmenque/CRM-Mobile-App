import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/provider/mailbox_provider.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';

class TrashList extends StatelessWidget {

  const TrashList({super.key, });
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => MailBoxProvider("trash"),
      child: Consumer<MailBoxProvider>(
          builder: (context, provider, _) {
            final trashList = provider.mailInboxListResponse?.data?.mailbox;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16,),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Trash", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text("Total : ${trashList?.length ?? ''}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 14,),
                          Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                          trashList?.isNotEmpty == true ?
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: trashList?.length ?? 0,
                              itemBuilder: (BuildContext context, int index){
                                final data = trashList?[index];
                                return InkWell(
                                  onTap: (){},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 14,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Sender: ${data?.sender ?? ''}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                                Text("Subject: ${data?.subject ?? ''}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                                Text("Date: ${data?.createdAt ?? ''}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                              ],
                                            ),
                                          ),
                                        ],),],),
                                );}) : const NoDataFoundWidget(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
