import 'package:flutter/material.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupervisorTask extends StatefulWidget {
   final String uid; // Supervisor UID

  const SupervisorTask({required this.uid, super.key});


  @override
  State<SupervisorTask> createState() => SupervisorTaskState();
}

class SupervisorTaskState extends State<SupervisorTask> {
  String _formatDate(dynamic timestamp) {
  if (timestamp is Timestamp) {
    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }
  return 'N/A';
}

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
  backgroundColor: AppColors.primaryColor,
  leading:
  IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white,),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
  title: Align(
    child: Text(
      "Bit Tracks task Assignment",
      style: TextStyle(
        fontSize: screenWidth * 0.05,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.book_online_outlined, color: Colors.white),
      onPressed: () {
        // Add your action here
      },
    ),
  ],
  
),
 body: Padding(
   padding: const EdgeInsets.only(top: 20),
   child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('supervisors')
              .doc(widget.uid)
              .collection('tasks')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading tasks'));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
   
            final tasks = snapshot.data!.docs;
   
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final taskId = task.id;
                final data = task.data() as Map<String, dynamic>;
   
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: ListTile(
                    title: Text(data['title'] ?? 'No Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['description'] ?? 'No Description'),
                       Text('Start: ${_formatDate(data['startDate'])}'),
                       Text('End: ${_formatDate(data['deadline'])}'),
   
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: AppColors.secondaryColor),
                          onPressed: () => _showEditDialog(context, widget.uid, taskId, data),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            try {
                              await FirebaseFirestore.instance
                                  .collection('supervisors')
                                  .doc(widget.uid)
                                  .collection('tasks')
                                  .doc(taskId)
                                  .delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Task deleted')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
 ),
    );
  }

}  



  void _showEditDialog(BuildContext context, String uid, String taskId, Map<String, dynamic> data) {
    final titleController = TextEditingController(text: data['title']);
    final descriptionController = TextEditingController(text: data['description']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration:  InputDecoration(labelText: 'Title', labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            SizedBox(height: 10),
            TextField(controller: descriptionController,  maxLines: 10, decoration: const InputDecoration(labelText: 'Description', labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await FirebaseFirestore.instance
                    .collection('supervisors')
                    .doc(uid)
                    .collection('tasks')
                    .doc(taskId)
                    .update({
                  'title': titleController.text,
                  'description': descriptionController.text,
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task updated')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

