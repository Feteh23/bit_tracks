import 'package:flutter/material.dart';

class SupervisorTask extends StatefulWidget {
  const SupervisorTask({super.key});

  @override
  State<SupervisorTask> createState() => SupervisorTaskState();
}

class SupervisorTaskState extends State<SupervisorTask> {
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
      "Bit Tracks task Assignment",
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
    );
  }
}