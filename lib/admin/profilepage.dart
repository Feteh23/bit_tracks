import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intern_system/login_pages/reset_password.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';


class Adminprofilepage extends StatefulWidget {
  const Adminprofilepage({super.key});

  @override
  State<Adminprofilepage> createState() => _AdminprofilepageState();
}

class _AdminprofilepageState extends State<Adminprofilepage> {
  Map<String, dynamic>? _adminData;
final TextEditingController _emailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  bool _isEditing = false;

  XFile? _imageFile;
Future<void> _loadAdminData() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  if (doc.exists) {
    setState(() {
      _adminData = doc.data();
      _emailController.text = _adminData?['email'] ?? '';
    });
  }
}
@override
void initState() {
  super.initState();
  _loadAdminData();
}
void _editField(String field, String? currentValue) {
  final controller = TextEditingController(text: currentValue ?? '');
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Edit $field'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Enter new $field'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final uid = FirebaseAuth.instance.currentUser?.uid;
            if (uid != null) {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .update({field: controller.text});
              Navigator.pop(context);
              _loadAdminData(); // refresh UI
            }
          },
          child: Text('Save'),
        ),
      ],
    ),
  );
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
      backgroundColor: Colors.white,
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
      icon: Icon(Icons.book_online_outlined, color: Colors.white),
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
            padding: const EdgeInsets.only(top: 260, left: 220),
            child:Container(
                      height: screenHeight * 0.07, 
                      width: screenWidth * 0.13,
                      decoration: BoxDecoration(
                         color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
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
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.primaryColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Admin Info', style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(Icons.edit, color: AppColors.primaryColor),
              onPressed: () => setState(() => _isEditing = !_isEditing),
            ),
          ],
        ),
        SizedBox(height: 10),
        TextField(
          controller: TextEditingController(text: _adminData?['name'] ?? '',),
          enabled: _isEditing,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: 'Name',
             labelStyle: TextStyle(color: AppColors.secondaryColor,fontSize: screenWidth * 0.055),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(),
          ),
        ),
          SizedBox(height: 10),
        TextField(
          controller: TextEditingController(text: _adminData?['email'] ?? ''),
          enabled: _isEditing,
           style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: AppColors.secondaryColor,fontSize: screenWidth * 0.055),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(),
          ),
        ),
         SizedBox(height: 10),
        TextField(
          controller: TextEditingController(text: _adminData?['number'] ?? ''),
          enabled: _isEditing,
           style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: 'Phone Number',
             labelStyle: TextStyle(color: AppColors.secondaryColor, fontSize: screenWidth * 0.055),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: TextEditingController(text: _adminData?['branch'] ?? ''),
          enabled: _isEditing,
           style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: 'Branch',
             labelStyle: TextStyle(color: AppColors.secondaryColor, fontSize: screenWidth * 0.055),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(),
          ),
        ),
      ],
    ),
  ),
  
        SizedBox(height: screenHeight * 0.03,),
       Container(
    height: screenHeight * 0.07,
    width: screenWidth * 0.85,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 254, 254, 254),
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
          child: Center(child: Text('log out', style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 248, 45, 45), fontSize: screenWidth * 0.05),)),
  
        ),
      ),
    ),
  ),
  SizedBox(
    height: screenHeight * 0.02,
  ),
   TextButton(onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>ResetPassword(),
                        ));
          },
          child:  Align(
  alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Text('Change Password?', textAlign: TextAlign.right, style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05),),
            )),
          
        ),
         
    ],
  ),
),
 
    );
  }
}