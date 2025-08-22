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
  List<User> _interns = [];

  User? _selectedIntern;
  User? _selectedSupervisor;

  String? _selectedSupervisorId;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final interns = await fetchUsersByRole('intern');
    final supervisors = await fetchUsersByRole('supervisor'); 

    setState(() {
      _internList = interns;
      _supervisorList = supervisors;
    });
  }

  Future<List<User>> fetchUsersByRole(String role) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: role)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return User(
        id: doc.id,
        name: data['name'],
        role: data['role'],
      );
    }).toList();
  }

  Future<void> pairInternWithSupervisor(String internId, String supervisorId) async {
    await FirebaseFirestore.instance.collection('users').doc(internId).update({
      'supervisorId': supervisorId,
    });
  }

  Future<List<User>> fetchInternsForSupervisor(String supervisorId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'intern')
        .where('supervisorId', isEqualTo: supervisorId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return User(
        id: doc.id,
        name: data['name'],
        role: data['role'],
      );
    }).toList();
  }

  Future<void> _pairUsers() async {
    final internId = _selectedIntern?.id;
    final supervisorId = _selectedSupervisor?.id;

    if (internId != null && supervisorId != null) {
      await pairInternWithSupervisor(internId, supervisorId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Paired ${_selectedIntern!.name} with ${_selectedSupervisor!.name}')),
      );
      setState(() {
        _selectedIntern = null;
      });
      _loadInternsForSupervisor(supervisorId);
    }
  }

  Future<void> _loadInternsForSupervisor(String supervisorId) async {
    final interns = await fetchInternsForSupervisor(supervisorId);
    setState(() {
      _interns = interns;
      _selectedSupervisorId = supervisorId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pair Interns with Supervisors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<User>(
              decoration: InputDecoration(labelText: 'Select Intern'),
              items: _internList.map((intern) {
                return DropdownMenuItem<User>(
                  value: intern,
                  child: Text(intern.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedIntern = value;
                });
              },
              value: _selectedIntern,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<User>(
              decoration: InputDecoration(labelText: 'Select Supervisor'),
              items: _supervisorList.map((supervisor) {
                return DropdownMenuItem<User>(
                  value: supervisor,
                  child: Text(supervisor.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSupervisor = value;
                });
                if (value != null) {
                  _loadInternsForSupervisor(value.id);
                } else {
                  setState(() {
                    _interns = [];
                    _selectedSupervisorId = null;
                  });
                }
              },
              value: _selectedSupervisor,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pairUsers,
              child: Text('Pair Users'),
            ),
            SizedBox(height: 20),
            if (_selectedSupervisorId != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Interns paired with Supervisor ${_selectedSupervisor?.name ?? ''}:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _interns.length,
                        itemBuilder: (context, index) {
                          final intern = _interns[index];
                          return ListTile(
                            title: Text(intern.name),
                            subtitle: Text('ID: ${intern.id}'),
                          );
                        },
                      ),
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
