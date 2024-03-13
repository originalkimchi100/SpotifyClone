import 'package:flutter/material.dart';


const buttonColor = Color.fromRGBO(42,42,42,1);
const textColor = Colors.white;
const selectedColor = Colors.green;
const selectedTextColor = Colors.black;


Row HomeCardRow(/*String img, String txt*/) {
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
                 image: NetworkImage('https://blog.kakaocdn.net/dn/V7HOT/btqDPKTX6PN/MtUvJOC92CMZKOj1LQrpg1/img.gif'),
               ),
                Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
                Text("VULTURES 1", style:  TextStyle(color: textColor, fontFamily: "GothamBold",),)
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
                  image: NetworkImage('https://blog.kakaocdn.net/dn/V7HOT/btqDPKTX6PN/MtUvJOC92CMZKOj1LQrpg1/img.gif'),
                ),
                Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
                Text("VULTURES 1", style:  TextStyle(color: textColor, fontFamily: "GothamBold",),)
              ],


            ),
              shape: ContinuousRectangleBorder(),
              color: buttonColor,
            ),
          ),
        ),
      ]
  );
}
