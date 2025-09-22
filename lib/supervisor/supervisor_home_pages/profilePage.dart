import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';
import 'package:intern_system/login_pages/reset_password.dart';

class SupervisorProfile extends StatefulWidget {
  const SupervisorProfile({super.key});

  @override
  State<SupervisorProfile> createState() => _SupervisorProfileState();
}

class _SupervisorProfileState extends State<SupervisorProfile> {
   Map<String, dynamic>? _supervisorData;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _numberController = TextEditingController();
final TextEditingController _branchController = TextEditingController();


  final ImagePicker _picker = ImagePicker();
    bool _isEditing = false;
  XFile? _imageFile;
Future<void> _loadSupervisorData() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  if (doc.exists) {
    setState(() {
     _supervisorData = doc.data();
      _emailController.text = _supervisorData?['email'] ?? '';
      _nameController.text = _supervisorData?['name'] ?? '';
      _numberController.text = _supervisorData?['number'] ?? '';
      _branchController.text = _supervisorData?['branch'] ?? '';

    });
  }
}
@override
void initState() {
  super.initState();
  _loadSupervisorData();
}
void _openGallery() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    setState(() {
      _imageFile = image;
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
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
    onPressed: () {
      Navigator.pop(context);
    },
  ),

  title: Align(
    child: Text(
      "Bit Tracks Profile",
      style: TextStyle(
        fontSize: screenWidth * 0.05,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.book_online_outlined, color: AppColors.backgroundColor),
      onPressed: () {
        // Add your action here
      },
    ),
  ],

),
body: SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: Column(
    children: [
      Stack(
        children: [
          Container(
            height: screenHeight * 0.2,
            width: double.infinity,
            color: AppColors.primaryColor,
          ),
          SizedBox(
            height: screenHeight * 0.1,
          ),
        Padding(
    padding: const EdgeInsets.only(left: 110, top: 100),
    child: Container(
      height: screenHeight * 0.2,
      width: screenHeight * 0.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: _imageFile != null
              ? (kIsWeb
                  ? NetworkImage(_imageFile!.path)
                  : FileImage(File(_imageFile!.path)) as ImageProvider)
              : AssetImage('assets/me.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(100)),
        border: Border.all(width: 3, color: Colors.white),
      ),
    ),
  ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.26, left: screenWidth * 0.55),
            child:Container(
                      height: screenHeight * 0.07, 
                      width: screenHeight * 0.07,
                      decoration: BoxDecoration(
                         color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width: 3, color: Colors.white)
                      ),
                      child: IconButton(onPressed: _openGallery, 
                      icon: Icon(Icons.camera_enhance, size: screenWidth * 0.1, color: AppColors.secondaryColor,) ,)
                    ),
          ),
        ],
      ),
   Container(
    margin: EdgeInsets.all(20),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.backgroundColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.primaryColor),
    ),
   
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Supervisor Info',
      style: TextStyle(
        fontSize: screenWidth * 0.05,
        fontWeight: FontWeight.bold,
      ),
    ),
    IconButton(
      icon: Icon(Icons.edit, color: AppColors.primaryColor),
      onPressed: () {
        setState(() {
          _isEditing = true;
        });
      },
    ),
  ],
),
SizedBox(height: 10),

     TextField(
          controller: _nameController,
          enabled: _isEditing,
          style: TextStyle(color: AppColors.secondaryColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(),
          ),
        ),
          SizedBox(height: 10),
        TextField(
          controller: _emailController,
          enabled: _isEditing,
           style: TextStyle(color: AppColors.secondaryColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(),
          ),
        ),
         SizedBox(height: 10),
        TextField(
          controller: _numberController,
          enabled: _isEditing,
           style: TextStyle(color: AppColors.secondaryColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _branchController,
          enabled: _isEditing,
           style: TextStyle(color: AppColors.secondaryColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: screenHeight * 0.02,),
    if (_isEditing)
      Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.25),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
          ),
          onPressed: () async {
            final uid = FirebaseAuth.instance.currentUser?.uid;
            if (uid != null) {
              await FirebaseFirestore.instance.collection('users').doc(uid).update({
                'name': _nameController.text.trim(),
                'email': _emailController.text.trim(),
                'number': _numberController.text.trim(),
                'branch': _branchController.text.trim(),
              });
              setState(() {
                _isEditing = true;
              });
              _loadSupervisorData(); // Refresh UI
               ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully'),
        backgroundColor: AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );

            }
          },
          child: Text('Save Changes', style: TextStyle(color: Colors.white)),
        ),
      ),
  ],
),

   ),
    Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPassword())),
                child: Text('Change Password', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05),),
              ),
            ),
    SizedBox(height: screenHeight * 0.015,),
       Container(
    height: screenHeight * 0.055,
    width: screenWidth * 0.9,
    decoration: BoxDecoration(
      color: AppColors.backgroundColor,
      border: Border.all(
        color: AppColors.primaryColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 4, left: 10),
      child: Align(
        child: TextButton(onPressed: (){},
          child: Center(child: Text('log out', style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 248, 45, 45), fontSize: screenWidth * 0.045),)),
  
        ),
      ),
    ),
  ),
   
      ],
    ),
  ),  
    );
  }
}
