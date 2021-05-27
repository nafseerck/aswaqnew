
import 'package:Alaswaq/common/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,

            drawer: AppDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              automaticallyImplyLeading: true,
              // hides leading widget
//        flexibleSpace: Container(),
//        leading: GestureDetector(
//          onTap: () {
//            Navigator.pop(context);
//          },
//          child: Icon(
//            Icons.keyboard_backspace,
//            color: Colors.black87,
//            size: 30,
//          ),
//        ),
              title: Text(
                'Notifications',
                style: TextStyle( fontFamily: 'montserrat',
                    color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              actions: [

              ],
            ),
            body: SafeArea(
                child: Center(
                    child: (  Text('There is no notifications',
                        style : TextStyle( fontFamily: 'montserrat', fontSize: 16,color:  Colors.black))  )
                )
            )
        )
    );
  }
}
