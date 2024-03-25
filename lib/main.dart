import 'dart:async';
import 'dart:ui';
import 'package:chaleno/chaleno.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Card.dart' as HomeButtonCard;
import 'everysong.dart' as BillBoardCol;
import 'AppBarButtonState.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sidebarx/sidebarx.dart';

var appBarButtonState = AppBarButtonState();

User? currentuser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      runApp(NotLoginedApp());
    } else {
      currentuser = user;
      print(currentuser);
      runApp(MyApp());
    }
  });


}


List<String> srclist  = [];
List<String> titlelist  = [];
int row = 2;
int col = 7;

List<Map> finallist  = [];


const buttonColor = Color.fromRGBO(42,42,42,1);
const textColor = Colors.white;
const selectedColor =  Color.fromRGBO(30,215,96,1);
const selectedTextColor = Colors.black;

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

      home: MyHomePage(),




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

      home: NotAuthCase(),




    );
  }
}



class NotAuthCase extends StatelessWidget {
  const NotAuthCase({super.key});


  @override
  Widget build(BuildContext buildContext){
    return Scaffold(

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
           child: Text("Discover your next favorite playlist.",style: TextStyle(fontSize: 30, color: textColor,fontFamily: 'GothamMedium',fontWeight: FontWeight.bold), textAlign: TextAlign.center,),

         )
         ),
         Expanded(child:
         Container(
           width: double.infinity,
           color: Colors.black,
           child: Column(children: [
             ElevatedButton(

               onPressed: (){
               print("hello world");


             }, child: Text("Sign up",style: TextStyle(color: selectedTextColor),),style: ElevatedButton.styleFrom(
               backgroundColor: selectedColor,
               padding: EdgeInsets.symmetric(horizontal: 125),

             ),),
             SizedBox(
               width:300,

               child: OutlinedButton(onPressed:(){
                 print("hello world");
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
                     Text("Continue with Google",style: TextStyle(color: textColor),),
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
                       Text("Continue with Facebook",style: TextStyle(color: textColor),),

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
                  Navigator.push(buildContext, MaterialPageRoute(builder: (context) => LoginCase()));

               }, child: Text("Log in",style: TextStyle(color: textColor),),
               ),



           ],),
         ),
         ),
       ],
     )
    );

  }

}
class LoginCase extends StatefulWidget {


  @override
  _LoginCase createState() => _LoginCase();
}
class _LoginCase extends State<LoginCase>{
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

