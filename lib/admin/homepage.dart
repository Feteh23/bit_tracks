import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_system/admin/dashboard.dart';
import 'package:intern_system/admin/profilepage.dart';
import 'package:cloud_functions/cloud_functions.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
    final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedRole = 'intern';

  final roles = ['intern', 'supervisor', 'admin'];

  Future<void> createUser() async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      
      final uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'role': selectedRole,
        'branch': '', // Optional
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User created successfully')));
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      setState(() => selectedRole = 'intern');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  Future<void> deleteUser(String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User deleted')));
  }
  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
             preferredSize: Size.fromHeight(150.0),
            child: AppBar(
              backgroundColor: const Color.fromARGB(255, 114, 26, 20),
            leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
              title: Align(
                child: Text(
                  'Admin Dashboard',
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
                bottom: TabBar(
             tabs: [
               Tab(text: 'Create User'),
                Tab(text: 'Manage Users'),
                Tab(text: 'Complaints'),
             ],
              labelColor: Colors.white, 
              unselectedLabelColor: Colors.white70, 
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 14),
              indicatorColor: Colors.white, 
              indicatorWeight: 4.0, 
              indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
              indicatorSize: TabBarIndicatorSize.label, 
            
            
            ),
            ),
          ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: Column(
                children: [
                  TextField(controller: nameController,
                    style: TextStyle( 
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),

                   decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle( 
      fontSize: 18,
      color: Color.fromARGB(255, 114, 26, 20),
      fontWeight: FontWeight.bold,
    ),
 border: OutlineInputBorder(), 
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 100, 99, 99), width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
 hintText: 'Enter full name',
    hintStyle: TextStyle(color: Colors.grey),

                    )
                    ),
                    SizedBox(height: 25,),
                  TextField(controller: emailController,
                   style: TextStyle( 
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
                   decoration: InputDecoration(
                    labelText: 'Email',
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
                    hintText: 'Enter email',
                     hintStyle: TextStyle(color: Colors.grey),
                    ),
                    ),
                     SizedBox(height: 25,),
                  TextField(controller: passwordController,
                   style: TextStyle( 
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
                   decoration: InputDecoration(
                    labelText: 'Password',
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
                    hintText: 'Enter password',
                     hintStyle: TextStyle(color: Colors.grey),
                    ),
                    ),
                     SizedBox(height: 25,),
                  DropdownButtonFormField(
                    value: selectedRole,
                    items: roles.map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
                    onChanged: (value) => setState(() => selectedRole = value!),
                    decoration: InputDecoration(
                      labelText: 'Role', 
                    labelStyle: TextStyle(
                       fontSize: 25,
      color: Color.fromARGB(255, 114, 26, 20),
      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  SizedBox(height: 50),
                ElevatedButton(
  onPressed: createUser,
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 114, 26, 20), 
    foregroundColor: Colors.white, 
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: Text(
    'Create User',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
),

                ],
              ),
            ),

            // Manage Users Tab
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                 if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
  }
  if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
  }
  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return Center(child: Text('No users found.'));
  }
  final users = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final uid = user.id;
                    final name = user['name'];
                    final email = user['email'];
                    final role = user['role'];

                    return ListTile(
                      title: Text('$name ($role)'),
                      subtitle: Text(email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              showEditUserDialog(
                                context,
                                uid: user.id,
                                name: user['name'],
                                email: user['email'],
                                branch: user['branch'] ?? '',
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteUser(uid),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),

            // Complaints Tab
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final complaints = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: complaints.length,
                  itemBuilder: (context, index) {
                    final complaint = complaints[index];
                    final message = complaint['message'];
                    final from = complaint['from'];

                    return ListTile(
                      title: Text('From: $from'),
                      subtitle: Text(message),
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
Future<void> showEditUserDialog(BuildContext context, {
  required String uid,
  required String name,
  required String email,
  required String branch,
}) async {
  final nameController = TextEditingController(text: name);
  final emailController = TextEditingController(text: email);
  final branchController = TextEditingController(text: branch);

  final shouldSave = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Edit User Info'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: branchController, decoration: InputDecoration(labelText: 'Branch')),
            // Optional: Add password field if needed
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text('Cancel')),
        ElevatedButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text('Save')),
      ],
    ),
  );

  if (shouldSave != true) return;

  // Update Firestore
  try {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'branch': branchController.text.trim(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('✅ User info updated')),
    );
  } catch (e) {
    print('Error updating user: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('❌ Failed to update user')),
    );
  }
}


