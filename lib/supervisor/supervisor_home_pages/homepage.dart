import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final title = _taskTitleController.text.trim();
  final description = _taskDescriptionController.text.trim();

  if (title.isNotEmpty && description.isNotEmpty && _startDate != null && _deadline != null) {
    await FirebaseFirestore.instance.collection('tasks').add({
      'title': title,
      'description': description,
      'createdAt': Timestamp.now(),
      'startDate': Timestamp.fromDate(_startDate!),
      'deadline': Timestamp.fromDate(_deadline!),
      'supervisorId': 'SUPERVISOR_ID',
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
}

 
void _showAssignTaskDialog(String internId, String internName) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Assign Task to $internName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Task Description'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = titleController.text.trim();
              final description = descriptionController.text.trim();

              if (title.isNotEmpty && description.isNotEmpty) {
                await FirebaseFirestore.instance.collection('tasks').add({
                  'title': title,
                  'description': description,
                  'assignedTo': internId,
                  'assignedToName': internName,
                  'createdAt': Timestamp.now(),
                  'supervisorId': 'SUPERVISOR_ID', // Replace dynamically
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Task assigned to $internName')),
                );
              }
            },
            child: const Text('Assign'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150.0),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 114, 26, 20),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Align(
              child: Text(
                'Supervisor Dashboard',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Create Task'),
                Tab(text: 'Intern List'),
                Tab(text: 'Manage Interns'),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    style: TextStyle( 
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
                   decoration: InputDecoration(
                    labelText: 'Task Topic',
                    labelStyle: TextStyle( 
      fontSize: 18,
      color: Color.fromARGB(255, 114, 26, 20),
      fontWeight: FontWeight.bold,
    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color.fromARGB(255, 100, 99, 99))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400
                      )
                    ),
                    ),
                    ),
        const SizedBox(height: 20),
        TextField(
          controller: _taskDescriptionController,
          maxLines: 10,
          decoration: const InputDecoration(
            hintText: 'Enter description here...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
Row(
  children: [
    Expanded(
      child: TextButton.icon(
        icon: const Icon(Icons.calendar_today,color: Colors.black,),
        label: Text(
          _startDate == null
              ? 'Select Start Date'
              : 'Start: ${_startDate!.toLocal().toString().split(' ')[0]}',
              style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        onPressed: () => _pickDate(context, true),
      ),
    ),
    const SizedBox(width: 1),
    Expanded(
      child: TextButton.icon(
        icon: const Icon(Icons.calendar_today, color: Colors.black,),
        label: Text(
          _deadline == null
              ? 'Select Deadline'
              : 'Deadline: ${_deadline!.toLocal().toString().split(' ')[0]}',
              style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        onPressed: () => _pickDate(context, false),
      ),
    ),
  ],
),

        const SizedBox(height: 40),
        Center(
          child: ElevatedButton(
            onPressed: _createTask,
            child: const Text('Create Task', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 114, 26, 20), fontWeight: FontWeight.bold),),
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
      .where('supervisorId', isEqualTo: 'SUPERVISOR_ID') // Replace with actual ID

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
      padding: const EdgeInsets.all(16),
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
