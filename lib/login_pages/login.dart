import 'package:flutter/material.dart';
import 'package:intern_system/login_pages/signup.dart';
import 'package:intern_system/login_pages/reset_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  
  bool _isPasswordHidden = true;
  bool _termsAccepted = false;
  bool _isLoading = false;

Future<String> getUserRole(String uid) async {
  final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
  final doc = await docRef.get();

  if (!doc.exists) {
    // Create default role if missing
    await docRef.set({'role': 'intern'});
    return 'intern';
  }

  final role = doc.data()?['role'];
  return role ?? 'intern';
}

void loginUser() async {
  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please enter both email and password',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 255, 255, 255),),)),
    );
    return;
  }
  if (!_termsAccepted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please accept the terms and conditions',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 255, 255, 255),),)),
    );
    return;
  }
  setState(() => _isLoading = true);
  try {
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    final uid = userCredential.user!.uid;
    final role = await getUserRole(uid);
    if (!mounted) return;
    if (role == 'admin') {
      Navigator.pushReplacementNamed(context, '/adminDashboard');
    } else if (role == 'supervisor') {
      Navigator.pushReplacementNamed(context, '/supervisorDashboard');
    } else {
      Navigator.pushReplacementNamed(context, '/internDashboard');
    }
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login failed: ${e.toString()}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 255, 255, 255),),)),
    );
  } finally {
    setState(() => _isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Bit Tracks Login", style: TextStyle(fontSize: screenWidth * 0.05,color: Colors.white,fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.book_online_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20,),
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

            SizedBox(height: screenHeight * 0.02),
           
            LabeledTextField(
              labelText: 'Password',
              hintText: 'Enter your password',
              obscureText: _isPasswordHidden,
              controller: passwordController,
              suffixIcon: IconButton(
                icon: Icon(_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _isPasswordHidden = !_isPasswordHidden),
              ),
            ),
            
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPassword())),
                child: Text('Forgot Password?', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _termsAccepted,
                  onChanged: (value) => setState(() => _termsAccepted = value!),
                ),
                Text('I accept all terms and conditions', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),
            ReusableButton(
              buttonText: 'Login',
              onPressed: loginUser,
              isLoading: _isLoading,
            ),

            SizedBox(height: screenHeight * 0.02),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Signup())),
                  child: Text('Sign Up', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
