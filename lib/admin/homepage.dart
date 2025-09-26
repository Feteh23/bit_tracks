import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_system/reusablewigets.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});
  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}
class _AdminHomepageState extends State<AdminHomepage> {
    bool _isPasswordHidden = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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
        'branch': '', 
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User created successfully', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.textColor),)));
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      setState(() => selectedRole = 'intern');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.textColor),)));
    }
  }
 Future<void> deleteUser(BuildContext context, String uid) async {
  final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
  final snapshot = await docRef.get();
  if (!snapshot.exists) return;

  final userData = snapshot.data(); // Save user info before deletion
  await docRef.delete();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
content: Text('User deleted', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: AppColors.textColor),),
      action: SnackBarAction(label: 'Undo',onPressed: () async {
          await FirebaseFirestore.instance.collection('users').doc(uid).set(userData!);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User restored', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.textColor
    ),)),
          );
        },
      ),
      duration: Duration(seconds: 30),
    ),
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
             preferredSize: Size.fromHeight(150.0),
            child: AppBar(
              backgroundColor: AppColors.primaryColor,
              title: Align(
                child: Text('Admin Dashboard',style: TextStyle(fontSize: screenWidth * 0.07,fontWeight: FontWeight.bold,color: Colors.white,),
                  textAlign: TextAlign.center,
                ),
              ),
                bottom: TabBar(
             tabs: [
               Tab(text: 'Create User'),
                Tab(text: 'Manage Users'),
                Tab(text: 'Complaints'),
             ],
              labelColor: Colors.white, 
              unselectedLabelColor: Colors.white70, 
              labelStyle: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: screenWidth * 0.04),
              indicatorColor: Colors.white, 
              indicatorWeight: 4.0, 
              indicatorPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              indicatorSize: TabBarIndicatorSize.label, 
            ),
            ),
          ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                    StyledTextField(labelText: 'Name',hintText: 'Enter full name',controller: nameController, ),
                      SizedBox(height: screenHeight * 0.02),
                      StyledTextField(labelText: 'Email', hintText: 'Enter email', controller: emailController, keyboardType: TextInputType.emailAddress,),
                      SizedBox(height: screenHeight * 0.02),
                      StyledTextField(labelText: 'Phone', hintText: 'Enter phone number', controller: phoneController, keyboardType: TextInputType.phone,),
                      SizedBox(height: screenHeight * 0.02),
                      StyledTextField(labelText: 'Password',hintText: 'Enter password',controller: passwordController,obscureText: true,
                        suffixIcon:  IconButton(
                    icon: Icon(_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _isPasswordHidden = !_isPasswordHidden),
                  ),
                      ),
                         SizedBox(height: screenHeight * 0.02,),
                      DropdownButtonFormField(
                        value: selectedRole,
                        items: roles.map((role) => DropdownMenuItem(value: role, child: Text(role, style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),))).toList(),
                        onChanged: (value) => setState(() => selectedRole = value!),
                        decoration: InputDecoration(
                          labelText: 'Role', labelStyle: TextStyle( fontSize: screenWidth * 0.042,color: AppColors.primaryColor,fontWeight: FontWeight.bold,),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03,),
                    ElevatedButton(
                    onPressed: createUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white, 
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Create User',style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.bold,),
                    ),
                  ),
                    ],
                  ),
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
                      final number = user['number'] ?? 'N/A';
                      final role = user['role'];
          SizedBox(height: screenHeight*0.05,);
                     return Column(
            children: [
             Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: user info
                 CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.tertiaryColor,
              child: Icon(Icons.person, size: 70, color: const Color.fromARGB(255, 250, 250, 250),)),
              SizedBox(width: screenHeight * 0.015),
                Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$name  ($role)', style: TextStyle(fontSize: screenWidth * 0.043, fontWeight: FontWeight.bold)),
              Text(number, style: TextStyle(fontSize: screenWidth * 0.041, fontWeight: FontWeight.bold)),
              Text(email, style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey[700])),
            ],
          ),
                ),
          
                // Right side: action buttons
                Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: AppColors.secondaryColor),
              onPressed: () {
                showEditUserDialog(
                  context,
                  uid: user.id,
                  name: user['name'],
                  email: user['email'],
                  number: user['number'] ?? '',
                  branch: user['branch'] ?? '',
                  role: user['role'] ?? 'intern',
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: const Color.fromARGB(255, 214, 32, 19)),
              onPressed: () => deleteUser(context, uid),
            ),
          ],
                ),
              ],
            ),
          ),
              SizedBox(height: screenHeight * 0.02), 
            ],
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
      ),
    );
  }
}
Future<void> showEditUserDialog(
  BuildContext context, {
  required String uid,
  required String name,
  required String email,
  required String number,
  required String branch,
  required String role, 
}) async {
    final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  final nameController = TextEditingController(text: name);
  final emailController = TextEditingController(text: email);
  final phoneController = TextEditingController(text: number);
  final branchController = TextEditingController(text: branch);
  String selectedRole = role;
  final roles = ['intern', 'supervisor', 'admin'];
  final shouldSave = await showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => AlertDialog(
        title: Text('Edit User Information', style: TextStyle(color:  AppColors.primaryColor, fontWeight: FontWeight.bold),),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: screenHeight * 0.01,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                ),
              ),
               SizedBox(height: screenHeight * 0.01,),
               TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                ),
              ),
               SizedBox(height: screenHeight * 0.01,),
              TextField(
                controller: branchController,
                decoration: InputDecoration(
                  labelText: 'Branch',
                  labelStyle: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                ),
              ),
              
              DropdownButtonFormField<String>(
                value: selectedRole,
                items: roles.map((r) => DropdownMenuItem(
                  value: r,
                  child: Text(r, style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold)),
                )).toList(),
                onChanged: (value) => setState(() => selectedRole = value!),
                decoration: InputDecoration(
                  labelText: 'Role',
                  labelStyle: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel',style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 114, 26, 20),),),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Save',style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 114, 26, 20),),),
          ),
        ],
      ),
    ),
  );
  if (shouldSave != true) return;
  // Update Firestore
  try {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'branch': branchController.text.trim(),
      'role': selectedRole, 
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('✅ User info updated',style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 255, 255, 255),),)),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('❌ Failed to update user',style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 255, 255, 255),),)),
    );
  }
}
