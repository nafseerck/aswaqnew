import 'dart:async';

import 'package:Alaswaq/home/dashboard.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/splash/onbording_page1.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
//  @override
//  void initState() {
//    // TODO: implement initState
//
//    Timer(Duration(seconds: 5),()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>OnBoardingPage1())));
//    super.initState();
//  }

  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 10);
    return Timer(duration, navigateAfter);
  }

//  startTimer() async {
//    var duration = Duration(seconds: 5);
//    return Timer(duration, navigatAfter);
//  }

  navigateAfter() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setBool("isFirstTime", false);
//    final status = prefs.getBool("isFirstTime");
//    if (status==true) {
//        SharedPreferences prefs = await  SharedPreferences.getInstance();
//        prefs.getBool("isFirstTime");
//      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoardingPage1()));
//    } else {
//      Navigator.push(
//          context, MaterialPageRoute(builder: (context) => HomePage()));
//    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Dashboard()));
  }

//  navigatAfter() {
//    if(isFirstTime())
//    {
//      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Take_Tour()));
//    }
//    else
//    {
//      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//    }
//  }

//  bool isFirstTime() {
//    //  return false;
//    return true;
//  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: HexColor("302d98"),
          ),
          child: Center(
              child: Column(
//            mainAxisAlignment: ,
            children: [
//              SizedBox(
//                height: 200,
//                width: 200,
//                child: Image.asset("assets/images/logoBlue.png",),
//              ),
//              Align(
//                alignment: Alignment.bottomCenter,
//                child: Text("Bottom text"),
//              )
              Expanded(
                child: Center(
                  child: Image.asset("assets/images/logoBlue.png",
                      width: 210, height: 113, fit: BoxFit.fill),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Text(
                        "\"We are always near you.\"",
                        style: TextStyle(
                            fontFamily: 'montserrat',
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "www.aswaqrak.ae",
                        style: TextStyle(
                          fontFamily: 'montserrat',
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ))
            ],
          )),
        ),
      ),
    );
  }
}
