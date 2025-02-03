import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/colors.dart';
import 'package:firebase_features/helper/dimens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_features/helper/message_service.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String currentUserId;
  final String otherUserId;

  const ChatScreen(
      {super.key, required this.chatId,
      required this.currentUserId,
      required this.otherUserId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  final MessageService _messageService = MessageService();
  Map<String, dynamic>? _otherUserData;

  @override
  void initState() {
    super.initState();
    _fetchOtherUserDetails();
  }

  Future<void> _fetchOtherUserDetails() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('kusers')
          .doc(widget.otherUserId)
          .get();
      if (userDoc.exists) {
        setState(() {
          _otherUserData = userDoc.data() as Map<String, dynamic>?;
        });
      }
    } catch (e) {
      print("Error  fetching user Detail: $e");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: _otherUserData?['profileImageUrl'] != null
                    ? NetworkImage(_otherUserData!['profileImageUrl'])
                    : null,
                child: _otherUserData?['profileImageUrl'] == null
                    ? Icon(
                        Icons.person,
                        size: 30,
                      )
                    : null,
              ),
              SizedBox(
                width: Dimens.width_10,
              ),
              Text(
                _otherUserData?['displayName'] ?? 'Loading...',
                style: TextStyle(fontSize: 18),
              )
            ],
          )),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messageService.getMessages(widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No messages yet."));
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message =
                        messages[index].data() as Map<String, dynamic>;
                    bool isMe = message['sender'] == widget.currentUserId;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? buttonBackground : chatColor1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (message['text'] != null &&
                                message['text'].isNotEmpty)
                              Text(
                                message['text'],
                                style: TextStyle(
                                    fontSize: Dimens.fontSize_15,
                                    color: whiteColor,
                                    fontFamily: Fonts.pMedium),
                              ),
                            if (message['imageUrl'] != null &&
                                message['imageUrl'].isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.network(
                                  message['imageUrl'],
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            SizedBox(height: 4),
                            Text(
                              (message['timestamp'] as Timestamp?)
                                      ?.toDate()
                                      .toString() ??
                                  'No timestamp',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black54),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.image,
                    color: whiteColor,
                  ),
                  onPressed: () => _messageService.pickAndSendImage(
                      widget.chatId, widget.currentUserId),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      color: whiteColor
                    ),
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: whiteColor),
                      // Change hint text color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        // Optional: Add rounded corners
                        borderSide: BorderSide(
                            color: Colors.grey), // Default border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: whiteColor,
                            width: 2), // Border color when focused
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color:
                                Colors.grey), // Border color when not focused
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: whiteColor,
                  ),
                  onPressed: () {
                    _messageService.sendMessage(
                      chatId: widget.chatId,
                      senderId: widget.currentUserId,
                      messageContent: _controller.text,
                    );
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
