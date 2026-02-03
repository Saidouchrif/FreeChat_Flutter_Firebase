import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freechat_flutter_firebase/Screens/chat_screen.dart';
import 'package:freechat_flutter_firebase/Screens/registration_screen.dart';
import 'package:freechat_flutter_firebase/widgets/my_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SigninSecreen extends StatefulWidget {
  static const String screenRoute = 'signin_screen';
  const SigninSecreen({super.key});

  @override
  State<SigninSecreen> createState() => _SigninSecreenState();
}

class _SigninSecreenState extends State<SigninSecreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? email;
  String? password;
  bool showspinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 180,
                child: Image.asset('images/freechat_logo.png'),
              ),
              const SizedBox(height: 50),

              /// 📧 Email
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value.trim();
                },
                decoration: const InputDecoration(
                  hintText: 'Saisissez votre adresse e-mail',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// 🔑 Password
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value.trim();
                },
                decoration: const InputDecoration(
                  hintText: 'Saisissez votre mot de passe',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// 🔐 Connexion
              Mybutton(
                color: Colors.green[900]!,
                title: 'Connexion',
                onPressed: () async {
                  if (email == null || password == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Veuillez remplir tous les champs'),
                      ),
                    );
                    return;
                  }

                  setState(() {
                    showspinner = true;
                  });

                  try {
                    final userCredential =
                        await _auth.signInWithEmailAndPassword(
                      email: email!,
                      password: password!,
                    );

                    if (userCredential.user != null) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        ChatScreen.screenRoute,
                        (route) => false,
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text(e.message ?? 'Erreur de connexion'),
                      ),
                    );
                  } finally {
                    setState(() {
                      showspinner = false;
                    });
                  }
                },
              ),

              const SizedBox(height: 15),

              /// 🆕 Inscription
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vous n’avez pas de compte ? ",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RegistrationScreen.screenRoute,
                      );
                    },
                    child: Text(
                      "Inscrivez-vous",
                      style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
