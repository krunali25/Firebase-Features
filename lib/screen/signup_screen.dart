import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_features/helper/colors.dart';
import 'package:firebase_features/screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helper/app_assets.dart';
import '../helper/authentication.dart';
import '../helper/dimens.dart';
import '../widgets/app_button.dart';
import 'api/converastion_list.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          StringConstants.signup,
          style: TextStyle(
            color: whiteColor,
            fontSize: Dimens.fontSize_25,
            fontFamily: Fonts.pSemibold,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Image Section
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : AssetImage(AppImages.defultProfile) as ImageProvider,
                  child: _profileImage == null
                      ? Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                    size: 30,
                  )
                      : null,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                style: TextStyle(
                  color: whiteColor, // Set the text color here
                  fontSize: 16.0,    // Optional: Set the text size
                ),
                decoration: InputDecoration(
                  labelText: StringConstants.displayName,
                  labelStyle: TextStyle(
                    color: whiteColor,
                    fontSize: 16.0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: whiteColor,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: emailController,
                style: TextStyle(
                  color: whiteColor, // Set the text color here
                  fontSize: 16.0,    // Optional: Set the text size
                ),
                decoration: InputDecoration(
                  labelText: StringConstants.email,
                  labelStyle: TextStyle(
                    color: whiteColor,
                    fontSize: 16.0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: whiteColor,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: passwordController,
                style: TextStyle(
                  color: whiteColor, // Set the text color here
                  fontSize: 16.0,    // Optional: Set the text size
                ),
                decoration: InputDecoration(
                  labelText: StringConstants.password,
                  labelStyle: TextStyle(
                    color: whiteColor,
                    fontSize: 16.0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: whiteColor,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              AppButton(
                label: StringConstants.signup,
                onPressed: () async {
                  String name = nameController.text.trim();
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();

                  if (_profileImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select a profile image.")),
                    );
                    return;
                  }

                  User? user = await AuthService().signUp(email, password, name, _profileImage);
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
