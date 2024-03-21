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



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {

      print("userid"+ user.uid);
    }
    else{
      print("asdfadsfdsaf");

    }
  });

  runApp(MyApp());
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
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _activeWidget = 'All';
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
        drawerEnableOpenDragGesture: false,
        key: _key,
        appBar: AppBar(

          automaticallyImplyLeading: false, // this will hide Drawer hamburger icon
         // actions: <Widget>[Container()],
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


          child: ListView(
          padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
              decoration: BoxDecoration(
              color: Colors.blue,
              ),
              child: Text('Drawer Header'),
      ),
              ListTile(
              title: const Text('Home'),
              onTap: () {
              // Then close the drawer
               Navigator.pop(context);},
      )]
    ),
      )
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
    //getElementsByClassName(albumclass)[i].src;
    print(subscribeCount);
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
  print(titlelist);
  return finallist;
}



