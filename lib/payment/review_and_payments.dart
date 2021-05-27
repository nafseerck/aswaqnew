import 'dart:convert';
import 'dart:io';
import 'package:Alaswaq/Model/cart_list_model.dart';
import 'package:Alaswaq/Model/register_model.dart';
import 'package:Alaswaq/account/profile/address_book.dart';
import 'package:Alaswaq/account/profile/address_profile_edit.dart';
import 'package:Alaswaq/common/drawer.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/payment/thank_you.dart';
import 'package:Alaswaq/payment/shopping_cart.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

var orderID;

class ReviewAndPayments extends StatefulWidget {
//  final emailController,
//  firstNameController,
//  lastNameController,
//  addressController,
//  cityController,
//  stateController,
//  zipController,
//  countryController,
//  phoneController;
  String fromPage = "";
//  ReviewAndPayments({this.emailController,this.firstNameController,this.lastNameController,this.addressController,this.stateController,this.phoneController,this.countryController,this.zipController,this.cityController});
  ReviewAndPayments(this.fromPage);

  @override
  ReviewAndPaymentsState createState() => ReviewAndPaymentsState();
}

class ReviewAndPaymentsState extends State<ReviewAndPayments> {
  static const platform = const MethodChannel("host");
  static const platform1 = const MethodChannel("receivingFromAndroid");

