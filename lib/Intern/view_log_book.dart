import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_system/reusablewigets.dart';

class ViewLogBook extends StatefulWidget {
  const ViewLogBook({super.key});

  @override
  State<ViewLogBook> createState() => _ViewLogBookState();
}

class _ViewLogBookState extends State<ViewLogBook> {
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
  backgroundColor: AppColors.primaryColor,
 leading: IconButton(
  icon: Icon(Icons.arrow_back, color: Colors.white, ),
  onPressed: () {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  },
),


  title: Align(
    child: Text(
      "Bit Tracks ",
      style: TextStyle(
        fontSize: screenWidth*0.025,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.book_online_outlined, color: Colors.white),
      onPressed: () {},
    ),
  ],
),
body: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('interns')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('description')
      .orderBy('timestamp', descending: true)
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text('No logbook entries found.', style: TextStyle(fontSize: 24),));
    }

    final entries = snapshot.data!.docs;

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final data = entries[index].data() as Map<String, dynamic>;
        final docId = entries[index].id;
        final date = data['date'] != null
            ? (data['date'] as Timestamp).toDate()
            : DateTime.now();
        final description = data['description'] ?? '';
        final isPresent = data['isPresent'] ?? false;

        final formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Icon(
              isPresent ? Icons.check_circle : Icons.cancel,
              color: isPresent ? Colors.green : Colors.red,
            ),
            title: Text(formattedDate, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(description),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  _editEntry(context, docId, description);
                } else if (value == 'delete') {
                  _deleteEntry(context, docId);

                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ),
        );
      },
    );
  },
),

    );
  }
}
void _editEntry(BuildContext context, String docId, String currentDescription) {
  final TextEditingController editController = TextEditingController(text: currentDescription);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Edit Description"),
      content: TextField(
        controller: editController,
        maxLines: 3,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('interns')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('description')
                .doc(docId)
                .update({'description': editController.text});

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Description updated successfully"), backgroundColor: Colors.green),
            );
          },
          child: const Text("Save"),
        ),
      ],
    ),
  );
}

void _deleteEntry(BuildContext context, String docId) async {
  await FirebaseFirestore.instance
      .collection('interns')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('description')
      .doc(docId)
      .delete();

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Entry deleted"), backgroundColor: Colors.red),
  );
}

