import 'package:flutter/material.dart';
import 'package:intern_system/login_pages/signup.dart';
import 'package:intern_system/login_pages/reset_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      SnackBar(content: Text('Please enter both email and password')),
    );
    return;
  }
  if (!_termsAccepted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please accept the terms and conditions')),
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
      SnackBar(content: Text('Login failed: ${e.toString()}')),
    );
  } finally {
    setState(() => _isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 26, 20),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Bit Tracks Login", style: TextStyle(fontSize: 20,
        color: Colors.white,
         fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.book_online_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset('assets/standing_girl.jpg', fit: BoxFit.cover),
            SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "e.g fetehmireillelareine@gmail.com",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 8),
            TextField(
              controller: passwordController,
              obscureText: _isPasswordHidden,
              decoration: InputDecoration(
                hintText: "Enter your password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordHidden ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() => _isPasswordHidden = !_isPasswordHidden);
                  },
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPassword())),
                child: Text('Forgot Password?', style: TextStyle(color: Color.fromARGB(255, 114, 26, 20))),
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

            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 100, 99, 99)),
                onPressed: loginUser,
                child: _isLoading
                    ? CircularProgressIndicator(color: const Color.fromARGB(255, 114, 26, 20))
                    : Text('Login', style: TextStyle(fontSize: 18,
                    color: Colors.white,
                     fontWeight: FontWeight.bold)),
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Signup())),
                  child: Text('Sign Up', style: TextStyle(color: Color.fromARGB(255, 114, 26, 20))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