  static var userName = "";
  static var phoneNum = "";
//  UserRegistration userreg_model ;
  static var isloggedIn = false;
//  List<String >street = new List<String>();
  static var street0 = "";
  static var street1 = "";
  static var city = "";
  static var postalcode = "";
  static var password = "";
  static var emailid = "";
  UserRegistration userreg_model;
  double _result = 0.0;
  int _radioValue = 0;
  int _paymentRadioValue = 0;
  var checkedValue = true;
  bool isPressedOrderSummary = false;
  bool isPressedShipto = true;
  TextEditingController emailController =
      new TextEditingController(text: emailid);
  TextEditingController firstNameController =
      new TextEditingController(text: userName);
  TextEditingController lastNameController =
      new TextEditingController(text: "");
  TextEditingController addressController =
      new TextEditingController(text: street0);
  TextEditingController cityController =
      new TextEditingController(text: "Ras Al-Khaimah");
  TextEditingController stateController =
      new TextEditingController(text: street1);
  TextEditingController zipController =
      new TextEditingController(text: postalcode);
  TextEditingController phoneController =
      new TextEditingController(text: phoneNum);
  TextEditingController countryController =
      new TextEditingController(text: "United Arab Emirates");
  GlobalKey<FormState> _key = new GlobalKey();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _result = 1.0;
          break;
        case 1:
          _result = 2.0;
          break;
        case 2:
          _result = 3.0;
          break;
      }
    });
  }

  void _handlePaymentRadioValueChange(int value) {
    setState(() {
      _paymentRadioValue = value;

      switch (_paymentRadioValue) {
        case 0:
          _result = 1.0;
          break;
        case 1:
          _result = 2.0;
          break;
        case 2:
          _result = 3.0;
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      platform.setMethodCallHandler(_receiveFromHost);
      platform1.setMethodCallHandler(_receiveFromHost);
      if (widget.fromPage != "from address") {
        await getAddressValuesUser();
      }

      await isLoggedIn();
    });
  }

  // static Future<dynamic> _receiveFromHost(MethodCall methodCall) async {
  //   switch (methodCall.method) {
  //     case 'someMethod':
  //       print(methodCall.arguments); // prints the argument - "someValue"
  //       return null; // could return a value here
  //
  //     default:
  //       throw PlatformException(code: 'notimpl', message: 'not implemented');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      // resizeToAvoidBottomPadding: true,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                size: 40,
                color: Colors.black,
              ),
              onPressed: () {
                if (widget.fromPage == "from Login") {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
                  Navigator.pop(context);
                }
              }),
        ),
        title: Text(
          'Review & Payments',
          style: TextStyle(
              fontFamily: 'montserrat',
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        physics: ScrollPhysics(),
        children: [
          verticalSpace(),
          verticalSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: TextStyle(
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.black,
                          value: 0,
                          groupValue: _paymentRadioValue,
                          onChanged: _handlePaymentRadioValueChange,
                        ),
                        Text(
                          'Card Payment',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.black,
                          value: 1,
                          groupValue: _paymentRadioValue,
                          onChanged: _handlePaymentRadioValueChange,
                        ),
                        Text(
                          'Cash on Delivery',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: checkedValue,
                      checkColor: Colors.black, // color of tick Mark
                      activeColor: Colors.black54,
                      onChanged: (newValue) {
                        setState(() {
                          checkedValue = newValue;
                          if (checkedValue) {
                            firstNameController.text = userName;
                            emailController.text = emailid;
                            phoneController.text = phoneNum;
                            addressController.text = street0;
                            zipController.text = postalcode;
                          } else {
                            print("inside");
                            emailController.text = "";
                            firstNameController.text = "";
                            lastNameController.text = "";
                            addressController.text = "";

                            stateController.text = "";
                            zipController.text = "";
                            phoneController.text = "";
                          }
                        });
                      },
                    ),
                    Text('My billing and shipping address are the same')
                  ],
                ),
                phoneNum != ""
                    ? Padding(
                        padding: EdgeInsets.only(left: 50, bottom: 10),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                    fontFamily: 'montserrat', fontSize: 15),
                              ),
                              Text(
                                street0,
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'montserrat'),
                              ),
                              Text(
                                street1,
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'montserrat'),
                              ),
                              Text(
                                'Ras Al-Khaimah',
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'montserrat'),
                              ),
                              SizedBox(
                                  height: 15,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          phoneNum != ""
                                              ? Icon(Icons.phone_in_talk)
                                              : Text(""),
                                          Text(
                                            phoneNum,
                                            style: TextStyle(
                                                fontFamily: 'montserrat',
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      FlatButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddressBook()),
                                          );
                                        },
                                        child: Text('CHANGE ADDRESS',
                                            style: TextStyle(
                                              color: HexColor("302d98"),
                                              fontSize: 12,
                                              fontFamily: 'montserrat',
                                              fontWeight: FontWeight.w600,
                                              decoration:
                                                  TextDecoration.underline,
                                            )),
                                        //
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Container(
                          child: Container(
                            child: FlatButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddressProfileEdit("from Review")),
                                );
                              },
                              child: Text('ADD NEW ADDRESS',
                                  style: TextStyle(
                                    color: HexColor("302d98"),
                                    fontSize: 12,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  )),
                              //
                            ),
                          ),
                        ),
                      ),
                verticalSpace(),
                verticalSpace(),
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 5),
//                  child: Container(
//                    height: 50,
//                    decoration: BoxDecoration(
//                      border: Border.all(width: 1),
//                    ),
//                    child: Row(
//                      children: [
//                        Flexible(
//                          child: TextField(
//                            decoration: InputDecoration(
//                                hintText: "Enter Discount Code",
//                                contentPadding: EdgeInsets.only(left: 10)),
//                          ),
//                        ),
//                        Container(
//                          height: 50,
//                          color: HexColor("302c98"),
//                          child: FlatButton(
//                              onPressed: null,
//                              child: Text(
//                                'APPLY',
//                                style: TextStyle( fontFamily: 'montserrat',
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 15),
//                              )),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//                verticalSpace(),
//                verticalSpace(),
                Container(
                  height: 60,
                  child: Card(
                    elevation: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPressedOrderSummary = !isPressedOrderSummary;
                              });
                            },
                            child: Text(
                              'Order Summary',
                              style: TextStyle(
                                  fontFamily: 'montserrat', fontSize: 15),
                            ),
                          ),
                        ),
                        IconButton(
                          iconSize: 40,
                          icon: isPressedOrderSummary
                              ? new Icon(
                                  Icons.expand_less,
                                  color: Colors.black,
                                )
                              : new Icon(
                                  Icons.chevron_right,
                                  color: Colors.black,
                                ),
                          onPressed: () {
                            print("insidee");
                            setState(() {
                              isPressedOrderSummary = !isPressedOrderSummary;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                isPressedOrderSummary
                    ? Container(
                        child: Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
//              scrollDirection: Axis.vertical,
                            itemCount: HomePage.cartCount,
                            itemBuilder: (context, index) {
                              final item = ShoppingCart.cartListItems[index];
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 0.0),
                                    width: MediaQuery.of(context).size.width,
//                      height: 160.0,
                                    child: Container(
//                      clipBehavior: Clip.antiAlias,
                                      child: InkWell(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
//                                      crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                child: CachedNetworkImage(
                                                  height: 65,
                                                  width: 60,
                                                  fit: BoxFit.fill,
                                                  imageUrl: ShoppingCart
                                                      .imageUrls[index],
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child: SpinKitPulse(
                                                      color: Colors.red,
                                                      size: 50.0,
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          new Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              150,
                                                      padding: EdgeInsets.only(
                                                        left: 5,
                                                      ),
                                                      child: Flex(
                                                        direction:
                                                            Axis.horizontal,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              item.name
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 0.0,
                                                        left: 5,
                                                        right: 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: TextSpan(
                                                            text: 'AED ',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'montserrat',
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black87,
                                                            ),

                                                            /*defining default style is optional */
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                  text: item
                                                                      .price
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'montserrat',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15)),
//                                                          TextSpan(
//                                                              text: '/pcs',
//                                                              style: TextStyle( fontFamily: 'montserrat',
//                                                                  color: Colors.black54,
//                                                                  fontWeight:
//                                                                  FontWeight.bold,
//                                                                  fontSize: 12)),
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
                                              child: SizedBox(
                                                height: 25.0,
                                                width: 50.0,
                                                // fixed width and height
                                                child: new Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: 40.0,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5,
                                                              top: 3,
                                                              bottom: 3),
                                                      child: new Text(
                                                        item.qty.toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'montserrat',
                                                            fontSize: 10),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.green),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
//                                              color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          verticalSpace(),
                          verticalSpace(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 1,
                                  color: Colors.black12,
                                ),
                                verticalSpace(),
                                Text(
                                  'Summary',
                                  style: TextStyle(
                                      fontFamily: 'montserrat', fontSize: 16),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: [
//                                Text('Estimate Shipping & Tax',
//                                    style: GoogleFonts.openSans(
//                                      textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 14),
//                                    )),
//                                IconButton(
//                                    icon: Icon(
//                                      Icons.keyboard_arrow_up,
//                                      size: 30,
//                                    ),
//                                    onPressed: null),
//                              ],
//                            ),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: [
//                                Expanded(
//                                  child: Container(
//                                    height: 35,
////                        width: 100,
//                                    decoration: BoxDecoration(
//                                        borderRadius: BorderRadius.circular(1),
//                                        border: Border.all(color: Colors.black12)),
//                                    child: Center(
//                                      child:Text('UAE',
//                                        style: GoogleFonts.openSans(
//                                          textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 14),
//
//                                        ),
//                                        textAlign: TextAlign.center,
//                                      ) ,
//                                    ),
//
//                                  ),
//                                ),
//                                SizedBox(
//                                  width: 5,
//                                ),
//                                Expanded(
//                                  child: Container(
//                                    height: 35,
////                        width: 100,
//                                    decoration: BoxDecoration(
//                                        borderRadius: BorderRadius.circular(1),
//                                        border: Border.all(color: Colors.black12)),
//                                    child:  Center(
//                                      child:Text('Ras al Khaimah',
//                                        style: GoogleFonts.openSans(
//                                          textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 14),
//
//                                        ),
//                                        textAlign: TextAlign.center,
//                                      ) ,
//                                    ),
////                          Center(
////                            child: TextField(
//////                          controller: controller,
////
////                              decoration: InputDecoration(
////                                hintText: 'State/Province',
////                                contentPadding:
////                                    EdgeInsets.only(left: 1, bottom: 15),
////                                hintStyle: TextStyle( fontFamily: 'montserrat', fontSize: 12),
////                                border: InputBorder.none,
////                              ),
////                              textAlign: TextAlign.center,
////                            ),
////                          ),
//                                  ),
//                                ),
//                                SizedBox(
//                                  width: 5,
//                                ),
//                                Expanded(
//                                  child: Container(
//                                    height: 35,
////                        width: 100,
//                                    decoration: BoxDecoration(
//                                        borderRadius: BorderRadius.circular(1),
//                                        border: Border.all(color: Colors.black12)),
//                                    child: Center(
//                                      child: TextField(
////                          controller: controller,
//
//                                        decoration: InputDecoration(
//                                          hintText: 'Zip/Postal',
//                                          contentPadding:
//                                          EdgeInsets.only(left: 1, bottom: 15),
//                                          hintStyle: TextStyle( fontFamily: 'montserrat', fontSize: 12),
//                                          border: InputBorder.none,
//                                        ),
//                                        textAlign: TextAlign.center,
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                SizedBox(
//                                  width: 5,
//                                ),
//                              ],
//                            ),
//                            Row(
//                              children: [
//                                Text(
//                                  'Flat Rate: ',
//                                  style: GoogleFonts.openSans(
//                                      textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 14)),
//                                ),
//                                Radio(value: null, groupValue: null, onChanged: null),
//                                Text('Fixed AED 30',
//                                    style: GoogleFonts.openSans(
//                                        textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 14))),
//                              ],
//                            ),
                                Container(
                                  height: 1,
                                  color: Colors.black12,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Sub Total',
                                        style: TextStyle(
                                            fontFamily: 'montserrat',
                                            fontSize: 14)),
                                    Text(
                                      'AED' + ShoppingCart.subTotal.toString(),
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: [
//                                RichText(
//                                  text: TextSpan(
//                                    text: 'Shipping ',
//                                    style: GoogleFonts.openSans(
//                                        color: Colors.black87,
//                                        textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 14)),
//                                    children: <TextSpan>[
//                                      TextSpan(
//                                          text: '(Flat Rate-Fixed)',
//                                          style: TextStyle( fontFamily: 'montserrat',
//                                              fontSize: 10, color: Colors.black54)),
//                                    ],
//                                  ),
//                                ),
//                                Text('AED' + ShoppingCart.shippingPrice.toString(),
//                                    style: GoogleFonts.openSans(
//                                      textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 16),
//                                    )),
//                              ],
//                            ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    hintText: "Discount Code",
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 12),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 10)),
                                              ),
                                            ),
//                                        Container(
//                                          height: 40,
//                                          color: HexColor("302c98"),
//                                          child: FlatButton(
//                                              onPressed: null,
//                                              child: Text(
//                                                'APPLY',
//                                                style: TextStyle( fontFamily: 'montserrat',
//                                                    color: Colors.white,
//                                                    fontWeight: FontWeight.bold,
//                                                    fontSize: 15),
//                                              )),
//                                        )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      '- AED 0',
                                      style: TextStyle(
                                          fontFamily: 'montserrat',
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.black12,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order Total',
                                      style: TextStyle(
                                          fontFamily: 'montserrat',
                                          fontSize: 16),
                                    ),
                                    Text(
                                      'AED' +
                                          ShoppingCart.grandTotal.toString(),
                                      style: TextStyle(
                                          fontFamily: 'montserrat',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                    : new Container(),
                Container(
                  height: 60,
                  child: Card(
                    elevation: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPressedShipto = !isPressedShipto;
                            });
                          },
                          child: Text(
                            '   Ship to',
                            style: TextStyle(
                                fontFamily: 'montserrat', fontSize: 15),
                          ),
                        ),
                        IconButton(
                          iconSize: 40,
                          icon: isPressedShipto
                              ? new Icon(
                                  Icons.expand_less,
                                  color: Colors.black,
                                )
                              : new Icon(
                                  Icons.chevron_right,
                                  color: Colors.black,
                                ),
                          onPressed: () {
//                            if(checkedValue) {
                            setState(() {
                              isPressedShipto = !isPressedShipto;
                            });
//                            } else {
//                              isPressedShipto = false;
//                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                isPressedShipto
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: _key,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: emailController,
//                          initialValue: checkedValue ? emailid : " ",
//                           enabled: checkedValue && emailid != "" ? false : true,
                                validator: validateEmail,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      fontFamily: 'montserrat',
                                      color: Colors.black54,
                                      fontSize: 15),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              verticalSpace(),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: firstNameController,
//                          enabled: checkedValue  && userName != ""? false : true,
                                validator: validateName,
                                decoration: InputDecoration(
                                  hintText: 'First Name',
                                  hintStyle: TextStyle(
                                      fontFamily: 'montserrat',
                                      color: Colors.black54,
                                      fontSize: 15),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              verticalSpace(),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: phoneController,
                                validator: validateMobile,
//                          enabled: checkedValue ? false : true,
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  hintStyle: TextStyle(
                                      fontFamily: 'montserrat',
                                      color: Colors.black54,
                                      fontSize: 15),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              verticalSpace(),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                validator: validateAddress,
                                controller: addressController,
//                          enabled:checkedValue && street0  == "" ? false : true,
                                decoration: InputDecoration(
                                  hintText: ' Address',
                                  hintStyle: TextStyle(
                                      fontFamily: 'montserrat',
                                      color: Colors.black54,
                                      fontSize: 15),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              verticalSpace(),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: stateController,
//                          enabled: checkedValue && street1  == "" ? false : true,
                                decoration: InputDecoration(
                                  hintText: ' Area Landmark',
                                  hintStyle: TextStyle(
                                      fontFamily: 'montserrat',
                                      color: Colors.black54,
                                      fontSize: 15),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              verticalSpace(),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: zipController,
//                          validator: validateZip,
//                          enabled: checkedValue && postalcode != "" ? false : true,
                                decoration: InputDecoration(
                                  hintText: 'Zip/Postal Code',
                                  hintStyle: TextStyle(
                                      fontFamily: 'montserrat',
                                      color: Colors.black54,
                                      fontSize: 15),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              verticalSpace(),
                              TextFormField(
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: cityController,
                                decoration: InputDecoration(
                                  hintText: 'Ras Al-Khaimah',
                                  hintStyle: TextStyle(
                                      fontFamily: 'montserrat',
                                      color: Colors.black,
                                      fontSize: 15),
                                  border: OutlineInputBorder(),
                                ),
                              ),

                              verticalSpace(),
                              TextFormField(
                                enabled: false,
//                          initialValue: 'United Arab Emirates',
                                keyboardType: TextInputType.text,
                                controller: countryController,
                                decoration: InputDecoration(
                                  hintText: 'United Arab Emirates',
                                  hintStyle: TextStyle(
                                      fontFamily: 'montserrat',
                                      color: Colors.black,
                                      fontSize: 15),
                                  border: OutlineInputBorder(),
                                ),
                              ),

//                    verticalSpace(),
//                    TextFormField(
//                      keyboardType: TextInputType.text,
//                      controller: companyController,
//                      decoration: InputDecoration(
//                        hintText: 'Company',
//                        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 15),
//                        border: OutlineInputBorder(),
//                      ),
//                    ),
                              verticalSpace(),
                            ],
                          ),
                        ),
                      )
                    : new Container(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    color: HexColor("302d98"),
                    borderRadius: BorderRadius.circular(5)),
                child: FlatButton(
                    onPressed: () async {
                      _showDialog();
                      if (_key.currentState.validate()) {
                        if (isloggedIn == true) {
                          await addOrderAddressUser();
                        } else {
                          await mergeCarttoUserCart();
                        }
                        _globalKey.currentState.showSnackBar(
//
                            new SnackBar(
                          backgroundColor: Colors.white,
                          duration: new Duration(seconds: 2),
                          content: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new SpinKitPulse(
                                color: Colors.red,
                                size: 50.0,
                              ),
                              new Text(
                                "  Order Placing...",
                                style: TextStyle(
                                    fontFamily: 'montserrat',
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ));
//                          );

                      }
                    },
                    child: Text(
                      'PLACE ORDER',
                      style: TextStyle(
                          fontFamily: 'montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  Future<bool> getAddressValuesUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('firstname');
      phoneNum = prefs.getString('phone') ?? "";
      street0 = prefs.getString('street0') ?? "";
      street1 = prefs.getString('street1') ?? "";
      city = prefs.getString('city') ?? "";
      password = prefs.getString('password');
      emailid = prefs.getString('email');
      postalcode = prefs.getString('postalcode');
//      phoneController.text = phoneNum;
//      firstNameController.text = userName;
//      addressController.text = street0;
//      stateController.text = street1;
//      emailController.text = emailid;
      print(userName);
      print(phoneNum);
      print(street0);
      print(password);
      print(emailid);
      final resisterRespons = prefs.getString('userData');
      Map json = jsonDecode(prefs.getString('userData'));
      print(json);
      userreg_model = UserRegistration.fromJson(json);
    });
  }

  Future addOrderAddressUser() async {
    print("called address for user");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    print("areddddddesss user    ");
    print("tokkkkennnn user");
    print(token2);
    String headerText = "Bearer " + token2;
//    Map data = { "addressInformation": { "shipping_address": MainHome.addressValue, "billing_address": MainHome.addressValue, "shipping_carrier_code": "flatrate", "shipping_method_code": "flatrate" }
//    };
    Map data = {
      "addressInformation": {
//      "shipping_address": {
//      "region": userreg_model.addresses[0].region.region,
//      "region_id": userreg_model.addresses[0].region.regionId,
//      "region_code": userreg_model.addresses[0].region.regionCode,
//      "country_id": widget.countryController,
//      "street": userreg_model.addresses[0].street,
//      "postcode": widget.zipController,
//      "city": widget.cityController,
//      "firstname": widget.firstNameController,
//      "lastname": widget.lastNameController,
//      "email": widget.emailController,
//      "telephone": widget.phoneController
//    },
        "shipping_address": {
//      "region": userreg_model.addresses[0].region.region,
//      "region_id": userreg_model.addresses[0].region.regionId,
//      "region_code": userreg_model.addresses[0].region.regionCode,
          "country_id": "AE",
          "street": [addressController.text, stateController.text],
          "postcode": postalcode,
          "city": "Ras Al-Khaimah",
          "firstname": firstNameController.text,
          "lastname": firstNameController.text,
          "email": emailController.text,
          "telephone": phoneController.text
        },
        "billing_address": {
//        "region": userreg_model.addresses[0].region.region,
//        "region_id": userreg_model.addresses[0].region.regionId,
//        "region_code": userreg_model.addresses[0].region.regionCode,
          "country_id": "AE",
          "street": [addressController.text, stateController.text],
          "postcode": postalcode,
          "city": "Ras Al-Khaimah",
          "firstname": firstNameController.text,
          "lastname": lastNameController.text,
          "email": emailController.text,
          "telephone": phoneController.text
        },
        "shipping_carrier_code": ShoppingCart.carrierCode,
        "shipping_method_code": ShoppingCart.methodCode,
      }
    };
    //encode Map to JSON
    var body = json.encode(data);
    print(body);
    final response = await http.post(Uri.parse(
      baseUrl + 'rest/V1/carts/mine/shipping-information'),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
      body: body,
    );
    final responseJson = json.decode(response.body);

    print("address responsee user");
    print(responseJson);
    await userPaymentInformation();
  }

  Future userPaymentInformation() async {
    if (_paymentRadioValue == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('userKey');
      String token1 = token.replaceFirst(RegExp('"'), '');
      String token2 = token1.replaceFirst(RegExp('"'), '');
      String headerText = "Bearer " + token2;
      Map data = {
        "paymentMethod": {"method": "cashondelivery"},
        "billing_address": {
//        "region": userreg_model.addresses[0].region.region,
//        "region_id": userreg_model.addresses[0].region.regionId,
//        "region_code":  userreg_model.addresses[0].region.regionCode,
          "country_id": "AE",
          "street": [addressController.text, stateController.text],
          "postcode": zipController.text,
          "city": "Ras Al-Khaimah",
          "firstname": firstNameController.text,
          "lastname": firstNameController.text,
          "email": emailController.text,
          "telephone": phoneController.text
        }
      };
      //encode Map to JSON
      var body = json.encode(data);
      final response = await http.post(Uri.parse(
        baseUrl + 'rest/V1/carts/mine/payment-information'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        },
        body: body,
      );
      final responseJson = json.decode(response.body);
      orderID = response.body;
      print("order responsesse");
      print(responseJson);
      setState(() {
        HomePage.cartCount = 0;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ThankYouPage(orderID: orderID)));
    } else {
      print("trigering online");
      Printy();
    }
  }

  String value;
  void Printy() async {
    platform.setMethodCallHandler(_receiveFromHost);

    List<String> paymnetData;
    String value;
    paymnetData = new List<String>();
    // String quoteId = "testing..";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String quoteId = prefs.getString('userQuoteId');

    String amount = ShoppingCart.grandTotal.toString();
    paymnetData.insert(0, amount);
    String address1 = addressController.text;
    paymnetData.insert(1, address1);
    String cityVal = "Ras Al-Khaimah";
    paymnetData.insert(2, address1);
    String country = "UAE";
    paymnetData.insert(3, country);
    String first_name = firstNameController.text;
    paymnetData.insert(4, first_name);
    String last_name = firstNameController.text;
    paymnetData.insert(5, last_name);
    String email = emailController.text;
    paymnetData.insert(6, email);
    String phone = phoneController.text;
    paymnetData.insert(7, phone);

    print("values");
    print(quoteId +
        amount +
        address1 +
        cityVal +
        country +
        first_name +
        last_name +
        email +
        phone);
    paymnetData.insert(8, quoteId);
    String tempVal;
    String tempVal2;
    try {
      tempVal = await platform.invokeMethod('invokingfromdart', paymnetData);
      tempVal2 = await platform1.invokeMethod('invokingfromdart2', "");
      print("My Temp : $tempVal");
      setState(() {
        value = tempVal;
      });
      if (tempVal == "success") {
        callAfterPaymentSuccess();
        setState(() {
          HomePage.cartCount = 0;
        });
      }
      if (tempVal2 == "success") {
        callAfterPaymentSuccess();
        setState(() {
          HomePage.cartCount = 0;
        });
      }
      // callAfterPaymentSuccess();
      // setState(() {
      //   HomePage.cartCount = 0 ;
      // });
      /* Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThankYouPage(orderID: orderID)),
      );*/
    } catch (e) {
      print(e);
    }

    // try{
    //   value = await platform.invokeMethod('goToLogin',paymnetData);
    // }catch(e){
    //   print(e);
    // }
    // var paymentstaus = "" ;
    //
    // try {
    //   final int result =  await platform.invokeMethod('goToLogin',paymnetData);
    //   paymentstaus = 'Battery level at $result % .';
    // } on PlatformException catch (e) {
    //   paymentstaus = "Failed to get battery level: '${e.message}'.";
    // }
  }

  Future<dynamic> _receiveFromHost(MethodCall methodCall) async {
    print("success from native.......");

    if (methodCall.method == "fromHostToClient") {
      final String data = methodCall.arguments;
      if (data == "success") {
        callAfterPaymentSuccess();
        setState(() {
          HomePage.cartCount = 0;
        });
      } else if (data == "failed") {
        _showFailureDialog("Payment Failed");
      } else if (data == "canceled") {
        _showFailureDialog("Payment Cancelled");
      }
    }
  }

  Future<bool> isLoggedIn() async {
    if (HomePage.isGuestManagement == false) {
      print("user is loged user.. in payment");
      setState(() {
        isloggedIn = true;
      });
    } else {
      print("user is guest user..  in payment");
      setState(() {
        isloggedIn = false;
      });
    }
    return isloggedIn;
  }

  Future<bool> mergeCarttoUserCart() async {
    // var url = baseUrl + 'rest/V1/integration/customer/token';
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String username = prefs.getString('email');
    // String password = prefs.getString('password');
    // print("listen for user key");
    // print(username);
    // print(password);
    // Map data = {
    //   "username": username,
    //   "password": password
    // };
    //
    // //encode Map to JSON
    // var body = json.encode(data);
    //
    // var response = await http.post(url,
    //     headers: {"Content-Type": "application/json"},
    //     body: body
    // );
    // prefs.setString('userKey', response.body);
    // String token = prefs.getString('userKey');
    // String token1 = token.replaceFirst(RegExp('"'), '');
    // String token2 = token1.replaceFirst(RegExp('"'), '');
    //
    //
    // var customer_id = prefs.getInt("customer_id");
    // String guestKey = prefs.getString('guestKey');
    // String guestKey1 = guestKey.replaceFirst(RegExp('"'), '');
    // String guestKey2 = guestKey1.replaceFirst(RegExp('"'), '');
    // String headerText = "Bearer " + token2;
    //
    //
    // Map data1 = {
    //   "customerId": customer_id,
    //   "storeId": 1
    //
    // };
    // var body1 = json.encode(data1);
    // final response1 = await http.put(
    //   baseUrl + 'rest/V1/guest-carts/$guestKey2',
    //   headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText},
    //   body: body1,
    // );
    // final responseJson1 = json.decode(response1.body);
    // orderID = response1.body;
    // print("cart merge responsesse");
    // print(responseJson1);

    for (var i = 0; i < ShoppingCart.cartListItems.length; i++) {
      var skuVAl = ShoppingCart.cartListItems[i].sku;
      var qty = ShoppingCart.cartListItems[i].qty;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('userKey');
      String quoteId = prefs.getString('userQuoteId');
      String token1 = token.replaceFirst(RegExp('"'), '');
      String token2 = token1.replaceFirst(RegExp('"'), '');
      String headerText = "Bearer " + token2;
      print("inside for cart merging");
      print(quoteId);
      print("inside for cart merging");
      Map data = {
        "cartItem": {"quote_id": quoteId, "sku": skuVAl, "qty": qty}
      };
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(Uri.parse(baseUrl + 'rest/V1/carts/mine/items'),
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: headerText
          },
          body: body);
      print("cart logined user added");

      final responseJson = json.decode(response.body);
    }

    await addOrderAddressUser();
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateAddress(String value) {
    if (value.length == 0) {
      return "Address is Required";
    }
    return null;
  }

  String validatePassword(String value) {
    String patttern =
        r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,15}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "password is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Password should contain Lower Case, Upper Case, Digits, Special Characters.";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }
  // Future<void> getPaymetDetails() async {
  //   try {
  //     final response = await platform.invokeMethod('getPaymentData');
  //   } on PlatformException catch(error){
  //     print("${error.message}");
  //   }
  // }

  void _showDialog() {
    new SnackBar(
      backgroundColor: Colors.white,
      duration: new Duration(seconds: 2),
      content: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new SpinKitPulse(
            color: Colors.red,
            size: 50.0,
          ),
          new Text(
            "Please wait...",
            style: TextStyle(
                fontFamily: 'montserrat',
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
    // flutter defined function
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     // return object of type Dialog
    //     return AlertDialog(

    //       content:
    //       RichText(
    //         overflow: TextOverflow.ellipsis,
    //         text: TextSpan(
    //           text: 'Reminder: ',
    //           style:  TextStyle( fontFamily: 'montserrat',
    //               fontSize: 14,
    //               color: HexColor("302c98"),
    //               fontWeight: FontWeight.bold),

    //           /*defining default style is optional */
    //           children: <TextSpan>[
    //             TextSpan(
    //               text: "All perishable items cannot be \n returned or exchanged due to current \n COVID-19 situation.Orders made after 4:00PM \n will be processed and delivered the next day\n  starting 8:00AM. For orders placed from \n 8:00AM to 4:00PM, deliveries will be performed \n on the same day.",

    //               style: TextStyle( fontFamily: 'montserrat',
    //                   fontSize: 12,
    //                   color: Colors.black,
    //                   fontWeight: FontWeight.w400),

    //             ),
    //           ],
    //         ),
    //       ),
    //       actions: <Widget>[
    //         // usually buttons at the bottom of the dialog
    //         new FlatButton(
    //           child: new Text("Okay"),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void _showFailureDialog(String msg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: msg,
              style: TextStyle(
                  fontFamily: 'montserrat',
                  fontSize: 14,
                  color: HexColor("302c98"),
                  fontWeight: FontWeight.bold),

              /*defining default style is optional */
              children: <TextSpan>[
                TextSpan(
                  text: "",
                  style: TextStyle(
                      fontFamily: 'montserrat',
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
//                                      TextSpan(
//                                          text: ' /pcs',
//                                          style: TextStyle( fontFamily: 'montserrat',
//                                              fontWeight: FontWeight.bold,
//                                              color: Colors.black,
//                                              fontSize: 15)),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //////////////////
  Future callAfterPaymentSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    Map data = {
      "paymentMethod": {"method": "telr_telrpayments"},
      "billing_address": {
        "country_id": "AE",
        "street": [addressController.text, stateController.text],
        "postcode": zipController.text,
        "city": "Ras Al-Khaimah",
        "firstname": firstNameController.text,
        "lastname": firstNameController.text,
        "email": emailController.text,
        "telephone": phoneController.text
      }
    };
    //encode Map to JSON
    var body = json.encode(data);
    final response = await http.post(Uri.parse(
      baseUrl + 'rest/V1/carts/mine/payment-information'),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
      body: body,
    );
    final responseJson = json.decode(response.body);
    orderID = response.body;
    print("order responsesse");
    print(responseJson);
    setState(() {
      HomePage.cartCount = 0;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ThankYouPage(orderID: orderID)));
  }
//////////////////////////////////////////

}
