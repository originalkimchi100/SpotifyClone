import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Card.dart' as HomeButtonCard;

void main() {
  runApp(MyApp());
}

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
        backgroundColor: Color.fromRGBO(0,0,0,1),
          title: Row(

              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(4.0),

                  child: SizedBox(
                      child: ElevatedButton(
                          child: Text('All',style: TextStyle(color: (currentButtonState.getCurrentState() == "All") ? selectedTextColor : textColor,),),

                          onPressed: (){
                            setState(() {
                              currentButtonState.setCurrentStateToAll();
                            });
                          },
                          style:ElevatedButton.styleFrom(
                            backgroundColor: (currentButtonState.getCurrentState()  == "All") ? selectedColor : buttonColor,
                          ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(

                      child: ElevatedButton(
                          child: Text('Music',style: TextStyle(color: (currentButtonState.getCurrentState() == "Music") ? selectedTextColor : textColor,),),
                          onPressed: (){
                            setState(() {
                              currentButtonState.setCurrentStateToMusic();
                            });
                          },
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor: (currentButtonState.getCurrentState() == "Music") ? selectedColor : buttonColor,
                          ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(

                      child: ElevatedButton(
                          child: Text('Podcasts',style: TextStyle(color: (currentButtonState.getCurrentState() == "Podcasts") ? selectedTextColor : textColor,),),
                          onPressed: (){

                            setState(() {
                              currentButtonState.setCurrentStateToPodcasts();
                            });

                          },

                          style:  ElevatedButton.styleFrom(
                            backgroundColor: (currentButtonState.getCurrentState() == "Podcasts") ? selectedColor : buttonColor,
                          ),
                      )
                  ),
                ),
              ]
    ),
      ),
      body: Container(

        color: Colors.black,
        child:
          Column(
            children: [
              HomeButtonCard.HomeCardRow(),
              HomeButtonCard.HomeCardRow(),
              HomeButtonCard.HomeCardRow(),
              HomeButtonCard.HomeCardRow()
            ],

          )
      ),

    );

  }

}

