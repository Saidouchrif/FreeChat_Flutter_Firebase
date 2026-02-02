import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freechat_flutter_firebase/Screens/chat_screen.dart';
import 'package:freechat_flutter_firebase/widgets/my_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenRoute = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              child: Image.asset('images/freechat_logo.png'),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter Your Email',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter Your Password',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Mybutton(
                color: Colors.blue[800]!,
                onPressed: ()async { 
                  try{
                  final newUser =await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  Navigator.pushNamed(context, ChatScreen.screenRoute);
                  }catch(e){
                    print(e);
                  }
                },
                title: 'Register')
          ],
        ),
      ),
    );
  }
}
