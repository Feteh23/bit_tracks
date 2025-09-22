import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intern_system/login_pages/reset_password.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';
class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  Map<String, dynamic>? _internData;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _numberController = TextEditingController();
final TextEditingController _branchController = TextEditingController();



  final ImagePicker _picker = ImagePicker();
   bool _isEditing = false;
  XFile? _imageFile;
Future<void> _loadInternData() async {
 final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  if (doc.exists) {
    setState(() {
      _internData = doc.data();
      _emailController.text = _internData?['email'] ?? '';
      _nameController.text = _internData?['name'] ?? '';
      _numberController.text = _internData?['number'] ?? '';
      _branchController.text = _internData?['branch'] ?? '';

    });
  }
}
@override
void initState() {
  super.initState();
  _loadInternData();
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
              _loadInternData(); // refresh UI
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
      backgroundColor: AppColors.backgroundColor,
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
      "Bit Tracks Profile",
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
body: SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: Column(
    children: [
      Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: const Color.fromARGB(255, 114, 26, 20),
          ),
          SizedBox(
            height: 250,
          ),
        Padding(
    padding: const EdgeInsets.only(left: 110, top: 100),
    child: Container(
      height: 200,
      width: 200,
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
                      height: 70, 
                      width: 70,
                      decoration: BoxDecoration(
                         color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 3, color: Colors.white)
                      ),
                      child: IconButton(onPressed: _openGallery, 
                      icon: Icon(Icons.camera_enhance, size: 50, color: const Color.fromARGB(255, 123, 123, 123),) ,)
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
        'Intern Info',
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
            style: TextStyle(color: Colors.black),
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
             style: TextStyle(color: Colors.black),
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
             style: TextStyle(color: Colors.black),
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
             style: TextStyle(color: Colors.black),
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
                  _isEditing = false;
                });
                _loadInternData(); // Refresh UI
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
      SizedBox(height: 15,),
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
              child: Text('Change Password?', textAlign: TextAlign.right, style: TextStyle(color: const Color.fromARGB(255, 114, 26, 20),fontWeight: FontWeight.bold, fontSize: 18),),
            )),
          
        ),
         
        SizedBox(height: 15,),
       Container(
    height: 50,
    width: 350,
    decoration: BoxDecoration(
      color: AppColors.backgroundColor,
      border: Border.all(
        color: Color.fromARGB(255, 135, 5, 2),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 4, left: 10),
      child: Align(
        child: TextButton(onPressed: (){},
          child: Center(child: Text('log out', style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 248, 45, 45), fontSize: 20),)),
          
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