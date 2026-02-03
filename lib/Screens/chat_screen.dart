import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageTextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? messageText;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() {
    final user = _auth.currentUser;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          WelcomeScreen.screenRoute,
          (route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Row(
          children: [
            Image.asset(
              'images/logo_bien.png',
              height: 25,
            ),
            const SizedBox(width: 10),
            const Text(
              'FreeChat',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                WelcomeScreen.screenRoute,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              child: MessageStreamBuilder(),
            ),

            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final text = messageText?.trim();
                      if (text == null || text.isEmpty) return;

                      messageTextController.clear();

                      _firestore.collection('messages').add({
                        'text': text,
                        'sender': currentUser.email,
                        'time': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({
    super.key,
    required this.sender,
    required this.text,
    required this.isMe,
  });

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.green[900],
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? Colors.blue[800] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: isMe ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserEmail =
        FirebaseAuth.instance.currentUser?.email;

    if (currentUserEmail == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data!.docs.reversed;
        List<MessageLine> messageWidgets = [];

        for (var message in messages) {
          final text = message.get('text');
          final sender = message.get('sender');

          messageWidgets.add(
            MessageLine(
              sender: sender,
              text: text,
              isMe: sender == currentUserEmail,
            ),
          );
        }

        if (messageWidgets.isEmpty) {
          return const Center(
            child: Text('Aucun message'),
          );
        }

        return ListView(
          reverse: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          children: messageWidgets,
        );
      },
    );
  }
}
