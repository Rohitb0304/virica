import 'package:flutter/material.dart';
import 'package:virica/e_contacts.dart';
import 'package:virica/helpline_numbers.dart';
import 'package:virica/homepage.dart';
import 'package:virica/login_splash.dart';
import 'package:virica/logins.dart';
import 'package:virica/registration.dart';
import 'package:virica/safety-toolkit.dart';
import 'package:virica/self_defence.dart';
import 'package:virica/settings.dart';
import 'package:virica/signin.dart';
import 'package:virica/sos_homepage.dart';
import 'package:virica/splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAw5AtVZBJR8nIPvpSZ_cfJhlNeQJYhy-o",
      authDomain: "virica-app.firebaseapp.com",
      projectId: "virica-app",
      storageBucket: "virica-app.appspot.com",
      messagingSenderId: "1094268308432",
      appId: "1:1094268308432:android:07727b5c4b22e161a307d5", 
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/logins': (context) => LoginsScreen(),
        '/signup': (context) => Register(),
        '/signin': (context) => SignIn(),
        '/login_splash': (context) => Login_splash(),
        '/sos_homepage':(context) => SOSHomepage(),
        '/e_contacts':(context) => EmergencyContacts(),
        '/homepage': (context) => Homepage(),
        '/settings': (context) => SettingsPage(),
        '/safetykit': (context) => SafetyKit(),
        '/helpline':(context) => HelplineNos(),
        '/self_defence':(context) => SelfDefence(),
      },
    );
  }
}
