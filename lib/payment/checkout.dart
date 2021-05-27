import 'dart:convert';
import 'dart:io';
import 'package:Alaswaq/Model/cart_list_model.dart';
import 'package:Alaswaq/Model/product_by_sku.dart';
import 'package:Alaswaq/Model/register_model.dart';
import 'package:Alaswaq/Model/total_model.dart';
import 'package:Alaswaq/common/drawer.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/account/login/login_page.dart';
import 'package:Alaswaq/payment/review_and_payments.dart';
import 'package:Alaswaq/payment/thank_you.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

var orderID;

class CheckoutPage extends StatefulWidget {
  List<String> imageUrls = [];
  List<CartListModel> cartListItems = new List<CartListModel>();
  CheckoutPage({this.imageUrls,this.cartListItems,});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {


  TextEditingController emailController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController zipController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
//  TextEditingController companyController = new TextEditingController();

  bool _validate = false;
  GlobalKey<FormState> _key = new GlobalKey();






  ////////////////////
  TotalModel total_model;
  ProductBySku productSku;
  List<String> imageUrls = [];
  List<CartListModel> cartListItems = new List<CartListModel>() ;
  var subTotal = 0.0;
  var shippingPrice = 0;
  var grandTotal = 0.0;
  var vat = 0;
  var isloggedIn = false;
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await isLoggedIn();
      // your code after page opens,splash keeps open until work is done
    });
