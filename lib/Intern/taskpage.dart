import 'package:flutter/material.dart';
import 'package:intern_system/reusablewigets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Taskpage extends StatefulWidget {
  const Taskpage({super.key});
  
 
  @override
  State<Taskpage> createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  bool isLoading = true;
   List<Task> tasks = [];
  String supervisorId = '';
  @override
   void initState() {
    super.initState();
    fetchSupervisorTasks();
  }
  
 Future<void> fetchSupervisorTasks() async {
  try {
    final internId = FirebaseAuth.instance.currentUser?.uid;
    if (internId == null) return;

    final internDoc = await FirebaseFirestore.instance.collection('users').doc(internId).get();
    if (!internDoc.exists) return;

    supervisorId = internDoc.data()?['supervisorId'] ?? '';
    if (supervisorId.isEmpty) return;

    final taskSnapshot = await FirebaseFirestore.instance
        .collection('supervisors')
        .doc(supervisorId)
        .collection('tasks')
        .where('assignedTo', arrayContains: internId)
        .get();

    final fetchedTasks = taskSnapshot.docs.map((doc) => Task.fromFirestore(doc.data())).toList();

    setState(() {
      tasks = fetchedTasks;
      isLoading = false; 
    });
  } catch (e) {
    print('Error fetching tasks: $e');
    setState(() {
      isLoading = false; 
    });
  }
}

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
  title: Align(child: Text("Bit Tracks task",style: TextStyle(fontSize: screenWidth*0.04,fontWeight: FontWeight.bold,color: Colors.white,),
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
body: isLoading
?  Center(child: CircularProgressIndicator())
: tasks.isEmpty
 ? Center(child: Text("No tasks assigned yet.", style: TextStyle(fontSize:screenWidth*0.034),))

: SingleChildScrollView(
    child: Column(
      children: tasks.map((task) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 241, 241, 241),
              borderRadius: BorderRadius.circular(10),
               boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 4),
                  ),
                ],
  
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar( backgroundColor:  AppColors.tertiaryColor,
  child: Icon(Icons.notification_important, color: Colors.white)),
                      SizedBox(width: screenWidth*0.02),
                      Text(task.title, style: TextStyle(fontSize: screenWidth*0.04, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.02),
                  Row(
                    children: [
                      CircleAvatar( backgroundColor:  AppColors.tertiaryColor,
                        child: Icon(Icons.start_rounded, color: Colors.white)),
                      SizedBox(width: screenWidth*0.02),
                      Text('Start: ${DateFormat('yyyy-MM-dd – HH:mm').format(task.startDate)}', style: TextStyle(fontSize: 18)),
  
                    ],
                  ),
                  SizedBox(height: screenHeight*0.02),
                  Row(
                    children: [
                      CircleAvatar( backgroundColor:  AppColors.tertiaryColor,
                        child: Icon(Icons.stop_circle_outlined, color: Colors.white)),
                      SizedBox(width: 15),
                      Text('Due: ${DateFormat('yyyy-MM-dd – HH:mm').format(task.dueDate)}', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height:screenHeight*0.02),
                  Row(
                    children: [
                      CircleAvatar( backgroundColor:  AppColors.tertiaryColor,
                        child: Icon(Icons.description_outlined, color: Colors.white)),
                      SizedBox(width:screenWidth*0.02),
                      Expanded(
                        child: Text(task.description, style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.035),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter a link or text here...",
                    hintMaxLines: 5,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: screenHeight*0.015),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Submit logic
                    },
                    icon: Icon(Icons.check),
                    label: Text('Submit Task'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ),
  ),
    );
  }
}
  class Task {
  final String title;
  final String description;
 final DateTime startDate;
final DateTime dueDate;

  Task({
    required this.title,
    required this.description,
    required this.startDate,
    required this.dueDate,
  });

 factory Task.fromFirestore(Map<String, dynamic> data) {
  return Task(
    title: data['title'] ?? '',
    description: data['description'] ?? '',
    startDate: data['startDate'] != null
        ? (data['startDate'] as Timestamp).toDate()
        : DateTime.now(), // fallback or default
    dueDate: data['dueDate'] != null
        ? (data['dueDate'] as Timestamp).toDate()
        : DateTime.now(), // fallback or default
  );
}
}

