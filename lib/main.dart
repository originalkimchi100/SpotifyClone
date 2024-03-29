import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screen/NotLoginedScreen.dart' as notLoginedScreen;
import 'screen/homePageScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

User? currentuser;
FirebaseAuth? user;

void main() async {


  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth auth = FirebaseAuth.instance;


  final db = FirebaseFirestore.instance;


  if(auth.currentUser == null){
    runApp(NotLoginedApp());
  }
  else{
    user = auth;
    runApp(MyApp());

  }


}




class MyApp extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: MyHomePage(currentuser: user!.currentUser),
    );
  }
}

class NotLoginedApp extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: notLoginedScreen.NotLoginedScreen(),
    );
  }
}




ThemeData themeData(){
  return ThemeData(
      fontFamily: 'GothamMedium',
      textSelectionTheme:TextSelectionThemeData(
        selectionColor: Colors.green,
        cursorColor: Colors.green,
        selectionHandleColor: Colors.green,
      )
  );
}