            Row(children: [SizedBox(width: 10,),Text("Email or username",style: TextStyle(color: textColor, fontSize: 30,fontWeight: FontWeight.bold),),]),
            Row(
              children: [
                SizedBox(width: 10,height: 20,),
                Container(
                  width: 320,
                  child: TextField(
                    controller: idController,
                    decoration: InputDecoration(

                    filled: true,
                    fillColor: buttonColor,
                      enabledBorder: OutlineInputBorder(
                      ),
                      border: InputBorder.none

                  ), cursorColor: textColor, style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),),
                ),
              ],
            ),
            Row(children: [SizedBox(width: 10,),Text("Password",style: TextStyle(color: textColor, fontSize: 20,fontWeight: FontWeight.bold),),]),
            Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  width: 320,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: buttonColor,
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
                  ), cursorColor: textColor, style: const TextStyle(
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
                  child: Text("Log in", style: TextStyle(color: selectedTextColor)),),
              ),
            )
          ],

        ),
      )

    );
  }

}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _activeWidget = 'Music';
  Widget bodyWidget() {
    switch (_activeWidget) {
      case 'All':
        return Column(

            children: <Widget>[
              FutureBuilder(future: scrapData(), builder: (BuildContext context, AsyncSnapshot snapshot)
              {
                if (snapshot.hasData == false) {
                  return
                    Expanded(

                        child: Column(
                          children: [
                            Container(
                              color: Colors.black,

                            ),
                            Container(
                              child: Text("Fetching the data", style: TextStyle(color: textColor),textAlign: TextAlign.center,),
                            ),
                          ],
                        )
                    );

                }
                else {
                  return
                    Container(

                      color: Colors.black,
                      child:

                      Column(
                        children: [
                          Text("Current Billboard Hot 100™",style: TextStyle(color: textColor,fontSize: 20,fontFamily: "GothamBold"),),


                          HomeButtonCard.HomeCardRow(snapshot.data[0]['src'],snapshot.data[0]['title'],snapshot.data[1]['src'],snapshot.data[1]['title']),
                          HomeButtonCard.HomeCardRow(snapshot.data[2]['src'],snapshot.data[2]['title'],snapshot.data[3]['src'],snapshot.data[3]['title']),
                          HomeButtonCard.HomeCardRow(snapshot.data[4]['src'],snapshot.data[4]['title'],snapshot.data[5]['src'],snapshot.data[5]['title']),
                          HomeButtonCard.HomeCardRow(snapshot.data[6]['src'],snapshot.data[6]['title'],snapshot.data[7]['src'],snapshot.data[7]['title'])


                        ],

                      ),
                    );


                }




              }
              )
            ]
        );
      case 'Music':
        return   Container(
          width: double.infinity,
    height: double.infinity,
    child: Text("Musics!", style: TextStyle(color: textColor),textAlign: TextAlign.center,),
    );
      case 'Podcasts':
         return  Container(
          width: double.infinity,
          height: double.infinity,
          child: Text("Podcasts!", style: TextStyle(color: textColor),textAlign: TextAlign.center,),
        );
      case 'Players':
        return Row(children: [SidebarX(
    controller: SidebarXController(selectedIndex: 0),
    items: const [
    SidebarXItem(icon: Icons.home, label: 'Home'),
    SidebarXItem(icon: Icons.search, label: 'Search'),
    ],
    ),],);
      default:
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
          child: Text("The Error has occured"),
        );
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //drawerEnableOpenDragGesture: false,
        key: _key,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(0, 0, 0, 1),
          title: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                      child:SizedBox(
                        width: 40,
                        height: 40,
                        child: FittedBox(

                          child: FloatingActionButton.small(
                            shape: new CircleBorder(),
                            backgroundColor: selectedColor,
                            onPressed: () => _key.currentState!.openDrawer(),
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),

                          )

                        ),
                      )





                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),

                        child: ElevatedButton(
                          child: Text('All', style: TextStyle(
                            color: (appBarButtonState.getCurrentState() == "All") ? selectedTextColor : textColor,fontSize: 12),),
                          onPressed: () {
                            setState(() {
                              appBarButtonState.setCurrentStateToAll();
                              _activeWidget = 'All';
                            });
                          },
                          style: ElevatedButton.styleFrom(

                            backgroundColor: (appBarButtonState
                                .getCurrentState() == "All")
                                ? selectedColor
                                : buttonColor,
                            padding: EdgeInsets.only(
                              top: 9,
                              right: 15,
                              left: 15,
                              bottom: 9,
                            ),

                            minimumSize: Size.zero,

                          ),
                        )
                    ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(

                        child: ElevatedButton(
                          child: Text('Music', style: TextStyle(
                            color: (appBarButtonState.getCurrentState() ==
                                "Music") ? selectedTextColor : textColor,fontSize: 12),),
                          onPressed: () {
                            setState(() {
                              appBarButtonState.setCurrentStateToMusic();
                              _activeWidget = 'Music';

                            });
                          },
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor: (appBarButtonState
                                .getCurrentState() == "Music")
                                ? selectedColor
                                : buttonColor,
                            padding: EdgeInsets.only(
                              top: 9,
                              right: 15,
                              left: 15,
                              bottom: 9,
                            ),

                            minimumSize: Size.zero,

                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(

                        child: ElevatedButton(
                          child: Text('Podcasts', style: TextStyle(color: (appBarButtonState.getCurrentState() == "Podcasts") ? selectedTextColor : textColor,fontSize: 12),),
                          onPressed: () {
                            setState(() {
                              appBarButtonState.setCurrentStateToPodcasts();
                              _activeWidget = 'Podcasts';

                            });
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: (appBarButtonState
                                .getCurrentState() == "Podcasts")
                                ? selectedColor
                                : buttonColor,
                            padding: EdgeInsets.only(
                              top: 9,
                              right: 15,
                              left: 15,
                              bottom: 9,
                            ),

                            minimumSize: Size.zero,
                          ),
                        )
                    ),
                  ),
                ]
            ),
          ),
        ),

        body: Container(
            color:Colors.black,
            child: bodyWidget()

        ),
      drawer: Drawer(
        child:
            Container(
              color: Colors.black ,
              child: ListView(
                children: [
                  SizedBox(
                    height: 100,
                    child: DrawerHeader(
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: selectedColor,
                              child: Icon(Icons.person, size: 25),
                            ),
                            SizedBox(width:20), // padding 위한 sizedbox
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Container(child: Text(currentuser!.displayName.toString(), style: TextStyle(color: textColor),)),Container(child: Text('View profile', style: TextStyle(color: textColor, fontSize: 10),))]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,

                    child: Container(

                      child: Row(children: [Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.bolt,size: 30,color: textColor,),
                      ),Text(r"What's new",style: TextStyle(color: textColor),)]),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Container(
                      child: Row(children: [Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.history_rounded,size: 30,color: textColor,),
                      ),Text('Listening history',style: TextStyle(color: textColor),)]),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Container(
                      child: Row(children: [Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.settings_rounded,size: 30,color: textColor,),
                      ),Text('Settings and Privacy',style: TextStyle(color: textColor),)]),
                    ),
                  ),
                ],
              ),
            )

      ),
    );
  }
}







Future<List<Map>> scrapData() async {
  final albumclass = 'c-lazy-image__img lrv-u-background-color-grey-lightest lrv-u-width-100p lrv-u-display-block lrv-u-height-auto';

  final titleclass = '.lrv-u-font-size-16';

  final url = 'https://www.billboard.com/charts/hot-100/';
  var response  = await Chaleno().load(url);

  for (int i = 2; i < 17; i+= 2) { //  for (int i = 1; i < 17; i+= 2) {
    String? subscribeCount = response?.getElementsByClassName(albumclass)[i].src;
    srclist.add(subscribeCount.toString());
  }

  for (int i =3; i<11; i++){ //  for (int i =3; i<11; i++){
    String? titlecount = response?.querySelectorAll(titleclass)[i].innerHTML?.trim();
    titlelist.add(titlecount.toString());
  }
  for(int i = 0; i<8; i++){
    Map musicCover = {};
    musicCover['src'] = srclist[i];
    musicCover['title'] = titlelist[i];
    finallist.add(musicCover);
  }
  return finallist;
}



