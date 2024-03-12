import 'dart:ui';

import 'package:flutter/material.dart';

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
      home: MyHomePage(),
    );
  }
}

class AppBarButtonState{
    String currentState = "Music";

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
  String currentstate = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0,0,0,1),
          title: Row(
              children: <Widget>[
                SizedBox(

                    child: ElevatedButton(
                        child: Text('All',style: TextStyle(color: (currentstate == "All") ? selectedTextColor : textColor,),),

                        onPressed: (){
                          setState(() {
                            currentstate = "All";

                          });

                        },

                        style:ElevatedButton.styleFrom(
                          backgroundColor: (currentstate == "All") ? selectedColor : buttonColor,
                        ),
                    )
                ),
                SizedBox(

                    child: ElevatedButton(
                        child: Text('Music',style: TextStyle(color: (currentstate == "Music") ? selectedTextColor : textColor,),),
                        onPressed: (){
                          setState(() {
                            currentstate = "Music";

                          });

                        },

                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor: (currentstate == "Music") ? selectedColor : buttonColor,
                        ),
                    )
                ),
                SizedBox(

                    child: ElevatedButton(
                        child: Text('Podcasts',style: TextStyle(color: (currentstate == "Podcasts") ? selectedTextColor : textColor,),),
                        onPressed: (){

                          setState(() {
                            currentstate = "Podcasts";

                          });

                        },

                        style:  ElevatedButton.styleFrom(
                          backgroundColor: (currentstate == "Podcasts") ? selectedColor : buttonColor,
                        ),
                    )
                ),

              ]
    ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black,

      ),
    );

  }

}