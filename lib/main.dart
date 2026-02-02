import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freechat_flutter_firebase/Screens/chat_screen.dart';
import 'package:freechat_flutter_firebase/Screens/registration_screen.dart';
import 'package:freechat_flutter_firebase/Screens/signin_secreen.dart';
import 'package:freechat_flutter_firebase/Screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreeChat app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: 'welcome_screen',
      routes: {
        WelcomeScreen.screenRoute : (context) => WelcomeScreen(),
        SigninSecreen.screenRoute: (context) => SigninSecreen(),
        RegistrationScreen.screenRoute: (context) => RegistrationScreen(),
        ChatScreen.screenRoute: (context) => ChatScreen(),
      },
    );
  }
}
