import 'dart:io';
import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/dimens.dart';
import 'package:firebase_features/widgets/app_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../helper/colors.dart';

class ImageUploads extends StatefulWidget {
  const ImageUploads({super.key});

  @override
  _ImageUploadsState createState() => _ImageUploadsState();
}

class _ImageUploadsState extends State<ImageUploads> {
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  // Method to pick an image from the gallery
  Future<void> imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Method to pick an image from the camera
  Future<void> imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Upload the image to Firebase Storage
  Future<void> _uploadFile() async {
    if (_photo == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      // Create a file name using the original file name
      final fileName = basename(_photo!.path);

      // Define the path in Firebase Storage
      final destination = 'uploads/$fileName';

      // Upload to Firebase Storage
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      await ref.putFile(_photo!);

      // Get the download URL
      final downloadUrl = await ref.getDownloadURL();

      // Show the URL or save it in Firestore if needed
      print("Download URL: $downloadUrl");

      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully!')),
      );

      setState(() {
        _photo = null; // Clear the selected image
      });
    } catch (e) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimens.padding_30),
          child: Column(
            children: <Widget>[
              Text(StringConstants.image,
              style: TextStyle(
                color: whiteColor,
                fontSize: Dimens.fontSize_25,
                fontFamily: Fonts.pBold
              ),
              ),
              SizedBox(height: Dimens.height_30),
              Center(
                child: Container(
                  child: _photo != null
                      ? Image.file(
                    _photo!,
                    width: Dimens.width_300,
                    height: Dimens.height_200,
                    fit: BoxFit.fitHeight,
                  )
                      : Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    width: Dimens.width_300,
                    height: Dimens.height_200,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimens.height_20),
              AppButton(label: StringConstants.pickImage, onPressed: (){
                _showPicker(context);
              }),
              SizedBox(height: Dimens.height_20),
              UploadImageButton(
                onPressed: _isUploading ? () {} : () => _uploadFile(), // Empty function when uploading
                label: StringConstants.uploadImage,
                child: _isUploading
                    ? CircularProgressIndicator()
                    : Text(''),
              ),
        
            ],
          ),
        ),
      ),
    );
  }

  // Show picker to select between gallery or camera
  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(StringConstants.gallery),
                onTap: () {
                  imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text(StringConstants.camera),
                onTap: () {
                  imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
