import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intern_system/login_pages/login.dart';
import 'package:intern_system/login_pages/reset_password.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_system/reusablewigets.dart';
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
  backgroundColor: AppColors.primaryColor,
  leading: IconButton(
  icon: Icon(Icons.arrow_back, color: Colors.white, ),
  onPressed: () {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  },
),


  title: Align(
    child: Text(
      "Bit Tracks Profile",
      style: TextStyle(
        fontSize: screenWidth*0.045,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.book_online_outlined, color: Colors.white),
      onPressed: () {},
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
            height: screenHeight*0.2,
            width: double.infinity,
            color: AppColors.primaryColor,
          ),
          SizedBox(
            height: screenHeight*0.25,
          ),
      Padding(
  padding:  EdgeInsets.only(left: screenWidth*0.22, top: screenHeight*0.06),
  child: Container(
    height: screenHeight*0.25,
    width: screenHeight*0.25,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 252, 247, 247),
      borderRadius: BorderRadius.all(Radius.circular(100)),
      border: Border.all(width: 3, color: Colors.white),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(200),
      child: _imageFile != null
          ? (kIsWeb
              ? Image.network(_imageFile!.path, fit: BoxFit.cover)
              : Image.file(File(_imageFile!.path), fit: BoxFit.cover))
          : Center(
              child: Icon(
                Icons.person,
                size: screenWidth*0.6,
                color: AppColors.secondaryColor,
              ),
            ),
    ),
  ),
),


          Padding(
            padding:EdgeInsets.only(top: screenHeight * 0.25, left: screenWidth * 0.6),
            child:Container(
                      height: screenHeight*0.07, 
                      width: screenHeight*0.07,
                      decoration: BoxDecoration(
                         color: Color.fromARGB(255, 252, 247, 247),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 3, color: Colors.white)
                      ),
                      child: IconButton(onPressed: _openGallery, 
                      icon: Icon(Icons.camera_enhance, size: 50, color: AppColors.secondaryColor,) ,)
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
            style: TextStyle(color: AppColors.textColor),
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
             style: TextStyle(color: AppColors.textColor),
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
             style: TextStyle(color: AppColors.textColor),
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
             style: TextStyle(color: AppColors.textColor),
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
      SizedBox(height: screenHeight*0.02,),
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
         
        SizedBox(height:  screenHeight*0.02,),
       Padding(
         padding: const EdgeInsets.all(15.0),
         child: Container(
             height: screenHeight*0.045,
             width: double.infinity,
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
          child: TextButton(onPressed: (){
             Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Homepage(),
                                )
                                );
          },
            child: Center(child: Text('log out', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: screenWidth*0.04),)),
            
          ),
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