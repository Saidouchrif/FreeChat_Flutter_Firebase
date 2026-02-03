import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freechat_flutter_firebase/Screens/chat_screen.dart';
import 'package:freechat_flutter_firebase/Screens/signin_secreen.dart';
import 'package:freechat_flutter_firebase/widgets/my_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenRoute = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? email;
  String? password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
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

              Mybutton(
                color: Colors.blue[800]!,
                title: 'Inscription',
                onPressed: () async {
                  if (email == null || password == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Veuillez remplir tous les champs'),
                      ),
                    );
                    return;
                  }

                  setState(() {
                    showSpinner = true;
                  });

                  try {
                    final newUser =
                        await _auth.createUserWithEmailAndPassword(
                      email: email!,
                      password: password!,
                    );

                    if (newUser.user != null) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        ChatScreen.screenRoute,
                        (route) => false,
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Cet e-mail est déjà utilisé. "
                            "Veuillez vous connecter ou contacter le support si le problème persiste.",
                          ),
                          action: SnackBarAction(
                            label: 'Connexion',
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                SigninSecreen.screenRoute,
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text(e.message ?? 'Erreur lors de l’inscription'),
                        ),
                      );
                    }
                  } finally {
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vous avez déjà un compte ? ",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        SigninSecreen.screenRoute,
                      );
                    },
                    child: Text(
                      "Connectez-vous",
                      style: TextStyle(
                        color: Colors.blue,
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
