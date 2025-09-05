import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intern_system/login_pages/reset_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SupervisorProfile extends StatefulWidget {
  const SupervisorProfile({super.key});

  @override
  State<SupervisorProfile> createState() => _SupervisorProfileState();
}

class _SupervisorProfileState extends State<SupervisorProfile> {
  Map<String, dynamic>? _adminData;
final TextEditingController _emailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
Future<void> _loadSupervisorData() async {
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
  _loadSupervisorData();
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
              _loadSupervisorData(); // refresh UI
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
body: Column(
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
            : AssetImage('assets/laughing.jpg'),
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
 Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      _adminData?['name'] ?? 'Loading...',
      style: TextStyle(
        color: Color.fromARGB(255, 107, 106, 106),
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
     SizedBox(width:  65,),
    IconButton(
      icon: Icon(Icons.edit, color: Colors.grey),
      onPressed: () => _editField('name', _adminData?['name']),
    ),
  ],
),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      _adminData?['branch'] ?? '',
      style: TextStyle(
        color: Color.fromARGB(255, 107, 106, 106),
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(width:  65,),
    IconButton(
      icon: Icon(Icons.edit, color: Colors.grey),
      onPressed: () => _editField('branch', _adminData?['branch']),
    ),
  ],
),

    SizedBox(height: 40,),
       
       Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      _adminData?['email'] ?? 'Loading...',
      style: TextStyle(
        color: Color.fromARGB(255, 100, 99, 99),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    IconButton(
      icon: Icon(Icons.edit, color: Colors.grey),
      onPressed: () => _editField('email', _adminData?['email']),
    ),
  ],
),

      SizedBox(height: 45,),
     SizedBox(height: 15,),
      SizedBox(height: 45,),
     Container(
  height: 50,
  width: 350,
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 254, 254, 254),
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
SizedBox(
  height: 15,
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
            child: Text('Change Password?', textAlign: TextAlign.right, style: TextStyle(color: const Color.fromARGB(255, 114, 26, 20),fontWeight: FontWeight.bold, fontSize: 18),),
          )),
        
      ),
       
  ],
),
    );
  }
}
