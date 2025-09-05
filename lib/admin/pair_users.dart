import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPairUserspage extends StatefulWidget {
  const AdminPairUserspage({super.key});
  @override
  State<AdminPairUserspage> createState() => _AdminPairUserspageState();
}

class User {
  final String id;
  final String name;
  final String role;
  User({required this.id, required this.name, required this.role});
}


class _AdminPairUserspageState extends State<AdminPairUserspage> {
  List<User> _internList = [];
List<User> _supervisorList = [];
final Set<String> _selectedInternIds = {};
User? _selectedSupervisor;
String? _selectedSupervisorId;


@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _loadUsers();
  });
}



  // fetch users by role
 Future<List<User>> fetchUsersByRole(String role) async {
  final snap = await FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: role)
      .get();
  return snap.docs.map((d) {
    final data = d.data();
    return User(id: d.id, name: data['name'], role: data['role']);
  }).toList();
}
  // load both lists
Future<void> _loadUsers() async {
  final interns = await fetchUsersByRole('intern');
  final supervisors = await fetchUsersByRole('supervisor');

  setState(() {
    _internList = interns;
    _supervisorList = supervisors;
  });
}


  // batch-pair all selected interns
  Future<void> _pairUsers() async {
    final supId = _selectedSupervisorId;
    if (supId == null || _selectedInternIds.isEmpty) return;

    final batch = FirebaseFirestore.instance.batch();
    for (var internId in _selectedInternIds) {
      final ref = FirebaseFirestore.instance.collection('users').doc(internId);
      batch.update(ref, {'supervisorId': supId});
    }
    await batch.commit();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Paired ${_selectedInternIds.length} intern(s) '
          'with ${_selectedSupervisor!.name}'
        ),
      ),
    );

    setState(() {
      // clear your selections if you want
      _selectedInternIds.clear();
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
  backgroundColor: const Color.fromARGB(255, 114, 26, 20),
  leading:
  IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white,),
    onPressed: () {
      Navigator.pop(context);
    },
  ),

  title: Align(
    child: Text(
      "Bit Tracks",
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
      icon: Icon(Icons.book_online_outlined, color: Colors.white),
      onPressed: () {
        // Add your action here
      },
    ),
  ],

),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text('Pair Interns with Supervisors', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 114, 26, 20))),
           SizedBox(
            height: 20,
          ),
          // Supervisor dropdown
          DropdownButtonFormField<User>(
            decoration: InputDecoration(
              labelText: 'Select Supervisor', 
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)
            ), // 🏷 Label
            items: _supervisorList.map((user) {
              return DropdownMenuItem<User>(
                value: user,                      // 🔑 What gets returned when selected
                child: Text(user.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),          // 👁️ What the user sees
              );
            }).toList(),                         // 📋 List of dropdown options
            onChanged: (selectedUser) {          // 🔄 What happens when user picks one
              setState(() {
                _selectedSupervisor = selectedUser;
                _selectedSupervisorId = selectedUser?.id;
              });
            },
            value: _selectedSupervisor,          // ✅ Currently selected value
          ),
      SizedBox(height: 20),

      // Intern list + Pair button
      if (_selectedSupervisorId != null)
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: _internList.isEmpty
                    ? Center(child: Text('No interns found'))
                    : ListView(
                        children: _internList.map((intern) {
                          final checked = _selectedInternIds.contains(intern.id);
                          return CheckboxListTile(
                            title: Text(intern.name),
                            subtitle: Text('ID: ${intern.id}'),
                            value: checked,
                            onChanged: (on) {
                              setState(() {
                                if (on == true) {
                                  _selectedInternIds.add(intern.id);
                                } else {
                                  _selectedInternIds.remove(intern.id);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectedInternIds.isEmpty ? null : _pairUsers,
                child: Text('Pair Selected Interns',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 125, 3, 3)),),
              ),
            ],
          ),
        ),
    ],
  ),
),

  );
}
}