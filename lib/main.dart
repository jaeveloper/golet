import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:golet/models/user_data.dart';
import 'package:golet/screens/HomePage.dart';
//import 'package:golet/screens/HomeScreen.dart';
//import 'package:golet/screens/inhabitants.dart';
import 'package:golet/screens/login.dart';
import 'package:provider/provider.dart';
//import 'package:golet/screens/onboarding1.dart';
//import 'package:golet/screens/onboarding2.dart';
//import 'package:golet/screens/onboarding3.dart';
//import 'package:golet/screens/passwordreset.dart';
//import 'package:golet/screens/create_post_screen.dart';
//import 'package:golet/screens/profilepage.dart';
//import 'package:golet/screens/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget _getScreenId() {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.uid == null) {
            Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
            return CircularProgressIndicator();
          }
          return HomePage();
        } else {
          return Login();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {},
      builder: (context) => UserData(),
      child: MaterialApp(
        title: 'Inhabitants',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(2))),
        ),
        home: _getScreenId(),
      ),
    );
  }
}
