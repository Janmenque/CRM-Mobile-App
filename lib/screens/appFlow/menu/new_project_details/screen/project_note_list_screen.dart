import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/note_card.dart';
import 'package:hrm_app/screens/appFlow/menu/new_project_details/provider/project_note_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import '../../sales/product/content/new_form_field.dart';

class ProjectNoteScreen extends StatelessWidget {
  final int projectId;

  const ProjectNoteScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectNoteProvider>(
      builder: (context, provider, _) {
        final notes = provider.projectNoteList;
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Notes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () => createProjectNote(context, provider, projectId),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xff5B58FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 14,
                            color: Colors.white,
                          ),
                          Text(
                            "Create",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            notes.isNotEmpty == true ?
            const Center(
              child: Text(
                "Tap and hold a note to reorder it by dragging.",
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black),
              ),
            ) : const SizedBox(),
            const SizedBox(height: 14,),
            provider.isLoading ? const Expanded(child:  CustomListShimer()) :
            notes.isNotEmpty == true ?
            Expanded(
              child: ReorderableGridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                children: List.generate(
                  notes.length,
                      (index) {
                    return NoteCard(
                      key: ValueKey(notes[index].id ?? index),
                      context: context,
                      note: notes[index].description ?? "",
                      onDelete: () => provider.removeProjectNote(context, projectId, notes[index].id ?? 0),
                      noteId: notes[index].id ?? 0,
                      clientId: projectId,
                    );
                  },
                ),
                onReorder: (oldIndex, newIndex) {
                  provider.reorderNotes(oldIndex, newIndex); // Handle reordering
                },
              ),
            ) : const Expanded(child:  NoDataFoundWidget()),
          ],
        );
      },
    );
  }

  void createProjectNote(BuildContext parentContext, ProjectNoteProvider provider, int projectId) {
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
                  child: Consumer<ProjectNoteProvider>(
                    builder: (_, provider, __) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 5),
                            const Text(
                              "Add Note",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            NewTextField(
                              labelText: "Add Note",
                              maxLine: 4,
                              controller: provider.noteController,
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (provider.noteController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Note is required."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    provider.createProjectNote(context, projectId);
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
