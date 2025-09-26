import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_system/reusablewigets.dart';
class Supervisor extends StatefulWidget {
  const Supervisor({super.key});

  @override
  State<Supervisor> createState() => _SupervisorState();
}

class _SupervisorState extends State<Supervisor> {
  String supervisorName = '';
  String supervisorPhone = '';
  String supervisorBranch = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSupervisorDetails();
  }

  Future<void> fetchSupervisorDetails() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final internDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final supervisorId = internDoc.data()?['supervisorId'];

    if (supervisorId != null) {
      final supervisorDoc = await FirebaseFirestore.instance.collection('users').doc(supervisorId).get();
      final data = supervisorDoc.data();
      setState(() {
        supervisorName = data?['name'] ?? 'Unknown';
        supervisorPhone = data?['number'] ?? 'N/A';
        supervisorBranch = data?['branch'] ?? 'N/A';
        isLoading = false;
      });
    }  else {
  setState(() {
    supervisorName = 'Not assigned';
    supervisorPhone = '-';
    supervisorBranch = '-';
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
  backgroundColor: const Color.fromARGB(255, 114, 26, 20),
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
        fontSize: screenWidth*0.045,
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
body: isLoading
  ? Center(child: CircularProgressIndicator())
  : Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight*0.05,),
        Padding(
          padding: const EdgeInsets.only(left: 45),
          child: CircleAvatar(
            radius: 140,
            backgroundColor: AppColors.tertiaryColor,
            child: Icon(Icons.person, size: 240, color: const Color.fromARGB(255, 250, 250, 250),)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Column(
            children: [
               SizedBox(height: screenHeight*0.015),
              Text(" $supervisorName", style: TextStyle(fontSize: screenWidth*0.065, fontWeight: FontWeight.bold)),
               SizedBox(height: screenHeight*0.01),
          Text(" $supervisorPhone", style: TextStyle(fontSize: screenWidth*0.045, fontWeight: FontWeight.bold)),
          SizedBox(height: screenHeight*0.01),
          Text(" $supervisorBranch", style: TextStyle(fontSize: screenWidth*0.045, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    ),
  ),

    );
  }
}


