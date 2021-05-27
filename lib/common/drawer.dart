import 'package:Alaswaq/account/profile/my_account.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/dashboard.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/account/login/login_page.dart';
import 'package:Alaswaq/orders/orders.dart';
import 'package:Alaswaq/others/Notifications.dart';
import 'package:Alaswaq/others/about_alaswaq.dart';
import 'package:Alaswaq/others/contact_us.dart';
import 'package:Alaswaq/others/delivery_imnformation.dart';
import 'package:Alaswaq/others/faq.dart';
import 'package:Alaswaq/others/notification2.dart';
import 'package:Alaswaq/others/privacy_policy.dart';
import 'package:Alaswaq/others/return_policy.dart';
import 'package:Alaswaq/others/store_locations.dart';
import 'package:Alaswaq/others/others.dart';
import 'package:Alaswaq/others/terms_conditions.dart';
import 'package:Alaswaq/product/search/search_home_cat_buttons.dart';
import 'package:Alaswaq/product/search/show_search_product_page.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class AppDrawer extends StatefulWidget {
  @override
  AppDrawerState createState() => new AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
//  String memberName="",memberUniqeId="",gender="";
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//  Future getdata() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    memberName = prefs.getString("name");
//    memberUniqeId = prefs.getString("memberUniqeId");
//    gender = prefs.getString("gender");
//
//    if (memberName == null) {
//      memberName = "";
//    }
//    if (memberUniqeId == null) {
//      memberUniqeId = "";
//    }a
//    if (gender == null) {
//      gender = "";
//    }
//  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          new Container(
            width: screenSize.width,
            height: 200,
            decoration: new BoxDecoration(
              color: Color(0xFF2F3590),
            ),
            child: new Column(
              children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Container(
//                              width: screenSize.width,
//                              child: Image.asset(
//                                'images/drawer_header_title.png',
//                                fit: BoxFit.contain,
//                                width: 150,
//                                height: 100,
//                              )
//                          ),
//                        ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 20, bottom: 10),
                  child: Container(
                    width: screenSize.width,
//                            child: new Text(
//                              'Mamun',
//                              softWrap: true,
//                              overflow: TextOverflow.clip,
//                              textAlign: TextAlign.left,
//                              style: TextStyle( fontFamily: 'montserrat',
//                                  fontSize: 30,color: Colors.white
//                              ),
//                            ),
                    child: GestureDetector(
                      onTap: () {
//                        Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) => (HomePageState.isLogin ) ? MyAccount() : LogInPage(toPageId: 2,),));
                      },
                      child: HomePageState.isLogin
                          ? Text(
                              HomePageState.userName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'montserrat',
                                  fontSize: 30,
                                  color: Colors.white),
                            )
                          : Text(
                              'Guest User',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'montserrat',
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: new Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            /*    new Image.asset(
                                        'images/king.png'),*/
//                                    Image.asset('images/king_header.png'),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyAccount("From Home")));
                              },
                              child: new Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: new Text(
                                  "View Profile",
                                  style: TextStyle(
                                      fontFamily: 'montserrat',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            // new Image.asset('images/crousal_right_icon.png'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            color: Color(0xFD0CECE),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                //border: Border.all(width: 0.5, color: HexColor("302c98")),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: new Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          title: Text(
                            'My Account',
                            style: new TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 14.0,
                            ),
                          ),
                          onTap: () {
                            {
                              if (HomePageState.isLogin) {
                                print("in logged... draw..");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyAccount("From Home")));
                              } else {
                                print("in guest.....");

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogInPage(2)));
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        ),
                    child: Divider(
                      height: 2,
                      thickness: 1,
                      indent: 25,
                      endIndent: 25,
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                            title: Text(
                              'Contact Us',
                              style: new TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 14.0,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactUs()));
                            }),
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        ),
                    child: Divider(
                      height: 2,
                      thickness: 1,
                      indent: 25,
                      endIndent: 25,
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                            title: Text(
                              'Store Locations',
                              style: new TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 14.0,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoreLocations()));
                            }),
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        ),
                    child: Divider(
                      height: 2,
                      thickness: 1,
                      indent: 25,
                      endIndent: 25,
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                            title: Text(
                              'Others',
                              style: new TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 14.0,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Others()));
                            }),
                      ),
                    ),
                  ),

                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //   ),
                  //   child: Divider(
                  //     height: 2,
                  //     thickness: 1,
                  //     indent: 25,
                  //     endIndent: 25,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            color: Color(0xFD0CECE),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                //border: Border.all(width: 0.5, color: HexColor("302c98")),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListTile(
                      title: HomePageState.isLogin
                          ? Text(
                              'Logout',
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                fontFamily: 'montserrat',
                              ),
                            )
                          : Text(
                              'Login',
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                fontFamily: 'montserrat',
                              ),
                            ),
                      onTap: () async {
                        if (HomePageState.isLogin) {
                          _showDialog();
                          print("inside logoutt");
                          setState(() {
                            HomePageState.isLogin = false;
                            HomePage.cartCount = 0;
                          });

                          print("inside logoutt");
                        } else {
                          print("in guest..... log");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInPage(
                                        1,
                                      )));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                padding: const EdgeInsets.only(top: 20.0),
                onPressed: () async {},
                child: Text('version 2.0.0',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                        fontFamily: 'montserrat')),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 20,
              child: FlatButton(
                padding: const EdgeInsets.only(top: 0.0),
                onPressed: () async {},
                child: Text('@2021 Al Aswaq. All Rights Reserved.',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                        fontFamily: 'montserrat')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

/*    _connectionSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          setState(() {
            _connectionStatus = result.toString();
          });
        });
    print("Initstate : $_connectionStatus");*/
  }

  @override
  void dispose() {
    //_connectionSubscription.cancel();
    super.dispose();
  }

