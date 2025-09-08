import 'package:flutter/material.dart';
import 'package:intern_system/login_pages/login.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';


class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background container
          Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.backgroundColor,
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
                    style: TextStyle(color: AppColors.primaryColor, fontSize: screenWidth * 0.15, fontWeight: FontWeight.bold),
                  ),
                 SizedBox(height: screenHeight * 0.3,),
          Flexible(
            child: Image.asset(
                'assets/bending_man.jpg',
                 fit: BoxFit.cover,
                 width: screenWidth * 0.8,
                 height: screenHeight * 0.4,
            ),
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
