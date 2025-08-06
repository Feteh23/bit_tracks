import 'package:flutter/material.dart';
import 'package:intern_system/login_pages/login.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background container
          Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color.fromARGB(255, 250, 245, 245),
          ),
          // Centered text
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Homepage(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min, // Centers vertically
                children: [
                   SizedBox(height: 150,),
                  Text(
                    'Welcome',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: const Color.fromARGB(255, 114, 26, 20), fontSize: 54,fontWeight: FontWeight.bold),
                  ),
                 const SizedBox(height: 300,),
          Image.asset(
    'assets/bending_man.jpg',
     fit: BoxFit.cover,
          ),
          
             ],
              ),
            ),
          ),
        ],
      ),
    );
  }                  
}
