import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage_supervisor extends StatefulWidget {
  const HomePage_supervisor({super.key});

  @override
  State<HomePage_supervisor> createState() => _HomePage_supervisorState();
}
class _HomePage_supervisorState extends State<HomePage_supervisor> {
  DateTime? _startDate;
DateTime? _deadline;

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
  );
  if (picked != null) {
    setState(() {
      if (isStartDate) {
        _startDate = picked;
      } else {
        _deadline = picked;
      }
    });
  }
  
}


  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();
  

void _createTask() async {
  final uid = FirebaseAuth.instance.currentUser?.uid; // supervisor ID
  final title = _taskTitleController.text.trim();
  final description = _taskDescriptionController.text.trim();

  if (uid != null && title.isNotEmpty && description.isNotEmpty && _startDate != null && _deadline != null) {
    await FirebaseFirestore.instance
      .collection('supervisors')
      .doc(uid)
      .collection('tasks')
      .add({
        'title': title,
        'description': description,
        'createdAt': Timestamp.now(),
        'startDate': Timestamp.fromDate(_startDate!),
        'deadline': Timestamp.fromDate(_deadline!),
      });

    _taskTitleController.clear();
    _taskDescriptionController.clear();
    setState(() {
      _startDate = null;
      _deadline = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task created successfully')),
    );
  }
   else {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(content: Text('Please fill all task details.')),

      );

    }
}

 
 void _showAssignTaskDialog(String internId, String internName) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // Use StatefulBuilder to manage the internal state of the dialog
        return StatefulBuilder(
          builder: (context, setState) {
            final uid = FirebaseAuth.instance.currentUser?.uid;
              DocumentSnapshot? selectedTaskDoc; // Holds the currently selected task
            if (uid == null) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Supervisor not logged in.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('OK'),
                  ),
                ],
              );
            }

            return AlertDialog(
              title: Text('Assign Task to $internName'),
              content: FutureBuilder<QuerySnapshot>(
               // Fetch supervisor's tasks from their subcollection
                future: FirebaseFirestore.instance
                    .collection('supervisors')
                    .doc(uid)
                    .collection('tasks')
                    .get(), // Use .get() to fetch tasks once for the dialog
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error loading tasks: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text('You have not created any tasks yet.');
                  }

                  final List<DocumentSnapshot> supervisorTasks = snapshot.data!.docs;
                  // Initialize _selectedTaskDoc if it's null and there are tasks
                  if (selectedTaskDoc == null && supervisorTasks.isNotEmpty) {
                    selectedTaskDoc = supervisorTasks.first;setState(() {
    selectedTaskDoc = supervisorTasks.first;
  });

                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<DocumentSnapshot>(
                        value: selectedTaskDoc,
                        onChanged: (DocumentSnapshot? newValue) {
                          setState(() {
                            selectedTaskDoc = newValue;
                          });
                        },
                        items: supervisorTasks.map((DocumentSnapshot taskDoc) {
                          return DropdownMenuItem<DocumentSnapshot>(
                            value: taskDoc,
                            child: Text(taskDoc['title'] ?? 'Untitled Task'),
                          );
                        }).toList(),
                        isExpanded: false,
                        hint: const Text('Select a task'),
                      ),
                      // Optionally display details of the selected task

                      if (selectedTaskDoc != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description: ${selectedTaskDoc!['description'] ?? 'N/A'}',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                'Start Date: ${(selectedTaskDoc!['startDate'] as Timestamp?)?.toDate().toLocal().toString().split(' ')[0] ?? 'N/A'}',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),

                              Text(
                                'Deadline: ${(selectedTaskDoc!['deadline'] as Timestamp?)?.toDate().toLocal().toString().split(' ')[0] ?? 'N/A'}',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                   onPressed: selectedTaskDoc == null ? null : () async {

                    if (selectedTaskDoc != null && selectedTaskDoc!.id.isNotEmpty) {
  final selectedTaskData = selectedTaskDoc!.data() as Map<String, dynamic>;

  await FirebaseFirestore.instance
    .collection('supervisors')
    .doc(uid)
    .collection('tasks')
    .doc(selectedTaskDoc!.id)
    .update({
      'assignedTo': FieldValue.arrayUnion([internId]),
      'assignedToNames': FieldValue.arrayUnion([internName]),
      'assignedAt': Timestamp.now(),
      'status': 'pending',
    });

  Navigator.pop(dialogContext);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Task "${selectedTaskData['title']}" assigned to $internName')),
  );
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Please select a valid task to assign.')),
  );
}

                  },
                  child: const Text('Assign'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150.0),
          child: AppBar(
            backgroundColor: AppColors.primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title:  Align(
              child: Text(
                'Supervisor Dashboard',
                style: TextStyle(fontSize: screenWidth*0.055, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            bottom:  TabBar(
              tabs: [
                Tab(text: 'Create Task'),
                Tab(text: 'Intern List'),
                Tab(text: 'Manage Interns'),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle: TextStyle(fontSize: screenWidth*0.04, fontWeight: FontWeight.bold),
              indicatorColor: Colors.white,
              indicatorWeight: 4.0,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
              indicatorSize: TabBarIndicatorSize.label,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // Create Task View
          Padding(
  padding: const EdgeInsets.only(top: 45, left: 15, right: 15),
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          TextField(
            controller: _taskTitleController,
    style: TextStyle( 
    fontSize: screenWidth*0.04,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
                   decoration: InputDecoration(
                    labelText: 'Task Topic',
                    labelStyle: TextStyle( 
      fontSize: screenWidth*0.045,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryColor)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400
                      )
                    ),
                    ),
                    ),
         SizedBox(height: screenHeight*0.04),
        TextField(
          controller: _taskDescriptionController,
          maxLines: 12,
          decoration: const InputDecoration(
            hintText: 'Enter description here...',
            border: OutlineInputBorder(),
          ),
        ),
         SizedBox(height: screenHeight*0.04),
Row(
  children: [
    Expanded(
      child: TextButton.icon(
        icon: const Icon(Icons.calendar_today,color: Colors.black,),
        label: Text(
          _startDate == null
              ? 'Select Start Date'
              : 'Start: ${_startDate!.toLocal().toString().split(' ')[0]}',
              style: TextStyle(color: Colors.black, fontSize: screenWidth*0.04),
        ),
        onPressed: () => _pickDate(context, true),
      ),
    ),
    
    Expanded(
      child: TextButton.icon(
        icon: const Icon(Icons.calendar_today, color: Colors.black,),
        label: Text(
          _deadline == null
              ? 'Select Deadline'
              : 'Deadline: ${_deadline!.toLocal().toString().split(' ')[0]}',
              style: TextStyle(color: Colors.black, fontSize: screenWidth*0.045),
        ),
        onPressed: () => _pickDate(context, false),
      ),
    ),
  ],
),

         SizedBox(height: screenHeight*0.08),
        Center(
          child: ElevatedButton(
            onPressed: _createTask,
            child:  Text('Create Task', style: TextStyle(fontSize: screenWidth*0.045, color: Color.fromARGB(255, 114, 26, 20), fontWeight: FontWeight.bold),),
          ),
        ),
      ],
    ),
  ),
),
          // Intern List View
          StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'intern')
      .where('supervisorId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)

      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text('No interns assigned.'));
    }

    final interns = snapshot.data!.docs;

    return ListView.builder(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 16),
      itemCount: interns.length,
      itemBuilder: (context, index) {
        final intern = interns[index];
        return Card(
  child: ListTile(
    leading: const Icon(Icons.person),
    title: Text(intern['name'] ?? 'Unnamed'),
    subtitle: Text(intern['email'] ?? 'No email'),
    trailing: IconButton(
      icon: const Icon(Icons.assignment_add),
      tooltip: 'Assign Task',
      onPressed: () {
        _showAssignTaskDialog(intern.id, intern['name']);
      },
    ),
  ),
        );

      },
    );
  },
),

            // Manage Interns View
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('submissions')
                  .where('supervisorId', isEqualTo: 'SUPERVISOR_ID') // Replace with actual ID
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No submissions found.'));
                }

                final submissions = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: submissions.length,
                  itemBuilder: (context, index) {
                    final submission = submissions[index];
                    final internName = submission['internName'] ?? 'Unknown';
                    final taskTitle = submission['taskTitle'] ?? 'Untitled';
                    final grade = submission['grade'];

                    return Card(
                      child: ListTile(
                        title: Text('$internName - $taskTitle'),
                        subtitle: Text('Grade: ${grade ?? 'Not graded'}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // You can open a dialog here to enter grade
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
