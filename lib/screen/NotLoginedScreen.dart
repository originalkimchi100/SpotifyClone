import 'package:flutter/material.dart';
import '../Colors.dart';
import 'LoginScreen.dart' as loginScreen;
import 'SignedUpPage.dart' as signUpPage;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotLoginedScreen extends StatelessWidget {
  //const NotAuthCase({super.key});

  final definedColors = DefinedColors();

  @override
  Widget build(BuildContext buildContext){

    return Scaffold(
        resizeToAvoidBottomInset : false,

        body:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child:
            Container(
                color: Colors.black,
                child: Center(
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/Images/SpotifyLogo.png'
                            )
                        )


                    ),

                  ),


                ))
            ),
            Expanded(child:
            Container(
              color: Colors.black,
              child: Text("Discover your next favorite playlist.",style: TextStyle(fontSize: 30, color: definedColors.textColor,fontFamily: 'GothamMedium',fontWeight: FontWeight.bold), textAlign: TextAlign.center,),

            )
            ),
            Expanded(child:
            Container(
              width: double.infinity,
              color: Colors.black,
              child: Column(children: [
                ElevatedButton(

                  onPressed: (){
                    Navigator.push(buildContext, MaterialPageRoute(builder: (context) => signUpPage.signUpCase()));

                  }, child: Text("Sign up",style: TextStyle(color: definedColors.selectedTextColor),),style: ElevatedButton.styleFrom(
                  backgroundColor: definedColors.selectedColor,
                  padding: EdgeInsets.symmetric(horizontal: 125),

                ),),
                SizedBox(
                  width:300,

                  child: OutlinedButton(onPressed:() async{

                    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                    // Obtain the auth details from the request
                    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                    // Create a new credential
                    final credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth?.accessToken,
                      idToken: googleAuth?.idToken,
                    );

                    // Once signed in, return the UserCredential
                    await FirebaseAuth.instance.signInWithCredential(credential);

                  },
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          child: Image(
                            image: AssetImage('assets/Images/GoogleLogo.png'),
                          ),
                        ),
                        SizedBox(width: 30,),
                        Text("Continue with Google",style: TextStyle(color: definedColors.textColor),),
                      ],

                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.only(
                        left: 10,
                      ),

                    ),
                  ),
                ),
                SizedBox(
                  width:300,

                  child: OutlinedButton(onPressed:(){
                    print("hello world");
                  },
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 17, height:40),
                        Container(
                          height: 28,
                          child: Image(
                            image: AssetImage('assets/Images/FacebookLogo.png'),
                          ),
                        ),
                        SizedBox(width: 30,),
                        Text("Continue with Facebook",style: TextStyle(color: definedColors.textColor),),

                      ],

                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.only(
                        right: 10,
                      ),

                    ),
                  ),
                ),
                TextButton(

                  onPressed: (){
                    Navigator.push(buildContext, MaterialPageRoute(builder: (context) => loginScreen.LoginCase()));

                  }, child: Text("Log in",style: TextStyle(color: definedColors.textColor),),
                ),



              ],),
            ),
            ),
          ],
        )
    );

  }

}