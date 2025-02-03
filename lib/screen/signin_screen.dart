import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/colors.dart';
import 'package:firebase_features/helper/dimens.dart';
import 'package:firebase_features/widgets/app_button.dart';
import 'package:firebase_features/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import '../helper/authentication.dart';
import 'converastion_list.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
          StringConstants.login,
          style: TextStyle(
              color: whiteColor,
              fontSize: Dimens.fontSize_25,
              fontFamily: Fonts.pSemibold),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              style: TextStyle(
                color: whiteColor, // Set the text color here
                fontSize: 16.0, // Optional: Set the text size
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
                fontSize: 16.0, // Optional: Set the text size
              ),
              decoration: InputDecoration(
                labelText: StringConstants.password,
                labelStyle: TextStyle(
                  color: whiteColor, // Change to your desired color
                  fontSize: 16.0, // Set the font size for the label
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: whiteColor, // Color when the field is focused
                    width: 2.0, // Width of the underline
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey, // Color when the field is not focused
                    width: 1.0, // Width of the underline
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            AppButton(
              label: StringConstants.login,
              onPressed: () async {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                User? user = await AuthService().login(email, password);
                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConversationListScreen(currentUserId: user.uid)),
                  );
                }
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text(
                StringConstants.register,
                style: TextStyle(
                    color: whiteColor,
                    fontFamily: Fonts.pSemibold,
                    fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
