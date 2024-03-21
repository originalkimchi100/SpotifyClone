import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_drive/AppBarButtonState.dart';


const buttonColor = Color.fromRGBO(42,42,42,1);
const textColor = Colors.white;
const selectedColor = Colors.green;
const selectedTextColor = Colors.black;

Row HomeCardRow(String firstSongPicture, String Title, String secondSongPicture, String secondTitle) {
  const buttonColor = Color.fromRGBO(42, 42, 42, 1);
  const textColor = Colors.white;

  return Row(
      children: [
        Expanded(
          child: Container(
            width: 170,
            child: Card
              (child: Row(
              children: [
               Image(
                 height: 50,
                 image: NetworkImage(firstSongPicture),
               ),
                //Padding(padding: EdgeInsets.fromLTRB(5, 20, 10, 20)),
                Padding(padding: EdgeInsets.fromLTRB(10, 20, 0, 20)),
                Container(
                  width:85,
                  child: AutoSizeText(Title, style:  TextStyle(color: textColor, fontFamily: "GothamBold",fontSize: 7),),


                )

              ],


            ),
              shape: ContinuousRectangleBorder(),
              color: buttonColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 170,
            child: Card
              (child: Row(
              children: [
                Image(
                  height: 50,
                  image: NetworkImage(secondSongPicture),
                ),
                Padding(padding: EdgeInsets.fromLTRB(10, 20, 0, 20)),
                Container(
                  width:85,
                  child: AutoSizeText(secondTitle, style:  TextStyle(color: textColor, fontFamily: "GothamBold",fontSize: 7),),

                )              ],


            ),
              shape: ContinuousRectangleBorder(),
              color: buttonColor,
            ),
          ),
        ),
      ]
  );
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key, required this.appBarButtonState, required this.currentState, required this.myState}) : super(key:key);
  final AppBarButtonState appBarButtonState;
  final String myState;
  final String currentState;

  @override
  State<StatefulWidget> createState()=> MyState();
}

class MyState extends State<MyWidget>{
  @override
  Widget build(BuildContext context){

    AppBarButtonState appBarButtonState = widget.appBarButtonState;
    String myState = widget.myState;


    return
      Padding(
        padding: const EdgeInsets.all(4.0),

        child: SizedBox(
            child: ElevatedButton(
              child: Text(myState, style: TextStyle(
                color: (appBarButtonState.getCurrentState() == myState)
                    ? selectedTextColor
                    : textColor,),),

              onPressed: () {
                setState(() {
                  switch (myState) {
                    case('All'):
                      appBarButtonState.setCurrentStateToAll();
                    case('Music'):
                      appBarButtonState.setCurrentStateToMusic();
                    case('Podcasts'):
                      appBarButtonState.setCurrentStateToPodcasts();
                  }

                });
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: (appBarButtonState
                    .getCurrentState() == myState)
                    ? selectedColor
                    : buttonColor,
              ),
            )
        ),
      );



  }



}