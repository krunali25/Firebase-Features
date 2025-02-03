import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_features/screen/user_list.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign Up
  Future<User?> signUp(String email, String password, String name, [File? profileImage]) async {
    try {
      // Sign up user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Store additional user information in Firestore
        final userRef = FirebaseFirestore.instance.collection('kusers').doc(user.uid);

        // Optional: Upload profile image if provided
        String? profileImageUrl;
        if (profileImage != null) {
          // Add image upload logic (e.g., Firebase Storage)
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('profile_images')
              .child('${user.uid}.jpg');
          await storageRef.putFile(profileImage);
          profileImageUrl = await storageRef.getDownloadURL();
        }

        await userRef.set({
          'displayName': name,
          'email': email,
          'profileImageUrl': profileImageUrl ?? '', // Default to empty string if no image
          'isOnline': false, // Default status
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return user;
    } catch (e) {
      print('Error during signup: $e');
      return null;
    }
  }

  // Login
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('kusers').doc(user.uid).update({
          'isOnline': true,
        });
      }

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('kusers').doc(user.uid).update({
        'isOnline': false,
        'lastSeen': FieldValue.serverTimestamp(),
      });
    }
    await _auth.signOut();
  }
}
