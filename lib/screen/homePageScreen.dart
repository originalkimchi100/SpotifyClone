import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Card.dart' as HomeButtonCard;
import '../AppBarButtonState.dart';
import 'package:test_drive/ScrapData.dart';
import 'NotLoginedScreen.dart';


class MyHomePage extends StatefulWidget {
  final User? currentuser;
  const MyHomePage ({ Key? key, required this.currentuser}): super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  var definedColors = DefinedColors();
  var appBarButtonState = AppBarButtonState();

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
                              child: Text("Fetching the data", style: TextStyle(color: definedColors.textColor),textAlign: TextAlign.center,),
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
                          Text("Current Billboard Hot 100™",style: TextStyle(color: definedColors.textColor,fontSize: 20,fontFamily: "GothamBold"),),


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
          child: Text("Musics!", style: TextStyle(color: definedColors.textColor),textAlign: TextAlign.center,),
        );
      case 'Podcasts':
        return  Container(
          width: double.infinity,
          height: double.infinity,
          child: Text("Podcasts!", style: TextStyle(color: definedColors.textColor),textAlign: TextAlign.center,),
        );
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
                            backgroundColor: definedColors.selectedColor,
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
                          color: (appBarButtonState.getCurrentState() == "All") ? definedColors.selectedTextColor : definedColors.textColor,fontSize: 12),),
                      onPressed: () {
                        setState(() {
                          appBarButtonState.setCurrentStateToAll();
                          _activeWidget = 'All';
                        });
                      },
                      style: ElevatedButton.styleFrom(

                        backgroundColor: (appBarButtonState
                            .getCurrentState() == "All")
                            ? definedColors.selectedColor
                            : definedColors.buttonColor,
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
                                "Music") ? definedColors.selectedTextColor : definedColors.textColor,fontSize: 12),),
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
                              ? definedColors.selectedColor
                              : definedColors.buttonColor,
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
                        child: Text('Podcasts', style: TextStyle(color: (appBarButtonState.getCurrentState() == "Podcasts") ? definedColors.selectedTextColor : definedColors.textColor,fontSize: 12),),
                        onPressed: () {
                          setState(() {
                            appBarButtonState.setCurrentStateToPodcasts();
                            _activeWidget = 'Podcasts';

                          });
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: (appBarButtonState
                              .getCurrentState() == "Podcasts")
                              ? definedColors.selectedColor
                              : definedColors.buttonColor,
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
                            backgroundColor: definedColors.selectedColor,
                            child: Icon(Icons.person, size: 25),
                          ),
                          SizedBox(width:20), // padding 위한 sizedbox
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Container(child: Text(widget.currentuser!.displayName.toString(), style: TextStyle(color: definedColors.textColor),)),Container(child: Text('View profile', style: TextStyle(color: definedColors.textColor, fontSize: 10),))]),
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
                      child: Icon(Icons.bolt,size: 30,color: definedColors.textColor,),
                    ),Text(r"What's new",style: TextStyle(color: definedColors.textColor),)]),
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: Container(
                    child: Row(children: [Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.history_rounded,size: 30,color: definedColors.textColor,),
                    ),Text('Listening history',style: TextStyle(color: definedColors.textColor),)]),
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: Container(
                    child: Row(children: [Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.settings_rounded,size: 30,color: definedColors.textColor,),
                    ),Text('Settings and Privacy',style: TextStyle(color: definedColors.textColor),)]),
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: Container(
                    child: TextButton(
                      child: Text("Log out", style: TextStyle(color: definedColors.textColor),),
                      onPressed: () async{
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NotLoginedScreen()));


                      },


                    ),
                  ),
                ),

              ],
            ),
          )

      ),
    );
  }
}



