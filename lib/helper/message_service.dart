import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<String> createConversation(String userID1, String userID2) async {
    try {
      // Create a new conversation with two participants
      var conversationRef = await FirebaseFirestore.instance.collection('kchat').add({
        'participants': [userID1, userID2],
      });

      // Return the conversation ID
      return conversationRef.id;
    } catch (e) {
      print('Error creating conversation: $e');
      return '';
    }
  }

  /// **Sends a message (Text or Image) to Firestore**
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    String? messageContent,
    String? imageUrl,
  }) async {
    try {
      await _firestore.collection('kchat').doc(chatId).collection('messages').add({
        'sender': senderId,
        'text': messageContent ?? '',
        'imageUrl': imageUrl ?? '',
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("Message sent successfully!");
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  /// **Picks an image from the gallery and uploads it to Firebase Storage**
  Future<void> pickAndSendImage(String chatId, String senderId) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String imageUrl = await _uploadImage(imageFile);
        await sendMessage(chatId: chatId, senderId: senderId, imageUrl: imageUrl);
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  /// **Uploads an image to Firebase Storage**
  Future<String> _uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('chat_images/$fileName.jpg');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }

  /// **Retrieves messages from Firestore**
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('kchat')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
