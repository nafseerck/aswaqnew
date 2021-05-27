import 'dart:convert';
import 'dart:io';

import 'package:Alaswaq/common/drawer.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/dashboard.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/payment/shopping_cart.dart';
import 'package:Alaswaq/account/register/register.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ThankYouPage extends StatefulWidget {
//  var orderID;
 String orderID;
  ThankYouPage( {this.orderID});

  @override
  _ThankYouPageState createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  var invoiceId = "";

//  String orderID;

  @override
  void initState() {
//  orderID = widget.orderID.toString();
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getInvoiceId();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
//      backgroundColor: Colors.white,
//      resizeToAvoidBottomPadding: true,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        // hides leading widget
//        flexibleSpace: Container(),
//        leading: GestureDetector(
//          onTap: () {
//            Navigator.pop(context);
//          },
//          child: Icon(
//            Icons.keyboard_backspace,
//            size: 40,
//            color: Colors.black,
//          ),
//        ),
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
          width: 100,
        ),
//        actions: [
//          GestureDetector(
//            onTap: () {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => ShoppingCart()));
//            },
////                    child: Image.asset(
////                      'assets/images/icons/cart.png',
////                      height: 35,
//////          height:10,
//////          width: 100,
////                    ),
//            child: new Stack(
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(10.0),
//                  child: Image.asset(
//                    'assets/images/icons/cart.png',
//                  ),
//                ),
//                HomePage.cartCount == 0
//                    ? new Container()
//                    : new Stack(
//                  children: <Widget>[
//                    new Icon(Icons.brightness_1,
//                        size: 22.0, color: Colors.redAccent),
//                    new Positioned(
//                      top: 3.0,
//                      right: 7.0,
//                      child: new Center(
//                        child: new Text(
//                          HomePage.cartCount.toString(),
//                          style: new TextStyle( fontFamily: 'montserrat', 
//                              color: Colors.black,
//                              fontSize: 12.0,
//                              fontWeight: FontWeight.w500),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ],
//            ),
//          ),
//        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(),
            verticalSpace(),
            verticalSpace(),
            Center(
              child: Image.asset(
                'assets/images/icons/checkbox.png',
                height: 100,
//          width: 100,
              ),
            ),
            verticalSpace(),
            verticalSpace(),
            Text(
              'THANK YOU',
              style: TextStyle( fontFamily: 'montserrat', 
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'For Your Purchase!',
              style: TextStyle( fontFamily: 'montserrat', 
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            verticalSpace(),
            verticalSpace(),
            Text(
              'Your order is: ' + widget.orderID,
              style: TextStyle( fontFamily: 'montserrat', 
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
                child: Text(
              'We\'ll email you an order confirmation with details and tracking info',
              style: TextStyle( fontFamily: 'montserrat', 
                color: Colors.grey,
              ),
            )),
            verticalSpace(),
            verticalSpace(),
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                  color: HexColor("302d98"),
                  borderRadius: BorderRadius.circular(5)),
              child: FlatButton(
                onPressed: () async{
                  await goHome();
                },
                child: Text(
                  'CONTINUE SHOPPING',
                  style: TextStyle( fontFamily: 'montserrat', 
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),

            verticalSpace(),
//            Container(
//              height: 55,
//              width: MediaQuery.of(context).size.width * .9,
//              decoration: BoxDecoration(
//                  color: HexColor("302c98"),
//                  borderRadius: BorderRadius.circular(5)),
//              child: FlatButton(
//                onPressed: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAnAccount()));
//                },
//                child: Text(
//                  'CREATE AN ACCOUNT',
//                  style: TextStyle( fontFamily: 'montserrat', 
//                      color: Colors.white,
//                      fontWeight: FontWeight.bold,
//                      fontSize: 15),
//                ),
//              ),
//            ),
            verticalSpace(),
            verticalSpace(),
            verticalSpace(),
            verticalSpace(),
          ],
        ),
      ),
    );
  }

  Future getInvoiceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('adminKey');
    print("admin key is");
    print(token);
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;

    Map data = {
      "capture": true,
      "notify": true
    };

    String orderId = widget.orderID.replaceFirst(RegExp('"'), '');
    orderId = orderId.replaceFirst(RegExp('"'), '');
    //encode Map to JSON

    var body = json.encode(data);
    var response = await http.post(Uri.parse(baseUrl + 'rest/V1/order/$orderId/invoice'),
        headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText},
        body: body
    );


    print("invoice response");
    print(response.body);

    String invoc1 = response.body.replaceFirst(RegExp('"'), '');
    String invoic2 = invoc1.replaceFirst(RegExp('"'), '');
    setState(() {
      invoiceId = invoic2;
    });
    return response;

//
//    setState(() {
//      invoiceId = response.body;
//    });
//    return response;
  }

  Future goHome() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getKeys();
    for(String key in preferences.getKeys()) {
      if(key == "guestKey" ) {
        preferences.remove(key);
      }
    }
    setState(()  {
      HomePage.cartCount = 0;
      HomePage.isGuestManagement = false ;

    });
    String token = preferences.getString('guestKey');
    print("guestKey key is after removal");
    print(token);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()));

    return ;
  }
}