/*  Future<Null> initConnectivity() async {
    String connectionStatus;
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = "Internet connectivity failed";
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _connectionStatus = connectionStatus;
    });
    print("InitConnectivity : $_connectionStatus");
    if ((_connectionStatus == "ConnectivityResult.mobile" ||
        _connectionStatus == "ConnectivityResult.wifi")) {
    } else {
      _showDialog("Connection Error !", "Please enable internet connection");
    }
  }*/

//  _postData() async {
//    //showDialog(context: context, child: progress);
//    http.post(LOGOUT_URL+"52D00E44-FD7F-4CCA-B287-802B2A067E96", body: {}).then((response) async{
//      print("Response body: ${response.body}");
//      var statusResult = json.decode(response.body);
//      bool message = statusResult['isSuccess'];
//      if(message == true)
//      {
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//        prefs.remove('memberId');
//        prefs.remove('memberUniqeId');
//        prefs.remove('name');
//        prefs.remove('phoneNumber');
//        prefs.remove('userName');
//        prefs.remove('email');
//        prefs.remove('picture');
//        prefs.remove('gender');
//        prefs.clear();
//        //Navigator.pop(context);
//        Navigator.pop(context);
//        Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new LoginPageLatest()));
//        //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginPageLatest()));
//      }
//      else{
//        _showDialog("Failed", "Something went wrong");
//      }
//
//    });
//  }
//  var progress = new ProgressHUD(
//    backgroundColor: Colors.black54,
//    color: Colors.white,
//    containerColor: Colors.transparent,
//    borderRadius: 10.0,
//    text: "Loading....",
//  );
//
//  void _showDialog(String title, String msg) {
//    final screenSize = MediaQuery.of(context).size;
//    showDialog(
//      context: context,
//      barrierDismissible: false,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          //title: new Text(title),
//          content: new Text(msg),
//          actions: <Widget>[
//            SizedBox(width: screenSize.width / 50),
//            new Container(
//              width: screenSize.width / 2.80,
//              child: new RaisedButton(
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//                child: new Text("Back"),
//                textColor: Colors.white,
//                //color: Colors.purple,
//              ),
//            ),
//          ],
//        );
//      },
//    );
//  }
  void logoutUser() {
    setState(() async {
      print("inside logout");

      HomePageState.isLogin = false;
      HomePage.cartCount = 0;
      final pref = await SharedPreferences.getInstance();
      await pref.clear();
//      Navigator.push(context,
//          MaterialPageRoute(builder: (context) => MyHomePage()));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("Do you want to logout"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                logoutUser();
              },
            ),
          ],
        );
      },
    );
  }
}
