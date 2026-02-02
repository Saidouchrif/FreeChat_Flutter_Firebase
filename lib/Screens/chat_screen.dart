import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends StatefulWidget {
  static const String screenRoute='chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth=FirebaseAuth.instance;
  late User signedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser(){
    try{
    final user=_auth.currentUser;
    if(user!=null){
      signedInUser=user;
      print(signedInUser.email);
    }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Row(
          children: [
            Image.asset(
              'images/logo_bien.png',
              height: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text('FreeChat',
            style: TextStyle(
              color: Colors.white
            ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.close,
            color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                top: BorderSide(
                  color: Colors.green,
                  width: 2,
              ),
              ),
              ),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: TextField(
                    onChanged: (value){

                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      hintText: 'Write your message here....',
                      border: InputBorder.none,
                    ),
                  ),
                  ),
                  TextButton(
                    onPressed: (){

                    },
                    child: Text('Send',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    ),
                  )
                ],
              ) ,
            )
          ],
        ),
      ),
    );
  }
}
