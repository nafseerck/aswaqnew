import 'dart:async';
import 'dart:io';
import 'package:Alaswaq/home/dashboard.dart';
import 'package:Alaswaq/account/login/login_page.dart';
import 'package:Alaswaq/splash/data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage1 extends StatefulWidget {
  @override
  _OnBoardingPage1State createState() => _OnBoardingPage1State();
}

class _OnBoardingPage1State extends State<OnBoardingPage1> {
  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 8.0,
      width: isCurrentPage ? 10.0 : 8.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (slideIndex < 3) {
        slideIndex++;
      } else {
        slideIndex = 0;
      }

      controller.animateToPage(
        slideIndex,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF302C98),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              slideIndex = index;
            });
          },
          children: <Widget>[
            SlideTile(
              imagePath: mySLides[0].getImageAssetPath(),
              title: mySLides[0].getTitle(),
              desc: mySLides[0].getDesc(),
            ),
            SlideTile(
              imagePath: mySLides[1].getImageAssetPath(),
              title: mySLides[1].getTitle(),
              desc: mySLides[1].getDesc(),
            ),
            SlideTile(
              imagePath: mySLides[2].getImageAssetPath(),
              title: mySLides[2].getTitle(),
              desc: mySLides[2].getDesc(),
            ),
            SlideTile(
              imagePath: mySLides[3].getImageAssetPath(),
              title: mySLides[3].getTitle(),
              desc: mySLides[3].getDesc(),
            )
          ],
        ),
      ),
      bottomNavigationBar: slideIndex != 3
          ? Container(
        height: 100,
        color: Color(0xFF302C98),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++)
                    i == slideIndex
                        ? _buildPageIndicator(true)
                        : _buildPageIndicator(false),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 40,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),

              ),
              child: FlatButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));
              }, child: Text('Skip',style: TextStyle( fontFamily: 'montserrat', color:Colors.white),)),
            ),
          ],
        ),
      )
          : InkWell(
        onTap: () {
          print("Get Started Now");
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));
        },
        child: Container(
          height: Platform.isIOS ? 70 : 60,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            "GET STARTED NOW",
            style: TextStyle( fontFamily: 'montserrat', 
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height*.7,
          child: Image.asset(imagePath,fit: BoxFit.cover,),),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle( fontFamily: 'montserrat', fontWeight: FontWeight.w500, fontSize: 20,color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Text(desc,
            textAlign: TextAlign.center,
            style: TextStyle( fontFamily: 'montserrat',  fontSize: 15,color: Colors.white)),
      ],
    );
  }
}
