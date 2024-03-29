import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homePageScreen.dart';


class signUpCase extends StatefulWidget {
  @override
  _signUpCase createState() => _signUpCase();
}
class _signUpCase extends State<signUpCase>{
  var definedColors = DefinedColors();

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  bool _weakPassword = false;
  void _weakPasswordWarning() {
    setState(() {
      _weakPassword = true;
    });
  }
  bool _emailExists = false;
  void _emailExistsWarning() {
    setState(() {
      _emailExists = true;
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    final idController = TextEditingController();
    final passwordController = TextEditingController();
    final nicknameController = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
          title: Text("Sign Up", style: TextStyle(color: definedColors.textColor,fontSize: 20,fontWeight:FontWeight.bold),),
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

              Row(children: [SizedBox(width: 10,),Text("Email",style: TextStyle(color: definedColors.textColor, fontSize: 30,fontWeight: FontWeight.bold),),]),
              Row(children: [
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
                ],),
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
              Row(children: [SizedBox(width: 10,),Text("What's your name?",style: TextStyle(color: definedColors.textColor, fontSize: 30,fontWeight: FontWeight.bold),),]),
              Row(children: [
                SizedBox(width: 10,height: 20,),
                Container(
                  width: 320,
                  child: TextField(
                    controller: nicknameController,
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

              ],),
              Visibility(child: Text("The password provided is too weak.", style: TextStyle(color: Colors.red),), visible: _weakPassword,),
              Visibility(child: Text("The account already exists for that email", style: TextStyle(color: Colors.red),), visible: _emailExists,),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: ElevatedButton(onPressed: () async{


                    try {
                      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: idController.text,password: passwordController.text,);


                      await result.user?.updateDisplayName(nicknameController.text);
                      await result.user?.reload();
                      print(await result.user);


                      User? latestUser = FirebaseAuth.instance.currentUser;
                      print('${latestUser?.displayName}');
                      await Navigator.push(buildContext, MaterialPageRoute(builder: (context) =>  MyHomePage(currentuser:latestUser)));
                      print(result.user);

                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                        _weakPasswordWarning();
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        _emailExistsWarning();
                      }
                    } catch (e) {
                      print(e);
                    }

                  },
                    child: Text("Create!", style: TextStyle(color: definedColors.selectedTextColor)),),
                ),
              )
            ],

          ),
        )

    );
  }

}