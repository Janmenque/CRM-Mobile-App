import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_note_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/new_form_field.dart';
import 'package:hrm_app/screens/custom_widgets/empty_message.dart';
import 'package:provider/provider.dart';


class LeadNoteListScreen extends StatelessWidget {
  int leadId;
  LeadNoteListScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadNoteProvider>(
      builder: (context, provider, _) {
        final leadNotes = provider.leadNoteListResponse?.data;
        return SingleChildScrollView(
            child:  Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Notes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      InkWell(
                        onTap: ()=> addNoteDialog(context, provider ),
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
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: leadNotes?.length != 0 ?
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: leadNotes?.length ?? 0,
                      itemBuilder: (BuildContext context, int index){
                        final data = leadNotes?[index];
                        return InkWell(
                          onTap: (){},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Subject: ${data?.subject ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                      Text("Message: ${data?.message ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                      Text("Author: ${data?.author ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                      Text("Date : ${data?.date ?? "N/A"}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                                    ],
                                  ),],),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 14),
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                color: Colors.grey.withOpacity(0.4),
                              ),

                            ],),
                        );}) : const EmptyMessageWidget(),
                ),
              ],
            )
        );
      }
    );
  }

  void addNoteDialog(BuildContext parentContext, LeadNoteProvider provider) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) {
              return AlertDialog(
                title: const Center(
                  child: Text(
                    'Add Note',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                content: Consumer<LeadNoteProvider>(
                  builder: (_, provider, __) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          NewTextField( labelText: "Subject", controller: provider.noteSubjectController,),
                          NewTextField( labelText: "Note", maxLine: 3,controller: provider.noteMessageController,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  // Form and Image Validation
                                  if (provider.noteSubjectController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Subject is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (provider.noteSubjectController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Note is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    provider.createNote(context, leadId);
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
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      ),
                    );
                  }
                ),
              );
            }
          ),
        );
      },
    );
  }
}