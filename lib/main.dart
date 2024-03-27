import 'dart:async';
import 'dart:ui';
import 'package:chaleno/chaleno.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Card.dart' as HomeButtonCard;
import 'AppBarButtonState.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screen/NotLoginedScreen.dart' as notLoginedScreen;
import 'screen/homePageScreen.dart';

var appBarButtonState = AppBarButtonState();

User? currentuser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    print(user);
    if (user == null) {
      print(user);
      runApp(NotLoginedApp());
    } else {
      currentuser = user;
      runApp(MyApp());
    }
  });


}



class MyApp extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GothamMedium',
        textSelectionTheme:TextSelectionThemeData(
          selectionColor: Colors.green,
          cursorColor: Colors.green,
          selectionHandleColor: Colors.green,
        )
      ),

      home: MyHomePage(currentuser: currentuser),
    );
  }
}
class NotLoginedApp extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'GothamMedium',
          textSelectionTheme:TextSelectionThemeData(
            selectionColor: Colors.green,
            cursorColor: Colors.green,
            selectionHandleColor: Colors.green,
          )
      ),

      home: notLoginedScreen.NotLoginedScreen(),
    );
  }
}












