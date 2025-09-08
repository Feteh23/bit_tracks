import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final branchController = TextEditingController();
  final phoneController = TextEditingController();
  String selectedRole = 'intern'; // default role
  bool _ischecked = true; 

  Future<void> signUpUser() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'branch': branchController.text.trim(),
        'role': selectedRole,
        'uid': uid, 
      });

      if (selectedRole == 'admin') {
        Navigator.pushReplacementNamed(context, '/adminDashboard');
      } else if (selectedRole == 'supervisor') {
        Navigator.pushReplacementNamed(context, '/supervisorDashboard');
      } else {
        Navigator.pushReplacementNamed(context, '/internDashboard');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${e.toString()}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 255, 255, 255),),)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
    return   Scaffold(
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

  title: Align(
    child: Text(
      "Bit Tracks SignUp",style: TextStyle(fontSize: screenWidth * 0.05,fontWeight: FontWeight.bold,color: Colors.white,),
      textAlign: TextAlign.center,
    ),
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.book_online_outlined, color: Colors.white),
      onPressed: () {
        
      },
    ),
  ],

),

body: Padding(
  padding: const EdgeInsets.only(left: 25, right: 25),
  child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      children: [
        SizedBox(
          height: screenHeight * 0.05,
        ),
         Image.asset(
        'assets/typing_girl.jpg',
         fit: BoxFit.cover,
         height: screenHeight * 0.3,
         width: screenWidth * 0.85,
              ),
               SizedBox(height: screenHeight * 0.02,),
               LabeledTextField(
                 labelText: 'Name',
                 hintText: 'Enter your name',
                 controller: nameController,
               ),
                SizedBox(height: screenHeight * 0.02,),
               LabeledTextField(
                 labelText: 'Email',
                 hintText: 'Enter your email',
                 controller: emailController,
               ),
                SizedBox(height: screenHeight * 0.02,),
                LabeledTextField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  obscureText: _ischecked,
                  controller: passwordController,
                  suffixIcon: IconButton(
                    icon: Icon(_ischecked ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _ischecked = !_ischecked;
                      });
                    },
                  ),
                ),
                 SizedBox(height: screenHeight * 0.02,),
                LabeledTextField(
                 labelText: 'Number',
                 hintText: 'Enter your number',
                controller: phoneController,
                keyboardType: TextInputType.phone,
                ),
                  SizedBox(height: screenHeight * 0.02,),
          LabeledTextField(
            labelText: 'Branch',
            hintText: 'Enter your branch',
            controller: branchController,
          ),
         SizedBox(
          height: screenHeight * 0.022,
         ),
        Container(
      height: screenHeight * 0.06,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        border: Border.all(
          color: AppColors.secondaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4, left: 10),
        child: Align(
          child: TextButton(
      onPressed: () async {
        try {
          final userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
    
          final uid = userCredential.user!.uid;
    
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'branch': branchController.text.trim(),
            'role': selectedRole,
          });
    
          // Navigate based on role
          if (selectedRole == 'admin') {
            Navigator.pushReplacementNamed(context, '/adminDashboard');
          } else if (selectedRole == 'supervisor') {
            Navigator.pushReplacementNamed(context, '/supervisorDashboard');
          } else {
            Navigator.pushReplacementNamed(context, '/internDashboard');
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signup failed: ${e.toString()}')),
          );
        }
      },
      child: Center(
        child: Text(
          'SignUp',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: screenWidth * 0.05),
        ),
      ),
    )
    
        ),
      ),
    ),
      ],
    ),
  ),
),

    );

  }
}