
// ignore: must_be_immutable
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreLocations extends StatefulWidget {
  @override
  _StoreLocationsState createState() => _StoreLocationsState();
}

class _StoreLocationsState extends State<StoreLocations> {


  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  List<String>locationName = ["Al Dhait", "Al Kharan", "Al Jazeerah",  "Ghalilah","South Al Dhait", "Masafi", "Wadi Al Qor", "Al Shaghie", "Al Zahra"];
  List<String>phoneNum = ["+971 7 235 2228/9", "+971 7 244 1717", "+971 7 244 5883","+971 7 266 6801", "+971 7 235 5385", "+971 9 256 0990", "+971 4 852 4648", "+971 50 527 5868", "+971 7 226 9950"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        // hides leading widget
//        flexibleSpace: Container(),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          'Store Locations',
          style: TextStyle( fontFamily: 'montserrat',
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),

      ),
      body: ListView.builder(
//                              shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: locationName.length, itemBuilder: (context, index) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.5 ,
              height: 100.0,

              child: Padding(
                padding: EdgeInsets.all(10),
                child : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),

                    ),
                    elevation: 10,
                    clipBehavior: Clip.antiAlias,
//                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        height: 50,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width/ 1.5,
                        alignment: Alignment.center,
                        child:  Row (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(locationName[index],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'montserrat'
                              ),

                            ),
                            Text(phoneNum[index],
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'montserrat'
                              ),
                            ),


                          ],
                        ),
//
                      ),
                    )
                ),
              ),


            );
          },
        );
      },
      ),
    );
  }
}