//    getCategory();
//    getBestSeller();
  }



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
          'CHECKOUT',
          style: TextStyle( fontFamily: 'montserrat', 
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Text(
                'Shipping Address',
                style: TextStyle( fontFamily: 'montserrat', fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: emailController,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    verticalSpace(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: firstNameController,
                      validator: validateName,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    verticalSpace(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: lastNameController,
                      validator: validateName,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    verticalSpace(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: addressController,
                      decoration: InputDecoration(
                        hintText: 'Street Address',
                        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    verticalSpace(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: cityController,
                      decoration: InputDecoration(
                        hintText: 'City',
                        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    verticalSpace(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: stateController,
                      decoration: InputDecoration(
                        hintText: 'State/Province',
                        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    verticalSpace(),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: zipController,
                      decoration: InputDecoration(
                        hintText: 'Zip/Postal Code',
                        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    verticalSpace(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: countryController,
                      decoration: InputDecoration(
                        hintText: 'Country',
                        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    verticalSpace(),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
//                    verticalSpace(),
//                    TextFormField(
//                      keyboardType: TextInputType.text,
//                      controller: companyController,
//                      decoration: InputDecoration(
//                        hintText: 'Company',
//                        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 20),
//                        border: OutlineInputBorder(),
//                      ),
//                    ),
                    verticalSpace(),
                    Row(
                      children: [
                        Text(
                          'Shipping Methods',
                          style: TextStyle( fontFamily: 'montserrat', fontSize: 15,fontWeight: FontWeight.bold),
                        ),
                        Radio(value: null, groupValue: null, onChanged: null),
                        Text(
                          'Flat Rate: Fixed AED 30',
                          style: TextStyle( fontFamily: 'montserrat', fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              verticalSpace(),
              Container(
                height: MediaQuery.of(context).size.height * .4,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Summary',
                              style: TextStyle( fontFamily: 'montserrat', 
//                                      fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            GestureDetector(
                              child: Text(
                                widget.cartListItems.length.toString() +
                                    ' Items in Cart',
                                style:
                                    TextStyle( fontFamily: 'montserrat', color: Colors.deepOrangeAccent),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
//                          physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
//              scrollDirection: Axis.vertical,
                            itemCount: HomePage.cartCount,
                            itemBuilder: (context, index) {
                              final item = widget.cartListItems[index];
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
//                                  width: MediaQuery.of(context).size.width - 30,
//                                  height: 160.0,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Card(
                                          elevation: 5,
                                          child: CachedNetworkImage(
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.fill,
                                            imageUrl: widget.imageUrls[index],
                                            placeholder: (context, url) => Center(
                                                child:
                                                     SpinKitPulse(
                                              color: Colors.red,
                                              size: 50.0,
                                            ),),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(Icons.error),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Container(
                                                width: 100,
                                                child: Text(
                                                  item.name,
//                                                            overflow: TextOverflow
//                                                                .ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle( fontFamily: 'montserrat', 
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, top: 2, bottom: 10),
                                              child: Row(
                                                children: <Widget>[
                                                  RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                      text: 'Qty: ',
                                                      style: TextStyle( fontFamily: 'montserrat', 
                                                          color: Colors.black,
                                                          fontSize: 18),
                                                      /*defining default style is optional */
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: (item.qty)
                                                                .toString(),
                                                            style: TextStyle( fontFamily: 'montserrat', 
                                                                fontSize: 18)),
                                                        TextSpan(
                                                            text: ' KG',
                                                            style: TextStyle( fontFamily: 'montserrat', 
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 18)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                            "AED " +
                                                (item.price * item.qty)
                                                    .toString(),
                                            style: TextStyle( fontFamily: 'montserrat', fontSize: 18)),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80,
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
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(5)),
                child: FlatButton(
                  onPressed: () async {
                    print("issss status");
                    print(isloggedIn);
                    if(HomePage.cartCount > 0 ) {
                      if (isloggedIn == true) {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) =>
////                                            Products("1","1",2.0, "1","1"),
//                              ReviewAndPayments(
//                                emailController:emailController.text,
//                                firstNameController:firstNameController.text,
//                                lastNameController:lastNameController.text,
//                                addressController:addressController.text,
//                                cityController:cityController.text,
//                                stateController:stateController.text,
//                                zipController:zipController.text,
//                                countryController:countryController.text,
//                                phoneController:phoneController.text,
////                                companyController:companyController
//
//                              ),
//                            ));

                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
//                                            Products("1","1",2.0, "1","1"),
                              LogInPage( 3),
                            ));
                      }
                    }

                  },
                  child: Text(
                    'CONTINUE PAYMENTS',
                    style: TextStyle( fontFamily: 'montserrat', 
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  


  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint(prefs.getBool('isLoggedIn').toString());
    final loginStatus = prefs.getBool('isLoggedIn');
    if (loginStatus == true) {
      print("user is loged user.. in cart checkouts");
      await getUserCartList();
      await totalCartUser();
      setState(() {
        isloggedIn = true;
      });


    } else {
      print("user is guest user..  in cart");
      getGuestCartList();
      await totalCartGuest();
      setState(() {
        isloggedIn = false;
      });

    }
    return prefs.getBool('isLoggedIn');
//    await getUserCartList();
//      await totalCartUser();
  }

  Future totalCartUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    var response = await http.get(Uri.parse(
        baseUrl + 'rest/V1/carts/mine/totals'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        }
    );
    final responseJson = json.decode(response.body);
    print("cart total");
    print(responseJson);
    total_model = TotalModel.fromJson(responseJson);
    setState(() {
      grandTotal = total_model.grandTotal;
      subTotal = total_model.subtotal;
      shippingPrice = total_model.shippingAmount ;
      vat = total_model.taxAmount;
    });
  }

  Future totalCartGuest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    var response = await http.get(Uri.parse(
        baseUrl + 'rest/V1/guest-carts/$token2/totals'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        }
    );
    final responseJson = json.decode(response.body);
    print("guestcart total total_model.subtotal");
    print(responseJson);
    total_model = TotalModel.fromJson(responseJson);
    setState(() {
      grandTotal = total_model.grandTotal;
      print(total_model.subtotal);
      subTotal = total_model.subtotal;
      vat = total_model.shippingAmount;
    });

  }

  Future getUserCartList() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    final response = await http.get(Uri.parse(
      baseUrl + 'rest/V1/carts/mine/items'),
      headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText},
    );
    final responseJson = json.decode(response.body);
    var count =  responseJson.length;
    setState(() {
      HomePage.cartCount =  responseJson.length;
    });
    for (var i = 0; i < responseJson.length; i++) {
      setState(() {
        cartListItems.add(CartListModel.fromJson(responseJson[i]));

      });
      await getImageUrl(cartListItems[i].sku);
    }

  }

  Future getGuestCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    print( baseUrl + 'rest/V1/guest-carts/$token2/items');
    final response = await http.get(Uri.parse(
      baseUrl + 'rest/V1/guest-carts/$token2/items'),
      headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText},
    );
    final responseJson = json.decode(response.body);
    var count =  responseJson.length;
    print("number of items in cart");
    setState(() {
      HomePage.cartCount =  responseJson.length;
    });
    for (var i = 0; i < responseJson.length; i++) {
      setState(() {
        cartListItems.add(CartListModel.fromJson(responseJson[i]));

      });
      await getImageUrl(cartListItems[i].sku);
    }
  }

  Future getImageUrl(String skuVAl) async {

    var url = baseUrl + 'rest/V1/products/$skuVAl';
    var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"}
    );
    final responseJson = json.decode(response.body);
    print("image response");
    print(responseJson);
    productSku = ProductBySku.fromJson(responseJson);


    for (var j = 0; j < productSku.customAttributes.length; j++) {
      if (productSku.customAttributes[j].attributeCode == "image") {
        setState(() {
          imageUrls.add(
              "https://aswaqrak.ae/pub/media/catalog/product" +
                  productSku.customAttributes[j].value);
        });
      }
    }
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

//  Future saveUserData(UserRegistration userDataFromServer) async {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setBool('isLoggedIn', true);
//    prefs.setString('email', userDataFromServer.email);
////    prefs.setString('password', passwordController.text);
//    prefs.setInt('customer_id', userDataFromServer.id);
//    prefs.setString('firstname', userDataFromServer.firstname);
//    prefs.setString('lastname', userDataFromServer.lastname);
//    var address = userDataFromServer.addresses;
//    HomePage.addressValue = address;
//    prefs.setString('phone', address[0].telephone);
//    prefs.setStringList('street', address[0].street);
//    prefs.setString('city', address[0].city);
//    setState(() {
//      HomePageState.isLogin == true;
//    });
////    Navigator.push(
////        context,
////        MaterialPageRoute(
////          builder: (context) => ReviewAndPayments(),
////        ));
////    if (widget.toPageId == 1) {
////      Navigator.push(
////          context,
////          MaterialPageRoute(
////            builder: (context) => HomePage(),
////          ));
////    } else if (widget.toPageId == 2) {
////      Navigator.push(
////          context,
////          MaterialPageRoute(
////            builder: (context) => OrdersList(),
////          ));
////    } else if (widget.toPageId == 3) {
////      Navigator.push(
////          context,
////          MaterialPageRoute(
////            builder: (context) => ReviewAndPayments(),
////          ));
////    }
//  }

}

