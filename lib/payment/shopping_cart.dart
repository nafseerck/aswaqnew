import 'dart:convert';
import 'dart:io';
import 'package:Alaswaq/Model/cart_list_model.dart';
import 'package:Alaswaq/Model/product_by_sku.dart';
import 'package:Alaswaq/Model/total_model.dart';
import 'package:Alaswaq/account/login/login_page.dart';
import 'package:Alaswaq/common/drawer.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/dashboard.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/payment/checkout.dart';
import 'package:Alaswaq/payment/review_and_payments.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ShoppingCart extends StatefulWidget {
  @override
  static TotalModel total_model;
  static  ProductBySku productSku;
  static List<String> imageUrls = [];
  static  List<CartListModel> cartListItems = [];
  static  var subTotal = 0.0;
  static  var shippingPrice = 0;
  static  var grandTotal = 0.0;
  static  var vat = 0;
  static var carrierCode = "";
  static var  methodCode = "";

  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  // ignore: non_constant_identifier_names

  bool _progressController = true;
  bool _progressPrice = true;
  TextEditingController discountController = new TextEditingController();

  var isloggedIn = false;
  var amount = 0;
//  int imageIndex = 0;
//   TotalModel total_model;
//   ProductBySku productSku;
//   var subTotal = 0;
//   var shippingPrice = 0;
//   var grandTotal = 0;
//   var vat = 0;
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
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          'Shopping Cart',
          style: TextStyle(fontFamily: 'montserrat',
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),

        ),
      ),
      body: _progressController
          ? Center(
        child: SpinKitPulse(
          color: Colors.red,
          size: 50.0,
        ),
      )

          :
      SingleChildScrollView(
        physics: ScrollPhysics(),
        child: HomePage.cartCount == 0 ? Center(
          child: Text(
            "\n" + "\n" + "\n" + "\n" + "\n" + "\n" + "Your Cart is Empty",
            style: TextStyle(fontFamily: 'montserrat',
                color: Colors.black38,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ) : Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Order',
                    style: TextStyle(fontFamily: 'montserrat',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
//                  GestureDetector(
//                    child: Text(
//                      'Update Cart',
//                      style: TextStyle(fontFamily: 'montserrat',
//                          color: Colors.deepOrangeAccent, fontSize: 12),
//                    ),
//                  ),
                ],
              ),
            ),
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
//                      height: 160.0,
                      child: Container(
//                      clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    height: 65,
                                    width: 60,
                                    fit: BoxFit.fill,
                                    imageUrl: ShoppingCart.imageUrls[index],
                                    placeholder: (context, url) =>
                                        Center(
                                          child: SpinKitPulse(
                                            color: Colors.red,
                                            size: 50.0,
                                          ),),
                                    errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width -
                                            150,
                                        padding: EdgeInsets.only(
                                          left: 5,
                                        ),
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                item.name
                                                    .toString()
                                                    .substring(0, 10),
                                                textAlign: TextAlign.start,
                                                style:
                                                TextStyle(
                                                    fontFamily: 'montserrat',
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 0.0, left: 5, right: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          RichText(
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              text: 'AED ',
                                              style:
                                              TextStyle(
                                                  fontFamily: 'montserrat',
                                                  fontSize: 16,
                                                  color: Colors.black87),

                                              /*defining default style is optional */
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: item.price.toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'montserrat',
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 15)),
//                                                TextSpan(
//                                                    text: '/pcs',
//                                                    style: TextStyle( fontFamily: 'montserrat',
//                                                        color: Colors.black54,
//                                                        fontWeight:
//                                                            FontWeight.bold,
//                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 5.0, left: 5),
                                      child: SizedBox(
                                        height: 25.0,
                                        width: 200.0,
                                        // fixed width and height
                                        child: new Row(
                                          children: <Widget>[
                                            Center(
                                              child: Container(
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: HexColor("649FC3"),
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            5))),
                                                child: new IconButton(
                                                    icon:
                                                    new Icon(Icons.remove),
                                                    iconSize: 10,
                                                    color: Colors.black,
                                                    onPressed: () {
                                                      setState(() {
                                                        item.qty = item.qty - 1;
                                                      });

                                                      if (isloggedIn == true) {
                                                        removeItemCartUser(
                                                            item.itemId,
                                                            item.qty);
                                                        if (item.qty == 0) {
                                                          removeCartUserItem(
                                                              item.itemId);
                                                          setState(() {
                                                            HomePage.cartCount =
                                                                HomePage
                                                                    .cartCount -
                                                                    1;
                                                            ShoppingCart
                                                                .cartListItems
                                                                .removeAt(
                                                                index);
                                                            //  ShoppingCart.cartListItems[index] = [] as CartListModel;
                                                          });
                                                        }
                                                      } else {
                                                        removeItemCartGuest(
                                                            item.itemId,
                                                            item.qty);
                                                        if (item.qty == 0) {
                                                          removeCartGuestItem(
                                                              item.itemId);
                                                          setState(() {
                                                            HomePage.cartCount =
                                                                HomePage
                                                                    .cartCount -
                                                                    1;
                                                            ShoppingCart
                                                                .cartListItems
                                                                .removeAt(
                                                                index);
                                                            //  ShoppingCart.cartListItems[index] = [] as CartListModel;
                                                          });
                                                        }
                                                      }
                                                    }),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 40.0,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                  right: 5,
                                                  top: 3,
                                                  bottom: 3),
                                              child: new Text(
                                                ShoppingCart.total_model.items[index].qty.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'montserrat',
                                                    fontSize: 10),
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.green),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
//                                              color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                                width: 40.0,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.orange,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(5)),
                                                  color: Colors.white,
                                                ),
                                                child: new IconButton(
                                                  icon: new Icon(Icons.add),
                                                  iconSize: 10,
                                                  color: Colors.lightGreen,
                                                  onPressed: () {
                                                    setState(() {
                                                      item.qty = item.qty + 1;
                                                    });
                                                    if (isloggedIn == true) {
                                                      addCartUser(item.sku, 1);
                                                    } else {
                                                      addCartGuest(item.sku, 1);
                                                    }
                                                  },
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              new GestureDetector(
                                  child: new Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
//                                              color: Colors.black,
                                  onTap: () {
                                    if (HomePageState.isLogin == true) {
                                      removeCartUserItem(
                                          item.itemId);
                                      setState(() {
                                        HomePage
                                            .cartCount =
                                            HomePage
                                                .cartCount -
                                                1;
                                        ShoppingCart.cartListItems
                                            .removeAt(
                                            index);
                                        //  ShoppingCart.cartListItems[index] = [] as CartListModel;
                                      });
                                    } else {
                                      removeCartGuestItem(
                                          item.itemId);
                                      setState(() {
                                        HomePage
                                            .cartCount =
                                            HomePage
                                                .cartCount -
                                                1;
                                        ShoppingCart.cartListItems
                                            .removeAt(
                                            index);
                                        //  ShoppingCart.cartListItems[index] = [] as CartListModel;
                                      });
                                    }
                                  }
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
              child:_progressPrice
                  ? Center(
                child: SpinKitPulse(
                  color: Colors.red,
                  size: 50.0,
                ),
              )

                  : Column(
//              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 1,
                    color: Colors.black12,
                  ),
                  verticalSpace(),
                  Text('Summary',
                    style: TextStyle(fontFamily: 'montserrat', fontSize: 16),
                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                      Text('Estimate Shipping & Tax',
//                          style: GoogleFonts.openSans(
//                            textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 14),
//                          )),
//                      IconButton(
//                          icon: Icon(
//                            Icons.keyboard_arrow_up,
//                            size: 30,
//                          ),
//                          onPressed: null),
//                    ],
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Expanded(
//                        child: Container(
//                          height: 35,
////                        width: 100,
//                          decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(1),
//                              border: Border.all(color: Colors.black12)),
//                          child: Center(
//                            child:Text('UAE',
//                              style: GoogleFonts.openSans(
//                                textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 14),
//
//                              ),
//                              textAlign: TextAlign.center,
//                            ) ,
//                          ),
//
////                          Center(
////                            child: TextField(
//////                          controller: controller,
////
////
////                              decoration: InputDecoration(
////                                  hintText: 'Country',
////                                  contentPadding: EdgeInsets.only(
////                                    left: 1,
////                                  ),
////                                  hintStyle: TextStyle( fontFamily: 'montserrat', fontSize: 12),
////                                  border: InputBorder.none,
////                                  suffixIcon: IconButton(
////                                      icon: Icon(
////                                        Icons.keyboard_arrow_down,
////                                        size: 15,
////                                      ),
////                                      onPressed: null)),
////                              textAlign: TextAlign.center,
////                            ),
////                          ),
//                        ),
//                      ),
//                      SizedBox(
//                        width: 5,
//                      ),
//                      Expanded(
//                        child: Container(
//                          height: 35,
////                        width: 100,
//                          decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(1),
//                              border: Border.all(color: Colors.black12)),
//                          child:  Center(
//                            child:Text('Ras al Khaimah',
//                              style: GoogleFonts.openSans(
//                                textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 14),
//
//                              ),
//                              textAlign: TextAlign.center,
//                            ) ,
//                          ),
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
//                        ),
//                      ),
//                      SizedBox(
//                        width: 5,
//                      ),
//                      Expanded(
//                        child: Container(
//                          height: 35,
////                        width: 100,
//                          decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(1),
//                              border: Border.all(color: Colors.black12)),
//                          child: Center(
//                            child: TextField(
////                          controller: controller,
//
//                              decoration: InputDecoration(
//                                hintText: 'Zip/Postal',
//                                contentPadding:
//                                    EdgeInsets.only(left: 1, bottom: 15),
//                                hintStyle: TextStyle( fontFamily: 'montserrat', fontSize: 12),
//                                border: InputBorder.none,
//                              ),
//                              textAlign: TextAlign.center,
//                            ),
//                          ),
//                        ),
//                      ),
//                      SizedBox(
//                        width: 5,
//                      ),
//                    ],
//                  ),
//                  Row(
//                    children: [
//                      Text(
//                        'Flat Rate: ',
//                        style: GoogleFonts.openSans(
//                            textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 14)),
//                      ),
//                      Radio(value: null, groupValue: null, onChanged: null),
//                      Text('Fixed AED 30',
//                          style: GoogleFonts.openSans(
//                              textStyle: TextStyle( fontFamily: 'montserrat', fontSize: 14))),
//                    ],
//                  ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Total',
                          style: TextStyle(
                              fontFamily: 'montserrat', fontSize: 14)),
                      Text(
                        'AED ' + ShoppingCart.subTotal.toString(),
                        style: TextStyle(
                            fontFamily: 'montserrat', fontSize: 16),

                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Shipping ',
                          style:
                          TextStyle(fontFamily: 'montserrat',
                            fontSize: 14,
                            color: Colors.black87,),
                          children: <TextSpan>[
                            TextSpan(
                                text: ShoppingCart.shippingPrice > 0 ? '(Delivery Charge - Fixed)' : "(Free Shipping - Free)",
                                style: TextStyle(fontFamily: 'montserrat',
                                    fontSize: 10, color: Colors.black54)),
                          ],
                        ),
                      ),
                      Text('AED ' + ShoppingCart.shippingPrice.toString(),
                        style: TextStyle(
                            fontFamily: 'montserrat', fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  controller: discountController,
                                  decoration: InputDecoration(
                                      hintText: "Enter Discount Code",
                                      hintStyle: TextStyle(
                                          fontFamily: 'montserrat',
                                          fontSize: 12),

                                      contentPadding: EdgeInsets.only(
                                          left: 10, bottom: 10)),
                                ),
                              ),
                              Container(
                                height: 40,
                                color: HexColor("302c98"),
                                child: FlatButton(
                                    onPressed:() {
                                      if(isloggedIn){
                                        applyCustomerDiscount();
                                      } else {
                                        applyGuestDiscount();
                                      }
                                    },
                                    child: Text(
                                      'APPLY',
                                      style: TextStyle(fontFamily: 'montserrat',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
//                      Text('- AED ' + amount.toString(),
//                        style: TextStyle(
//                            fontFamily: 'montserrat', fontSize: 16),
//                      ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Total',
                        style: TextStyle(
                            fontFamily: 'montserrat', fontSize: 16),
                      ),
                      Text(
                        'AED ' + ShoppingCart.grandTotal.toStringAsFixed(2),
                        style: TextStyle(fontFamily: 'montserrat',
                            fontSize: 16, fontWeight: FontWeight.bold),

                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
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
              Container(
                height: 40,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .9,
                decoration: BoxDecoration(
                    color: HexColor("302d98"),
                    borderRadius: BorderRadius.circular(2)),
                child: FlatButton(

                    onPressed: () {
                      if (HomePage.cartCount > 0) {
                        print(HomePageState.isLogin);
                        if (HomePageState.isLogin == true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
//                                            Products("1","1",2.0, "1","1"),
                                ReviewAndPayments("from Cart"),
                              ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
//                                            Products("1","1",2.0, "1","1"),
                                LogInPage(3),
                              ));
                        }
                      }
                    },
                    child: Text(
                      'PROCEED TO CHECKOUT',
                      style: TextStyle(fontFamily: 'montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    )),
              ),
//              SizedBox(
//                height: 5,
//              ),
//              Text(
//                'Check Out with Multiple Addresses',
//                style: TextStyle( fontFamily: 'montserrat', fontSize: 12),
//              )
            ],
          ),
        ),
      ),
    );
  }

  Future removeCartUserItem(int itemId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    var url = baseUrl + 'rest/V1/carts/mine/items/$itemId';
    var response = await http.delete(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: headerText
    });
    final responseJson = json.decode(response.body);
    print("cart delete response");
    totalCartUser();
    getUserCartList();
    print(responseJson);
  }

  Future removeCartGuestItem(int itemId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    var url =
        baseUrl + 'rest/V1/guest-carts/$token2/items/$itemId';
    print(Uri.parse(url));
    var response = await http.delete(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: headerText
    });
    final responseJson = json.decode(response.body);
    print("cart delete response");
    totalCartGuest();
    getGuestCartList();
    print(responseJson);
  }

  Future removeItemCartUser(int skuVAl, int qty) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    print(skuVAl);
    print(qty);
    Map data = {
      "cartItem": {"quote_id": quoteId, "item_id": skuVAl, "qty": qty}
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(
        baseUrl + 'rest/V1/carts/mine/items'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        },
        body: body);
    final responseJson = json.decode(response.body);
    print("cart logined user updated");
    print(responseJson);
    totalCartUser();
    getUserCartList();
    return response;
  }

  Future removeItemCartGuest(int skuVAl, int qty) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    print(headerText);
    print(skuVAl);
    print(qty);
    Map data = {
      "cartItem": {"quote_id": token2, "item_id": skuVAl, "qty": qty}
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(
        baseUrl + 'rest/V1/guest-carts/$token2/items'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        },
        body: body);
    final responseJson = json.decode(response.body);
    print("remove cart guest updated");
    print(responseJson);
    totalCartGuest();
