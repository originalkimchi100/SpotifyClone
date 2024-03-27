import 'package:flutter/material.dart';
import '../Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginCase extends StatefulWidget {
  @override
  _LoginCase createState() => _LoginCase();
}
class _LoginCase extends State<LoginCase>{
  var definedColors = DefinedColors();

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.black,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(children: [SizedBox(width: 10,),Text("Email or username",style: TextStyle(color: definedColors.textColor, fontSize: 30,fontWeight: FontWeight.bold),),]),
              Row(
                children: [
                  SizedBox(width: 10,height: 20,),
                  Container(
                    width: 320,
                    child: TextField(
                      controller: idController,
                      decoration: InputDecoration(

                          filled: true,
                          fillColor: definedColors.buttonColor,
                          enabledBorder: OutlineInputBorder(
                          ),
                          border: InputBorder.none

                      ), cursorColor: definedColors.textColor, style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                  ),
                ],
              ),
              Row(children: [SizedBox(width: 10,),Text("Password",style: TextStyle(color: definedColors.textColor, fontSize: 20,fontWeight: FontWeight.bold),),]),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Container(
                    width: 320,
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      controller: passwordController,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: definedColors.buttonColor,
                        enabledBorder: OutlineInputBorder(
                        ),
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _togglevisibility();
                          },
                          child: Icon(
                            _showPassword ? Icons.visibility : Icons
                                .visibility_off, color: Colors.white,),
                        ),
                      ), cursorColor: definedColors.textColor, style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: ElevatedButton(onPressed: () async{


                    try {
                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: idController.text,
                          password: passwordController.text
                      );
                      print(credential.user);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }

                    }

                  },
                    child: Text("Log in", style: TextStyle(color: definedColors.selectedTextColor)),),
                ),
              )
            ],

          ),
        )

    );
  }

}