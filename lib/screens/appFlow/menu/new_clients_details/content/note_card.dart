import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String note;
  final VoidCallback onDelete;
  final BuildContext context;
  final int clientId;
  final int noteId;

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.context,
    required this.clientId,
    required this.noteId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.yellow[200],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                _showDeleteConfirmationDialog(context);
              },
              child: const Icon(
                Icons.close,
                size: 20,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 8.0), // Space between icon and text
          // Note content
          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              maxLines: 7,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Show confirmation dialog before deletion
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Are you sure you want to delete this note?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onDelete();
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