//    totalCartUser();
    return response;
  }

  Future<bool> isLoggedIn() async {
    setState(() {
      ShoppingCart.total_model = null;
      ShoppingCart.productSku = null;
      ShoppingCart.imageUrls = [];
      ShoppingCart.cartListItems = [];
      ShoppingCart.subTotal = 0.0;
      ShoppingCart.shippingPrice = 0;
      ShoppingCart.grandTotal = 0.0;
      ShoppingCart.vat = 0;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint(prefs.getBool('isLoggedIn').toString());
    final loginStatus = prefs.getBool('isLoggedIn');
    if (loginStatus == true) {
      print("user is loged user.. in cart");
      await getUserCartList();
      await totalCartUser();
      setState(() {
        isloggedIn = true;
      });
    } else {
      print("user is guest user..  in cart");

      await getGuestCartList();
      await totalCartGuest();

      setState(() {
        isloggedIn = false;
        _progressPrice = true ;
      });
    }
//    return prefs.getBool('isLoggedIn');
//    await getUserCartList();
//      await totalCartUser();


  }

  Future totalCartUser() async {
    setState(() {
      _progressPrice = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    var response = await http
        .get(Uri.parse(baseUrl + 'rest/V1/carts/mine/totals'), headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: headerText
    });

    final responseJson = json.decode(response.body);
    print("cart total");
    print(responseJson);
    ShoppingCart.total_model = TotalModel.fromJson(responseJson);
    setState(() {
      _progressController = false;
      ShoppingCart.grandTotal = ShoppingCart.total_model.grandTotal;
      ShoppingCart.subTotal = ShoppingCart.total_model.subtotal;
      ShoppingCart.shippingPrice = ShoppingCart.total_model.shippingAmount;
      ShoppingCart.vat = ShoppingCart.total_model.taxAmount;
    });
    getUserShippingCost(token2);
  }
  Future getUserShippingCost(String userKey) async {
    Map data = {
      "address": {
        "country_id": "AE"
      }
    };
    var body = json.encode(data);
    String headerText = "Bearer " + userKey;
    var response = await http.post(Uri.parse(
        baseUrl + 'rest/V1/carts/mine/estimate-shipping-methods'),
        headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText}, body: body);

    final responseJson = json.decode(response.body);
    print(responseJson);
    print("user shipping....");

    int x =  responseJson[0]['amount'];
    ShoppingCart.carrierCode = responseJson[0]["carrier_code"];
    ShoppingCart.methodCode = responseJson[0]["method_code"];
    print(x);
    setState(() {
      ShoppingCart.shippingPrice = responseJson[0]['amount'];
      ShoppingCart.grandTotal = ShoppingCart.subTotal + ShoppingCart.shippingPrice ;
      _progressPrice = false ;
    });

  }

  Future totalCartGuest() async {
    setState(() {
      _progressPrice = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    print("guest Key");
    print(token2);
    String headerText = "Bearer " + token2;
    print(baseUrl + 'rest/V1/guest-carts/$token2/totals');
    var response = await http.get(Uri.parse(
        baseUrl + 'rest/V1/guest-carts/$token2/totals'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        });
    final responseJson = json.decode(response.body);
    print("guestcart total total_model.subtotal");
    print(responseJson);

    setState(() {
      ShoppingCart.total_model = TotalModel.fromJson(responseJson);
      _progressController = false;
      ShoppingCart.grandTotal = ShoppingCart.total_model.grandTotal;
      print(ShoppingCart.total_model.subtotal);
      ShoppingCart.subTotal = ShoppingCart.total_model.subtotal;
      ShoppingCart.vat = ShoppingCart.total_model.shippingAmount;
    });
    getGuestCartAddressId(token2);
  }

  Future getGuestCartAddressId(String guestKey) async {
    var response = await http.get(Uri.parse(
        baseUrl + 'rest/V1/guest-carts/$guestKey'),
        headers: {
          "Content-Type": "application/json"
        });
    final responseJson = json.decode(response.body);
    print(responseJson['id']);
    print("guestcart addessid");
    guestShippingCost(responseJson['id'], guestKey);
  }

  Future guestShippingCost(int addressId, String guestKey) async {
    Map data = {
      "address": {
        "id": addressId,
        "country_id": "AE"
      }
    };
    var body = json.encode(data);
    var url =   baseUrl + 'rest/V1/guest-carts/$guestKey/estimate-shipping-methods' ;
    print(Uri.parse(url));
    var response = await http.post(Uri.parse(
        baseUrl + 'rest/V1/guest-carts/$guestKey/estimate-shipping-methods'),
        headers: {"Content-Type": "application/json"}, body: body);

    final responseJson = json.decode(response.body);
    print(responseJson);
    print("guest shipping....");

    int x =  responseJson[0]['amount'];
    ShoppingCart.carrierCode = responseJson[0]["carrier_code"];
    ShoppingCart.methodCode = responseJson[0]["method_code"];
    print(x);
    setState(() {
      ShoppingCart.shippingPrice = responseJson[0]['amount'];
      ShoppingCart.grandTotal = ShoppingCart.subTotal + ShoppingCart.shippingPrice ;
      _progressPrice = false ;
    });

  }


  Future getUserCartList() async {
    print("inside cart list");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    print("user key");
    print(token2);
    final response = await http.get(Uri.parse(
      baseUrl + 'rest/V1/carts/mine/items'),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
    );
    final responseJson = json.decode(response.body);
    print(responseJson);
    var count = responseJson.length;
    setState(() {
      HomePage.cartCount = responseJson.length;
    });

    for (var i = 0; i < responseJson.length; i++) {
      setState(() {
        ShoppingCart.cartListItems.add(CartListModel.fromJson(responseJson[i]));
      });
      await getImageUrl(ShoppingCart.cartListItems[i].sku);
    }
  }
  Future applyCustomerDiscount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('adminKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    print(headerText);
    var code = discountController.text;
    print('http://aswaqrak.ae/rest/V1/carts/$quoteId/coupons/$code');
    final response = await http.put(Uri.parse(
      'http://aswaqrak.ae/rest/V1/carts/$quoteId/coupons/$code'),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
    );
    final responseJson = json.decode(response.body);
    print(responseJson);
    totalCartUser();

    print("user discount applied");
  }

  Future applyGuestDiscount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    var code = discountController.text;
    print(baseUrl + 'rest/V1/guest-carts/$token2/coupons/$code');
    final response = await http.put(Uri.parse(
      baseUrl + 'rest/V1/guest-carts/$token2/coupons/$code'),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
    );
    final responseJson = json.decode(response.body);
    print(responseJson);
    totalCartGuest();

    print("guest discount applied");
  }
  Future getGuestCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    print(baseUrl + 'rest/V1/guest-carts/$token2/items');
    print(token2);
    final response = await http.get(Uri.parse(
      baseUrl + 'rest/V1/guest-carts/$token2/items'),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
    );
    final responseJson = json.decode(response.body);
    print(responseJson);
    var count = responseJson.length;
    print("number of items in cart");
    print(count);
    setState(() {
      HomePage.cartCount = responseJson.length;
    });


    for (var i = 0; i < responseJson.length; i++) {
      print("inside for");
      setState(() {
        ShoppingCart.cartListItems.add(CartListModel.fromJson(responseJson[i]));
        getImageUrl(ShoppingCart.cartListItems[i].sku);
      });
    }
  }

  Future getImageUrl(String skuVAl) async {
    var url = baseUrl + 'rest/V1/products/$skuVAl';
    var response =
    await http.get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    final responseJson = json.decode(response.body);
    print("image response");
    print(responseJson);
    ShoppingCart.productSku = ProductBySku.fromJson(responseJson);

    for (var j = 0; j < ShoppingCart.productSku.customAttributes.length; j++) {
      if (ShoppingCart.productSku.customAttributes[j].attributeCode ==
          "image") {
        setState(() {
//          ShoppingCart.imageUrls.insert(j,  "https://aswaqrak.ae/pub/media/catalog/product"
//              "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
//                  ShoppingCart.productSku.customAttributes[j].value);
          ShoppingCart.imageUrls.add(
//              "https://aswaqrak.ae/pub/media/catalog/product"
              "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                  ShoppingCart.productSku.customAttributes[j].value);
        });
      }
    }
  }

  Future addCartUser(String skuVAl, int qty) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    print(skuVAl);
    print(qty);
    Map data = {
      "cartItem": {"quote_id": quoteId, "sku": skuVAl, "qty": qty}
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(
        baseUrl + 'rest/V1/carts/mine/items'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        },
        body: body);
    final responseJson = json.decode(response.body);
    print("cart logined user updated");
    print(responseJson);
    totalCartUser();
    return response;
  }

  Future addCartGuest(String skuVAl, int qty) async {
    print("sku val");
    print(skuVAl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    var url = baseUrl + 'rest/V1/guest-carts/$token2/items';
    print(Uri.parse(url));

    Map data = {
      "cartItem": {"quote_id": token2, "sku": skuVAl, "qty": qty}
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    final responseJson = json.decode(response.body);
    print("cart guest updated");
    print(responseJson);
    totalCartGuest();
    return response;
  }
}