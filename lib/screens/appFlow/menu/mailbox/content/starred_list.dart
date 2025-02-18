import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/provider/mailbox_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/view/mail_details_screen.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';

class StarredList extends StatelessWidget {

  const StarredList({super.key, });
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => MailBoxProvider("starred"),
      child: Consumer<MailBoxProvider>(
          builder: (context, provider, _) {
            final starredList = provider.mailInboxListResponse?.data?.mailbox;
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
                              const Text("Starred", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text("Total : ${starredList?.length ?? ''}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 14,),
                          Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.grey,),
                          starredList?.isNotEmpty == true ?
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: starredList?.length ?? 0,
                              itemBuilder: (BuildContext context, int index){
                                final data = starredList?[index];
                                return InkWell(
                                  onTap: (){
                                    NavUtil.navigateScreen(context, MailDetailsScreen(mailBoxId: data?.id ?? 0,));
                                  },
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
                                                Text("Date: ${data?.createdAt ?? ''}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Subject : ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                                    data?.childrenCount != 0 ? const Icon(Icons.reply, color: Colors.grey, size: 12,) : const SizedBox(),
                                                    data?.childrenCount != 0 ?   Text(" (${data?.childrenCount.toString() ?? ""}) ", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),)  : const SizedBox(),
                                                    Expanded(child: Text(data?.subject ?? '', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                              onTap : (){
                                                provider.updateStatus(context, "starred", [data?.id ?? 0], 'starred', data?.isStarred == 0 ? 1 : 0 );
                                              },
                                              child: data?.isStarred == 1
                                                  ? const Icon(Icons.star, size: 18, color: Colors.amber,)
                                                  : const Icon(Icons.star_border_outlined, size: 18, color: Colors.amber,)),

                                          const SizedBox(width: 08,),
                                          InkWell(
                                              onTap : (){
                                                provider.updateStatus(context, "starred", [data?.id ?? 0], 'important', data?.isImportant == 0 ? 1 : 0 );
                                              },
                                              child: data?.isImportant == 1
                                                  ? const Icon(Icons.bookmark, size: 18, color: Colors.black,)
                                                  : const Icon(Icons.bookmark_border, size: 18, color: Colors.black,)),
                                          const SizedBox(width: 08,),
                                          InkWell(
                                              onTap: ()=> provider.moveToTrash(context, "starred", [data?.id ?? 0]),
                                              child: const Icon(Icons.delete_outline, size: 18,)),
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
