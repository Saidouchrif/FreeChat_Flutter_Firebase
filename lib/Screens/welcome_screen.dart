import 'package:flutter/material.dart';
import 'package:freechat_flutter_firebase/Screens/registration_screen.dart';
import 'package:freechat_flutter_firebase/Screens/signin_secreen.dart';
import 'package:freechat_flutter_firebase/widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute='welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('images/freechat_logo.png',
                  ),
                ),
                Text(
                  'FreeChat',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff2e386b),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Mybutton(
              color: Colors.green[900]!,
              title: 'Connexion',
              onPressed: () {
                Navigator.pushNamed(context, SigninSecreen.screenRoute);
              },
            ),
            Mybutton(
              color: Colors.blue[800]!,
              title: 'Inscription',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}


