import 'package:firebase_features/helper/colors.dart';
import 'package:firebase_features/screen/chat.dart' as chat_screen;
import 'package:firebase_features/screen/user_list.dart' as user_list;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationListScreen extends StatelessWidget {
  final String currentUserId;

  ConversationListScreen({required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Conversations'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => user_list.UserListScreen(currentUserId: currentUserId),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: primaryColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('kchat')
            .where('participants', arrayContains: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No conversations yet",style: TextStyle(color: whiteColor),));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              List<dynamic> participants = doc['participants'];

              // Get recipient's ID (other than the current user)
              String recipientId = participants.firstWhere((id) => id != currentUserId, orElse: () => '');

              if (recipientId.isEmpty) return SizedBox();

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('kusers').doc(recipientId).get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                    return ListTile(
                      title: Text("Unknown User", style: TextStyle(color: whiteColor)),
                      subtitle: Text("User not found", style: TextStyle(color: whiteColor)),
                      leading: CircleAvatar(child: Icon(Icons.person)),
                    );
                  }

                  var userData = userSnapshot.data!;
                  String displayName = userData['displayName'] ?? 'Unknown User';
                  String profileImageUrl = userData['profileImageUrl'] ?? '';

                  // Fetch last message from subcollection
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('kchat')
                        .doc(doc.id)
                        .collection('messages')
                        .orderBy('timestamp', descending: true)
                        .limit(1)
                        .snapshots(),
                    builder: (context, messageSnapshot) {
                      String lastMessage = "No messages yet";

                      if (messageSnapshot.hasData && messageSnapshot.data!.docs.isNotEmpty) {
                        var lastMsgData = messageSnapshot.data!.docs.first;
                        var lastMsgMap = lastMsgData.data() as Map<String, dynamic>?;

                        lastMessage = (lastMsgMap != null && lastMsgMap.containsKey('imageUrl') &&
                            lastMsgMap['imageUrl'] != null &&
                            lastMsgMap['imageUrl'].toString().isNotEmpty)
                            ? "Image"
                            : lastMsgMap?['text'] ?? "No messages";
                      }

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: profileImageUrl.isNotEmpty
                              ? NetworkImage(profileImageUrl)
                              : AssetImage('assets/default_profile.png') as ImageProvider,
                        ),
                        title: Text(displayName, style: TextStyle(color: whiteColor)),
                        subtitle: Text(lastMessage, style: TextStyle(color: whiteColor)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => chat_screen.ChatScreen(
                                chatId: doc.id,
                                currentUserId: currentUserId,
                                otherUserId: recipientId,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
