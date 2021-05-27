import 'package:Alaswaq/account/profile/my_account.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/account/login/login_page.dart';
import 'package:Alaswaq/main.dart';
import 'package:Alaswaq/orders/orders.dart';
import 'package:Alaswaq/others/Notifications.dart';
import 'package:Alaswaq/product/Categories/categories.dart';
import 'package:Alaswaq/product/Categories/categoriesList.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Alaswaq/product/search/search_home_cat_buttons.dart';
import 'package:Alaswaq/payment/shopping_cart.dart';
import 'package:Alaswaq/common/drawer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  var isLogin = false;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    (pageIndex == 4)
        ?

        //   Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()))
        _key.currentState.openDrawer()
        //print('tapped menu')
        : pageController.animateToPage(
            pageIndex,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOutSine,
          );
  }

  MenuPager() {}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        key: _key,
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                content: new Text("Do you want to exit the app"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("No"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      return false;
                    },
                  ),
                  new FlatButton(
                    child: new Text("Yes"),
                    onPressed: () {
                      SystemNavigator.pop();
                      return false;
                    },
                  ),
                ],
              );
            },
          );

          return false;
        },
        child: Scaffold(
          key: _key,
          drawer: AppDrawer(),
          backgroundColor: Colors.white,
          body: PageView(
            children: <Widget>[
              HomePage(),
              CategoryPage(),
              (HomePageState.isLogin) ? MyAccount("from Bottom") : LogInPage(7),
              (HomePageState.isLogin)
                  ? OrdersList("from Bottom")
                  : LogInPage(6),
              MenuPager(),
//              RaisedButton(
//                  child: Text('There is no notifications',
//                  style : TextStyle( fontFamily: 'montserrat', fontSize: 16,color:  Colors.black)), onPressed: null),
            ],
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: onPageChanged,
          ),
          bottomNavigationBar: Container(
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.75))
              ], color: Colors.white),
//    alignment: Alignment.center,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0, right: 0),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: pageIndex,
                  unselectedItemColor: Colors.green,
                  selectedItemColor: Colors.yellow,
                  onTap: onTap,
                  items: [
                    BottomNavigationBarItem(
                      icon: Container(
                          child: Image.asset(
                        'assets/images/icons/home.png',
                        height: 15.0,
                        color: (pageIndex == 0)
                            ? HexColor("302c98")
                            : Colors.black,
                      )),
                      title: Text('Home',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 12,
                              color: (pageIndex == 0)
                                  ? HexColor("302c98")
                                  : Colors.black)),
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                          child: Image.asset(
                        'assets/images/icons/category-icon1.png',
                        height: 15.0,
                        color: (pageIndex == 1)
                            ? HexColor("302c98")
                            : Colors.black,
                      )),
                      title: Text('Categories',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 12,
                              color: (pageIndex == 1)
                                  ? HexColor("302c98")
                                  : Colors.black)),
                    ),
                    BottomNavigationBarItem(
                        icon: Container(
                            child: Image.asset(
                          'assets/images/icons/profile.png',
                          height: 15.0,
                          color: (pageIndex == 2)
                              ? HexColor("302c98")
                              : Colors.black,
                        )),
                        title: Text('Profile',
                            style: TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 12,
                                color: (pageIndex == 2)
                                    ? HexColor("302c98")
                                    : Colors.black))),
                    BottomNavigationBarItem(
                      icon: Container(
                          child: Image.asset(
                        'assets/images/icons/orders.png',
                        height: 15.0,
                        color: (pageIndex == 3)
                            ? HexColor("302c98")
                            : Colors.black,
                      )),
                      title: Text('Orders',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 12,
                              color: (pageIndex == 3)
                                  ? HexColor("302c98")
                                  : Colors.black)),
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        child: InkWell(
                            onTap: () {
                              _key.currentState.openDrawer();
                            },
                            child: Image.asset(
                              'assets/images/icons/drawerblack.png',
                              height: 15.0,
                              color: (pageIndex == 2)
                                  ? HexColor("302c98")
                                  : Colors.black,
                            )),
                      ),
                      title: Text('Menu',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 12,
                              color: (pageIndex == 0)
                                  ? HexColor("302c98")
                                  : Colors.black)),
                    ),
                  ],
                ),
              )),
        ));
  }
}
