import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/orders/current_order.dart';
import 'package:Alaswaq/orders/previous_order.dart';
import 'package:Alaswaq/payment/shopping_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:gulfwestcompany/previous_order.dart';
//import 'package:gulfwestcompany/theme/colors.dart';
//
//import 'cart.dart';
//import 'current_order.dart';
//import 'main_home.dart';

class OrdersList extends StatefulWidget {
  String fromPage = "" ;
  OrdersList( this.fromPage);
  OrdersListState createState()=> OrdersListState();
}

class OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                text: "Current Order",
              ),
              Tab(
                text: "Previous Order",
              ),
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,

          automaticallyImplyLeading: false,
          leading: widget.fromPage == "from Home" ?  IconButton(
              icon:  Icon(Icons.keyboard_backspace, color: Colors.black, size: 40,),
              onPressed: () {

                Navigator.of(context).pop();
              }



          ) : Container(),




          // hides leading widget
//        flexibleSpace: Container(),
//          leading: GestureDetector(
//            onTap: () {
//              Navigator.pop(context);
//            },
//            child: Icon(
//              Icons.keyboard_backspace,
//              size: 40,
//              color: Colors.black,
//            ),
//          ),
////            title: Image.asset(
//              'assets/images/logo.png',
//              height: 40,
//              width: 100,
//            ),

          title: new Center(
            child: new Text("My Order",
                style: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 18)),
          ),

          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShoppingCart()));
              },
//                    child: Image.asset(
//                      'assets/images/icons/cart.png',
//                      height: 35,
////          height:10,
////          width: 100,
//                    ),
              child: new Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/icons/cart.png',
                    ),
                  ),
                  HomePage.cartCount == 0
                      ? new Container()
                      : new Stack(
                    children: <Widget>[
                      new Icon(Icons.brightness_1,
                          size: 22.0, color: Colors.redAccent),
                      new Positioned(
                        top: 3.0,
                        right: 7.0,
                        child: new Center(
                          child: new Text(
                            HomePage.cartCount.toString(),
                            style: new TextStyle( fontFamily: 'montserrat',
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
//          appBar: AppBar(
//            bottom: TabBar(
////              indicatorColor: HexColor("649FC3"),
////              labelColor: HexColor("649FC3"),
//              unselectedLabelColor: Colors.grey,
//              tabs: [
//
//                Tab(text: "Current Order",),
//                Tab(text: "Previous Order",),
//              ],
//            ),
////            iconTheme: new IconThemeData(color: HexColor("2E275D")),
//            actions: <Widget>[
//
//              IconButton(
//                icon: Image.asset('assets/images/search.png', height: 25.0,),
//
//                onPressed: () {},
//              ),
//              IconButton(
//                icon: Image.asset('assets/images/cart.png', height: 25.0,),
//
//                onPressed: () async {
////                  Navigator.push(
////                    context,
////                    MaterialPageRoute(builder: (context) => CartList()),
////                  );
////
//
//
//                },
//              )
//            ],
//            backgroundColor: Colors.white,
//            title: new Center(child: new Text("My Order", style: TextStyle( fontFamily: 'montserrat', 
//                color: Colors.black
//            )),
//
//            ),
//
//          ),
        body: TabBarView(
          children: [
            CurrentOrder(),
            PreviousOrder(),
          ],
        ),
      ),
    );
  }
}
