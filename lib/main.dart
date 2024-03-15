import 'dart:async';
import 'dart:ui';
import 'package:chaleno/chaleno.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Card.dart' as HomeButtonCard;
import 'everysong.dart' as BillBoardCol;
void main() {
  runApp(MyApp());
}
List<String> srclist  = [];
List<String> titlelist  = [];
int row = 2;
int col = 7;

List<Map> finallist  = [];


const buttonColor = Color.fromRGBO(42,42,42,1);
const textColor = Colors.white;
const selectedColor = Colors.green;
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

class AppBarButtonState{ // getter, setter를 쓰는게 맞나 하는 의문은 드네요.
    String currentState = "All";

    String getCurrentState(){
      return currentState;
    }

    void setCurrentStateToAll() {
      currentState = "All";
    }

    void setCurrentStateToMusic() {
      currentState = "Music";
    }

    void setCurrentStateToPodcasts() {
      currentState = "Podcasts";
    }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppBarButtonState currentButtonState = AppBarButtonState();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          leadingWidth: 5.0,
          backgroundColor: Color.fromRGBO(0, 0, 0, 1),
          title: Row(

              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(4.0),

                  child: SizedBox(
                      child: ElevatedButton(
                        child: Text('All', style: TextStyle(
                          color: (currentButtonState.getCurrentState() == "All")
                              ? selectedTextColor
                              : textColor,),),

                        onPressed: () {
                          setState(() {
                            currentButtonState.setCurrentStateToAll();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (currentButtonState
                              .getCurrentState() == "All")
                              ? selectedColor
                              : buttonColor,
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(

                      child: ElevatedButton(
                        child: Text('Music', style: TextStyle(
                          color: (currentButtonState.getCurrentState() ==
                              "Music") ? selectedTextColor : textColor,),),
                        onPressed: () {
                          setState(() {
                            currentButtonState.setCurrentStateToMusic();
                          });
                        },
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor: (currentButtonState
                              .getCurrentState() == "Music")
                              ? selectedColor
                              : buttonColor,
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(

                      child: ElevatedButton(
                        child: Text('Podcasts', style: TextStyle(
                          color: (currentButtonState.getCurrentState() ==
                              "Podcasts") ? selectedTextColor : textColor,),),
                        onPressed: () {
                          setState(() {
                            currentButtonState.setCurrentStateToPodcasts();
                          });
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: (currentButtonState
                              .getCurrentState() == "Podcasts")
                              ? selectedColor
                              : buttonColor,
                        ),
                      )
                  ),
                ),
              ]
          ),
        ),
        body: Container(
            color:Colors.black,
            child: Column(

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
            )
        )

    );
  }

}

Future<List<Map>> scrapData() async {
  final albumclass = 'c-lazy-image__img lrv-u-background-color-grey-lightest lrv-u-width-100p lrv-u-display-block lrv-u-height-auto';
  final titleclass = '.lrv-u-font-size-16';

  final url = 'https://www.billboard.com/charts/hot-100/';
  var response  = await Chaleno().load(url);

  for (int i = 1; i < 17; i+= 2) { //  for (int i = 1; i < 17; i+= 2) {
    String? subscribeCount = response?.getElementsByClassName(albumclass)[i].src;
    srclist.add(subscribeCount.toString());


  }

  for (int i =3; i<11; i++){ //  for (int i =3; i<11; i++){
    String? titlecount = response?.querySelectorAll(titleclass)[i].innerHTML?.trim();
    print(titlecount);
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

