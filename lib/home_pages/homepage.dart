import 'package:flutter/material.dart';
import 'package:intern_system/home_pages/attendance.dart';
import 'package:intern_system/home_pages/dashborad.dart';
import 'package:intern_system/home_pages/profilepage.dart';
import 'package:intern_system/home_pages/supervisor.dart';
import 'package:intern_system/home_pages/taskpage.dart';
import 'package:intern_system/home_pages/view_log_book.dart';
import 'package:intern_system/login_pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';

class Home extends StatelessWidget {
  
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 114, 26, 20),
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
              color: Colors.white,
              iconSize: 38,
            );
          }),
          title: const Align(
            child: Text(
              "Intern Dashboard",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.book_online_outlined, color: Colors.white),
              onPressed: () {
                // Add your action here
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: const Color.fromARGB(255, 114, 26, 20),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 220),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Dashborad(),
                          ));
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Dashborad(),
                                ));
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.house,
                              color: Color.fromARGB(255, 114, 26, 20),
                            ),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        'Home',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Taskpage(),
                                ));
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.task,
                              color: Color.fromARGB(255, 114, 26, 20),
                            ),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        'task',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Profilepage(),
                                ));
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 114, 26, 20),
                            ),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        'Account',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Supervisor(),
                                ));
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.supervisor_account,
                              color: Color.fromARGB(255, 114, 26, 20),
                            ),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        'Supervisor',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Attendance(),
                                ));
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.book_sharp,
                              color: Color.fromARGB(255, 114, 26, 20),
                            ),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        'Fill Log Book',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
                                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => ViewLogBook(),
                                ));
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.book_online_sharp,
                              color: Color.fromARGB(255, 114, 26, 20),
                            ),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        'View Log Book',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Homepage(),
                                ));
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.logout,
                              color: Color.fromARGB(255, 114, 26, 20),
                            ),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        'logout',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dashboard Summary
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSummaryCardWithData('Interns', 'interns'), 
                          SizedBox(width: screenWidth*0.06,),
                          _buildSummaryCardWithData('Supervisors', 'supervisors'),
                          SizedBox(width: screenWidth*0.06,),
                         _buildStatusCard('Tasks', true)

                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Intern Directory
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(height: screenWidth*0.06,),
                          const Text('Intern Directory',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                         SizedBox(width: screenHeight*0.06,),
                          _buildInternDirectory(), // This will now handle states correctly
                         SizedBox(width: screenHeight*0.06,),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
  

  Widget _buildSummaryCardUI(String count, String label) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(count, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
  Widget _buildStatusCard(String label, bool isAssigned) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Icon(
            isAssigned ? Icons.check_circle : Icons.hourglass_empty,
            color: isAssigned ? Colors.green : Colors.orange,
            size: 32,
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    ),
  );
}


Future<int> _getTaskCountForIntern(String internId) async {
  final supervisors = await FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'supervisor')
      .get();

  int totalTasks = 0;

  for (var supervisorDoc in supervisors.docs) {
    final subtaskSnapshot = await supervisorDoc.reference
        .collection('tasks')
        .where('assignedInternId', isEqualTo: internId)
        .get();

    totalTasks += subtaskSnapshot.size;
  }

  return totalTasks;
}
  // This function fetches the count and then uses _buildSummaryCardUI to display it
 Future<int> _getCount(String collection, {String? internId}) async {
  if (collection == 'interns') {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'intern')
        .get();
    return snapshot.size;
  } else if (collection == 'supervisors') {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'supervisor')
        .get();
    return snapshot.size;
 } else if (collection == 'tasks' && internId != null) {
  return await _getTaskCountForIntern(internId);
}
 else {
    final snapshot = await FirebaseFirestore.instance.collection(collection).get();
    return snapshot.size;
  }
}


  Widget _buildSummaryCardWithData(String label, String collection, {String? internId}) {
  return FutureBuilder<int>(
    future: _getCount(collection, internId: internId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      return _buildSummaryCardUI(snapshot.data.toString(), label);
    },
  );
}


  // This function now correctly handles StreamBuilder states for the intern directory
 Widget _buildInternDirectory() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'intern')
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Show loading indicator
      }
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}'); // Display error
      }
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Text('No interns found.'); // Handle empty collection
      }

      final interns = snapshot.data!.docs;
      return Column(
        children: interns.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return _buildInternCard(
            data['name'] ?? 'No Name',
            data['branch'] ?? 'No branch',
            data['number'] ?? 'No number',
          );
        }).toList(),
      );
    },
  );
}

   Widget _buildInternCard(String name, String department, String number) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            child: Icon(Icons.person, size: 28, color: Colors.white),
            backgroundColor:  Color.fromARGB(255, 180, 86, 86),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(department, style: const TextStyle(color: Colors.grey)),
                Text(number, style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  }

