import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_features/helper/colors.dart';
import 'package:firebase_features/helper/dimens.dart';
import 'package:firebase_features/screen/user_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../helper/app_assets.dart';
import '../helper/navigation.dart';
import '../helper/routes.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/background.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({Key? key}) : super(key: key);

  @override
  _FirestoreScreenState createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();




  // Add Data to Firestore
  Future<void> addData(String name, int age, String email) async {
    if (name.isEmpty || email.isEmpty || age <= 0) {
      print("Error: Invalid data. Please provide valid name, age, and email.");
      return;
    }

    try {
      await _firestore.collection('kusers').add({
        'name': name,
        'age': age,
        'email': email,
      });
      print("Data added successfully!");
    } catch (e) {
      print("Error adding data: $e");
    }
  }

  // Read Data from Firestore
  Stream<QuerySnapshot> readData() {
    return _firestore.collection('kusers').snapshots();
  }

  // Update Data in Firestore
  Future<void> updateData(String docId, String name, int age, String email) async {
    try {
      await _firestore
          .collection('kusers')
          .doc(docId)
          .update({'name': name, 'age': age, 'email': email});
      print("Data updated successfully!");
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  // Delete Data from Firestore
  Future<void> deleteData(String docId) async {
    try {
      await _firestore.collection('kusers').doc(docId).delete();
      print("Data deleted successfully!");
    } catch (e) {
      print("Error deleting data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const Background(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  StringConstants.firestoreDemo, // Replace StringConstants.login if not defined
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: Dimens.fontSize_25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Dimens.height_10,),
                AppTextField(
                  borderColor: Colors.white,
                  titleText: "",
                  controller: _nameController,
                  hintText: StringConstants.name,
                  decoration:
                      const InputDecoration(labelText: StringConstants.name),
                ),
                AppTextField(
                  titleText: "",
                  controller: _ageController,
                  hintText: StringConstants.age,
                  decoration:
                      const InputDecoration(labelText: StringConstants.age),
                ),
                AppTextField(
                  titleText: "",
                  controller: _emailController,
                  hintText: StringConstants.email,
                  decoration:
                  const InputDecoration(labelText: StringConstants.email),
                ),
                SizedBox(
                  height: Dimens.height_10,
                ),
                AppButton(
                    label: StringConstants.addData,
                  onPressed: () {
                    String name = _nameController.text.trim();
                    String email = _emailController.text.trim();
                    String ageText = _ageController.text.trim();

                    if (name.isEmpty || email.isEmpty || ageText.isEmpty) {
                      print("Error: All fields must be filled out.");
                      return;
                    }

                    int age = int.tryParse(ageText) ?? 0;
                    if (age <= 0) {
                      print("Error: Age must be a valid number greater than 0.");
                      return;
                    }

                    addData(name, age, email);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: Dimens.height_20,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6A11CB),
                    Color(0xFF2575FC),
                    Color(0xFF833AC7)
                  ], // Define your gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                ),
              ),
              child: Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: readData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final users = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        var user = users[index];
                        var userData = user.data() as Map<String, dynamic>;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            title: Text(
                              userData['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimens.fontSize_16,
                                  fontFamily: Fonts.pSemibold),
                            ),
                            subtitle: Text(
                              'Age: ${userData['age']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimens.fontSize_16,
                                  fontFamily: Fonts.pSemibold),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: whiteColor,
                                  ),
                                  onPressed: () {
                                    _nameController.text = userData['name'];
                                    _ageController.text =
                                        userData['age'].toString();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Edit User'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                controller: _nameController,
                                                style: TextStyle(
                                                  color: whiteColor,
                                                ),
                                                decoration: const InputDecoration(
                                                    labelText: 'Name',
                                                    fillColor: whiteColor),
                                              ),
                                              TextField(
                                                controller: _ageController,
                                                decoration: const InputDecoration(
                                                    labelText: 'Age'),
                                                keyboardType: TextInputType.number,
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                String updatedName =
                                                    _nameController.text;
                                                int updatedAge =
                                                    int.parse(_ageController.text);
                                                String updatedEmail =
                                                    _emailController.text;
                                                updateData(user.id, updatedName,
                                                    updatedAge,updatedEmail);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Save'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: whiteColor,
                                  ),
                                  onPressed: () {
                                    deleteData(user.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
