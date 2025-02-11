import 'package:firebase_features/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'api/chat.dart';

class UserListScreen extends StatelessWidget {
  final String currentUserId;

  UserListScreen({required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(title: const Text('Users'), backgroundColor: primaryColor),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('kusers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          var users = snapshot.data!.docs.where((doc) => doc.id != currentUserId).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              String otherUserId = user.id; // Get the other user's ID
              String displayName = user['displayName'] ?? 'Unknown User';
              String profilePhotoUrl = user['profileImageUrl'] ?? '';
              String email = user['email'] ?? '';

              return ListTile(
                leading: profilePhotoUrl.isNotEmpty
                    ? CircleAvatar(
                  backgroundImage: NetworkImage(profilePhotoUrl),
                )
                    : const CircleAvatar(child: Icon(Icons.person)),
                title: Text(displayName, style: TextStyle(color: whiteColor)),
                subtitle: email.isNotEmpty
                    ? Text(email, style: TextStyle(color: whiteColor))
                    : null, // Display email if available
                onTap: () async {
                  String chatId = await startConversation(currentUserId, otherUserId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        chatId: chatId,
                        currentUserId: currentUserId,
                        otherUserId: otherUserId, // Pass otherUserId
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<String> startConversation(String user1, String user2) async {
    String chatId = user1.hashCode <= user2.hashCode ? '$user1-$user2' : '$user2-$user1';

    var chatRef = FirebaseFirestore.instance.collection('kchat').doc(chatId);

    var chatDoc = await chatRef.get();
    if (!chatDoc.exists) {
      await chatRef.set({
        'participants': [user1, user2],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return chatId;
  }
}
