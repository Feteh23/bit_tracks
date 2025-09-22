import 'package:flutter/material.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isLoading = false;
  final TextEditingController emailController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
  backgroundColor: AppColors.primaryColor,
  leading:
  IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white,),
    onPressed: () {
      Navigator.pop(context);
    },
  ),

   title: Text( "Bit Tracks Reset Password", style: TextStyle(fontSize: screenWidth * 0.05,color: Colors.white,fontWeight: FontWeight.bold)),
  actions: [
    IconButton(
      icon: Icon(Icons.book_online_outlined, color: Colors.white),
      onPressed: () {
      },
    ),
  ],
),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
             SizedBox(height: screenHeight * 0.05),
              Image.asset('assets/standing_girl.jpg', fit: BoxFit.cover,  width: screenWidth * 0.85,height: screenHeight * 0.4,),
              SizedBox(height: screenHeight * 0.05),
                LabeledTextField(
                labelText: 'Email',
                hintText: 'Enter your email',
                controller: emailController,
              ),
              SizedBox(height: screenHeight * 0.055),
              ReusableButton(
                buttonText: 'send reset link',
               onPressed: () async {
  setState(() {
    _isLoading = true;
  });

  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: emailController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reset link sent to your email')),
    );
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message ?? 'Error occurred')),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
},
     isLoading: _isLoading,
              ),
          ],
        ),
      ),
    );
  }
}