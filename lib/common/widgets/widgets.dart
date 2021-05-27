import 'package:flutter/material.dart';

 // final String baseUrl = 'http://alaswaq1.bgm.me/';
 final String baseUrl = 'http://www.aswaqrak.ae/';
Widget listviewHeader({String leftTitle, rightTitle, Function onTap}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        leftTitle,
        style:  TextStyle( fontFamily: 'montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black87),

      ),
      GestureDetector(
        onTap: onTap,
        child: Text(
          rightTitle,
          style: TextStyle( fontFamily: 'montserrat', color: Colors.deepOrangeAccent,fontSize: 12),
        ),
      ),
    ],
  );
}
Widget menuBottomHeader({String leftTitle, rightTitle, Function onTap}){
  return   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [

      Text(
        leftTitle,
        style: TextStyle( fontFamily: 'montserrat',

            fontSize: 12,
            color: Colors.black45),

      ),
      GestureDetector(
        onTap: onTap,
        child: Text(
          rightTitle,
          style: TextStyle( fontFamily: 'montserrat',

              fontSize: 12,
              color: Colors.black45),
        ),
      ),
    ],
  );
}

