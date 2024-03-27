import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';



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

