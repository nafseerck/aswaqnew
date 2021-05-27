import 'dart:convert';
import 'dart:core';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:Alaswaq/Model/popular_model.dart';
import 'package:Alaswaq/Model/product_list_model.dart';
import 'package:Alaswaq/Model/stockstatusmodel.dart';
import 'package:Alaswaq/common/drawer.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input3.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input4.dart';
import 'package:Alaswaq/payment/shopping_cart.dart';
import 'package:Alaswaq/payment/thank_you.dart';
import 'package:Alaswaq/product/search/show_search_product_page.dart';
import 'package:Alaswaq/product/single_product/single_product.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Alaswaq/account/login/login_page.dart';

// ignore: must_be_immutable
class PopularProducts extends StatefulWidget {
  PopularModel popularproductList;
  int index;
  String sku;
  double price;
  String productType;
  String imageUrl;
  PopularProducts(this.popularproductList, this.index, this.sku, this.price,
      this.productType, this.imageUrl);

  PopularProductState createState() => PopularProductState();
}

class PopularProductState extends State<PopularProducts> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  static PopularModel popularproductList;
  String productName;
  String productImage;
  String packSize = "";
  List<String> packageSizeList;
  String productDesc = "";
  int availability = 1;
  String shortDesc = "";
  String temperature = "";
  static var isloggedIn = false;
  double price;

//   int price;
  var qty = [];
  int _selectedIndex = 0;
  var pressedIndex = 0;
  var pressed1 = true;
  var pressed2 = false;
  var pressed3 = false;
  var galleryIndex = 0;

  bool isPressedAboutProduct = true;
  bool isPressedDescription = true;
  bool isRatingPressed = true;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  _onPressed() {
    isPressedAboutProduct = !isPressedAboutProduct;
  }

  _onPressedDescription() {
    isPressedDescription = !isPressedDescription;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await isLoggedIn();
      await getAttributeValues();
      await getCartStatus();
      if (widget.productType == "configurable") {}
    });
  }

//  final CarouselController _controller = CarouselController();

//  Column slider(){
//    return Column(
//      children: <Widget>[
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            Flexible(
//              child: IconButton(
//                onPressed: () => _controller.previousPage(),
//              icon: Icon(Icons.arrow_back),
//              ),
//            ),
//            Container(
//              height: 150,
//              width: 200,
//              child: CarouselSlider(
//                items: imageSliders,
//                options: CarouselOptions(enlargeCenterPage: true, height: 70,),
//                carouselController: _controller,
//              ),
//            ),
//            Flexible(
//              child: IconButton(
//                onPressed: () => _controller.nextPage(),
//                icon: Icon(Icons.arrow_forward),
//              ),
//            ),
////            ...Iterable<int>.generate(imgList.length).map(
////                  (int pageIndex) => Flexible(
////                child: RaisedButton(
////                  onPressed: () => _controller.animateToPage(pageIndex),
////                  child: Text("$pageIndex"),
////                ),
////              ),
////            ),
//          ],
//        )
//      ],
//    );
//  }

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _key,
//      backgroundColor: Color(0xFFFAFAFA),
      backgroundColor: Colors.white,
//      resizeToAvoidBottomPadding: true,
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
            size: 40,
            color: Colors.black,
          ),
        ),
        title: Image.asset(
          'assets/images/logo.png',
          height: 30,
          width: 100,
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
                                style: new TextStyle(
                                    fontFamily: 'montserrat',
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

      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 300,
                color: Colors.white,
                child:
//                Hero(
//                  tag: 1,
//                  child: CachedNetworkImage(
//                    fit: BoxFit.cover,
//                    imageUrl: productImage,
//                    placeholder: (context, productImage) =>
//                        Center(child:  SpinKitPulse(
//                                              color: Colors.red,
//                                              size: 50.0,
//                                            ),),
//                    errorWidget: (context, url, error) => new Icon(Icons.error),
//                  ),
//                ),
                    Container(
                        decoration: BoxDecoration(
//                        color: HexColor("F9F9F9F9"),
//                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(widget.imageUrl),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: new Stack(
                          children: <Widget>[
//                            new Positioned(
//                              right: 15.0,
//                              top: 15.0,
//                              child: Image.asset('assets/images/icons/love.png',
//                                  height: 15.0),
//                            ),
//                            new Positioned(
//                              right: 42.0,
//                              top: 15.0,
//                              child: Image.asset(
//                                  'assets/images/icons/share.png',
//                                  height: 15.0),
//                            ),
//                            new Positioned(
//                              left: 15.0,
//                              top: 15.0,
//                              child: Image.asset(
//                                  'assets/images/icons/stock.png',
//                                  height: 15.0),
//                            ),
                          ],
                        )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: <Widget>[
//                    slider(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              "assets/images/icons/arrow_back.png",
                              width: 20,
                            )),
                        SizedBox(
                          width: 70,
                          height: 35,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: pressed1
                                        ? HexColor("302c98")
                                        : Colors.transparent,
                                    width: 0.5,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              setState(() {
                                galleryIndex = 0;
                                pressed1 = !pressed1;
                                pressed2 = false;
                                pressed3 = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl: widget.imageUrl,
                                    placeholder: (context, url) => Center(
                                      child: Image.asset(
                                        "assets/images/icons/loadingicon2.gif",
                                        height: 60.0,
                                        width: 60.0,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Image(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(widget.imageUrl),
                                    ),
                                  ),
                                ),
//                          ,
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          height: 35,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: pressed2
                                        ? HexColor("302c98")
                                        : Colors.transparent,
                                    width: 0.5,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              setState(() {
//                                if(widget.popularproductList.items[widget.index].mediaGalleryEntries.length >= 2 ){
//                                  galleryIndex = 1;
//                                } else {
//
//                                  galleryIndex = 0;
//                                }
                                pressed1 = false;
                                pressed2 = !pressed2;
                                pressed3 = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl: widget.imageUrl,
                                    placeholder: (context, url) => Center(
                                      child: Image.asset(
                                        "assets/images/icons/loadingicon2.gif",
                                        height: 60.0,
                                        width: 60.0,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Image(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(widget.imageUrl),
                                    ),
                                  ),
                                ),
//                          ,
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 70,
                          height: 35,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: pressed3
                                        ? HexColor("302c98")
                                        : Colors.transparent,
                                    width: 0.5,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(3)),
                            onPressed: () {
                              setState(() {
//                                if(widget.popularproductList.items[widget.index].mediaGalleryEntries.length >= 3 ){
//                                  galleryIndex = 2;
//                                } else {
//
//                                  galleryIndex = 0;
//                                }
                                pressed1 = false;
                                pressed2 = false;
                                pressed3 = !pressed3;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl: widget.imageUrl,
                                    placeholder: (context, url) => Center(
                                      child: Image.asset(
                                        "assets/images/icons/loadingicon2.gif",
                                        height: 60.0,
                                        width: 60.0,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Image(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(widget.imageUrl),
                                    ),
                                  ),
                                ),
//                          ,
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              "assets/images/icons/arrow_forward.png",
                              width: 20,
                            ))
                      ],
                    ),

                    verticalSpace(),

                    Container(
//                      color: HexColor("F9F9F9F9"),s
                      alignment: Alignment(-1.0, -1.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget
                                  .popularproductList.items[widget.index].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'msontserrat',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(-1.0, -1.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 0),
                        child: Text(
                          shortDesc,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
//                                child: Text(
//                                  'AED $price',
//                                  style: TextStyle( fontFamily: 'montserrat',
//                                    color: Theme.of(context).primaryColor,
//                                    fontSize: 16,
//                                    fontWeight: FontWeight.w600,
//                                  ),
//                                ),
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: 'AED ',
                                    style: TextStyle(
                                        fontFamily: 'montserrat',
                                        fontSize: 25,
                                        color: HexColor("302c98"),
                                        fontWeight: FontWeight.bold),

                                    /*defining default style is optional */
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: widget.price.toString(),
                                        style: TextStyle(
                                            fontFamily: 'montserrat',
                                            fontSize: 25,
                                            color: HexColor("302c98"),
                                            fontWeight: FontWeight.bold),
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                      alignment: Alignment(-1.0, -1.0),
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 0.0, top: 10),
                          //

                          child: Row(
                            children: [
                              Text(
                                'Availability: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'montserrat'),
                              ),
                              Text(
                                availability == 1 ? 'In Stock' : 'Not in Stock',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'montserrat'),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      alignment: Alignment(-1.0, -1.0),
                      child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                            top: 10,
                          ),
                          //

                          child: Row(
                            children: [
                              Text(
                                'SKU: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'montserrat'),
                              ),
                              Text(
                                widget
                                    .popularproductList.items[widget.index].sku,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'montserrat'),
                              ),
                            ],
                          )),
                    ),
                    Divider(
                      height: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    productDesc.isEmpty
                        ? Container(
                            alignment: Alignment(-1.0, -1.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 0.0, top: 10),
                              //

                              child: Text(
                                'Description',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'montserrat'),
                              ),
                            ),
                          )
                        : Container(),
                    Column(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
//                        Container(
//                            alignment: Alignment(-1.0, -1.0),
//                            child: Padding(
//                              padding:
//                                  const EdgeInsets.only(bottom: 0.0, top: 10),
//                              child: Text(
//                                'Pack Sizes',
//                                style: GoogleFonts.tajawal(
//                                  textStyle: TextStyle( fontFamily: 'montserrat',
//                                      fontSize: 18,
//                                      color: Colors.black,
//                                      fontWeight: FontWeight.bold),
//                                ),
//                              ),
//                            )),
//                        Container(
//                          padding: EdgeInsets.only(bottom: 10.0, top: 10),
//                          height: 60,
//                          child: ListView.builder(
//                            shrinkWrap: true,
//                            scrollDirection: Axis.horizontal,
//                            itemCount: packageSizeList.length,
//                            itemBuilder: (context, index) {
//                              return Builder(
//                                builder: (BuildContext context) {
//                                  return Container(
//                                    width: MediaQuery.of(context).size.width / 2  - 30,
//                                    height: 100.0,
//                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.spaceBetween,
//                                      children: <Widget>[
//                                        SizedBox(
//                                          height: 50,
//                                          child: FlatButton(
//                                            shape: RoundedRectangleBorder(
//                                              borderRadius:
//                                                  BorderRadius.circular(5.0),
//                                              side: BorderSide(
//                                                  color:
//                                                      _selectedIndex != null &&
//                                                              _selectedIndex ==
//                                                                  index
//                                                          ? HexColor("9ba905")
//                                                          : Colors.black54),
//                                            ),
//                                            color: Colors.transparent,
//                                            onPressed: () {
//                                              _onSelected(index);
//                                            },
//                                            padding: EdgeInsets.all(10.0),
//                                            child: Row(
//                                              mainAxisAlignment:
//                                                  MainAxisAlignment.center,
//                                              crossAxisAlignment:
//                                                  CrossAxisAlignment.center,
//                                              // Replace with a Row for horizontal icon + text
//                                              children: <Widget>[
//                                                Text(
//                                                  "1 KG:",
//                                                  style: TextStyle( fontFamily: 'montserrat',
//                                                      color: Colors.black,
//                                                      fontWeight:
//                                                          FontWeight.w400,
//                                                      fontSize: 12),
//                                                ),
//                                                SizedBox(
//                                                  width: 15,
//                                                ),
//                                                Text(
//                                                  "AED 70",
//                                                  style: TextStyle( fontFamily: 'montserrat',
//                                                      color: _selectedIndex !=
//                                                                  null &&
//                                                              _selectedIndex ==
//                                                                  index
//                                                          ? HexColor("2E275D")
//                                                          : Colors.black54,
//                                                      fontWeight:
//                                                          FontWeight.bold,
//                                                      fontSize: 12),
//                                                ),
//                                                SizedBox(
//                                                  width: 15,
//                                                ),
//                                                Icon(
//                                                  Icons.check_circle_outline,
//                                                  color:
//                                                      _selectedIndex != null &&
//                                                              _selectedIndex ==
//                                                                  index
//                                                          ? HexColor("9ba905")
//                                                          : Colors.black54,
//                                                ),
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  );
//                                },
//                              );
//                            },
//                          ),
//                        ),
//                        verticalSpace(),
                        Container(
//                          child: Text(
//                            'Description',
//
//                            style: GoogleFonts.tajawal(
//                              textStyle: TextStyle( fontFamily: 'montserrat',
//                                  fontSize: 18,
//                                  color: Colors.black87,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                            textAlign: TextAlign.left,
//                          ),
                            ),
                        verticalSpace(),
//                        Container(
//                          child: Text(
//                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                            style: TextStyle( fontFamily: 'montserrat',
//                              fontSize: 18,
//                            ),
//                          ),
//                        ),
                        productDesc.isEmpty
                            ? Container(
                                child: Text(
                                  productDesc,
                                  maxLines: 30,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'montserrat',
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              )
                            : Container(),
//                        verticalSpace(),
//                        Container(
//                          child: Text(
//                            'Storage & Uses',
//                            style: GoogleFonts.tajawal(
//                              textStyle: TextStyle( fontFamily: 'montserrat',
//                                  fontSize: 18,
//                                  color: Colors.black87,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                        ),
//                        verticalSpace(),
//                        Container(
//                          child: Text(
//                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                            style: GoogleFonts.tajawal(
//                              textStyle: TextStyle( fontFamily: 'montserrat',
//                                fontSize: 16,
//                                color: Colors.black87,
//                              ),
//                            ),
//                          ),
//                        ),
//                        verticalSpace(),
//                        Container(
//                          child: Text(
//                            'Veriable Weight Policy',
//                            style: GoogleFonts.tajawal(
//                              textStyle: TextStyle( fontFamily: 'montserrat',
//                                  fontSize: 18,
//                                  color: Colors.black87,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                        ),
//                        verticalSpace(),
//                        Container(
//                          child: Text(
//                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                            style: GoogleFonts.tajawal(
//                              textStyle: TextStyle( fontFamily: 'montserrat',
//                                fontSize: 16,
//                                color: Colors.black87,
//                              ),
//                            ),
//                          ),
//                        ),
//                        verticalSpace(),
//                        verticalSpace(),
//                        verticalSpace(),
                      ],
                    ),
                    Container(
                      alignment: Alignment(-1.0, -1.0),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 0.0, top: 10),
                        //

                        child: Text(
                          'YOU MAY ALSO LIKE',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'montserrat',
                          ),
                        ),
                      ),
                    ),

//                    listviewHeader(
//                      leftTitle: "YOU MAY ALSO LIKE",
//                      rightTitle: "See All",
//                      onTap: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => ShowSearchProductPage(
//                                  categoryId: 87, name: "Fruits & Vegetables")),
//                        );
//                      },
//                    ),

                    verticalSpace(),

                    Container(
//                      height: MediaQuery.of(context).size.height*.3,
                      height: 260,
//              height: 242,
//                      width: 100,

                      child: ListView.builder(
                        padding: const EdgeInsets.all(1),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.popularproductList.items.length,
//                        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                          crossAxisCount: 3,
////                  childAspectRatio: 16 / 20,
//                          childAspectRatio: 14/20,
//                          crossAxisSpacing: 1,
//                          mainAxisSpacing: 1,
//
//                        ),
                        itemBuilder: (context, index) {
//                          return Container(
//                            height: 50,
//                            width: 200,
//                            color: Colors.amber[colorCodes[index]],
//                            child:
//                                Center(child: Text('Entry ${entries[index]}')),
//                          );
                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
//                                            Products("1","1",2.0, "1","1"),
                                          PopularProducts(
                                              widget.popularproductList,
                                              index,
                                              widget.popularproductList
                                                  .items[index].sku,
                                              widget.popularproductList
                                                  .items[index].price,
                                              "normal",
                                              widget.imageUrl),
                                    ),
                                  );
                                },
                                child: Card(
//                                  color: Colors.white,
                                  color: Colors.white,
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 5,
//                                margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
//                                        Container(
//                                          height: 200,
//                                          width: 200,
//                                          child: CachedNetworkImage(
//                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
//                                                popularproductList
//                                                    .items[index]
//                                                    .mediaGalleryEntries[0]
//                                                    .file,
//                                            fit: BoxFit.fill,height: 100,
//                                            width: 200,
//                                          ),
//                                        ),
                                          Container(
//                                    width: 100,
                                            height: 100,
                                            child: CachedNetworkImage(
//                                          width: 200,
                                              width: 120,
                                              height: 100,
                                              fit: BoxFit.fill,
                                              imageUrl: widget.imageUrl,
                                              placeholder: (context, url) =>
                                                  Center(
                                                child: Image.asset(
                                                  "assets/images/icons/loadingicon2.gif",
                                                  height: 60.0,
                                                  width: 60.0,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                            ),
                                          ),
//                                        Container(
//                                          height: 200,
////                                            decoration: BoxDecoration(
////                                            ),
//                                          child: Image.network(
//                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475"
//                                                +
//                                                widget.popularproductList
//                                                    .items[index]
//                                                    .mediaGalleryEntries[0]
//                                                    .file,fit: BoxFit.fill,
//                                          ),
//                                        ),
//                                          Positioned(
//                                            top: 10.0,
//                                            left: 5.0,
//                                            child: Image.asset(
//                                              'assets/images/icons/save.png',
//                                              height: 15,
//                                              fit: BoxFit.cover,
//                                            ),
//                                          ),
//                                          Positioned(
//                                            top: 10.0,
//                                            right: 5.0,
//                                            child: Image.asset(
//                                              'assets/images/icons/love.png',
//                                              height: 15,
////                                        color: Colors.white,
//                                            ),
//                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'AED ' +
                                                widget.popularproductList
                                                    .items[index].price
                                                    .toString(),
                                            style: TextStyle(
                                                fontFamily: 'montserrat',
                                                fontSize: 14,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '/kg',
                                            style: TextStyle(
                                              fontFamily: 'montserrat',
                                              fontSize: 12,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
//                                    Padding(
//                                      padding: EdgeInsets.only(left: 10,right: 10),
//                                      child:
//                                    ),
//                                      Flexible(
//                                        child: Container(
//                                          width: 100,
//                                          padding: EdgeInsets.only(
//                                              left: 5,
//                                              right: 5,
//                                              top: 5,
//                                              bottom: 5),
//                                          child: Text(
//                                            widget.popularproductList.items[index].name
//                                                .toString()
//                                                .substring(0, 9),
//                                            textAlign: TextAlign.center,
//                                            overflow: TextOverflow.clip,
//                                          ),
//                                        ),
//                                      ),
                                      SizedBox(
                                        width: 160,
                                        height: 44,
                                        child: Text(
                                          widget.popularproductList.items[index]
                                              .name,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                        ),
//                                      ),
//                                    ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          padding: EdgeInsets.only(left: 5),
                                          height: 25.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .3,
                                          // fixed width and height
                                          child:
                                              NumberInputWithIncrementDecrement4(
                                            controller: TextEditingController(),
                                            initialValue: 1,
                                            min: 1,
                                            max: 100,
                                            onIncrement: (num newVal) {
                                              setState(() {
                                                qty[index] = newVal;
                                              });
                                            },
                                            onDecrement:
                                                (num newlyDecrementedValue) {
                                              setState(() {
                                                qty[index] =
                                                    newlyDecrementedValue;
                                              });
                                            },
                                            numberFieldDecoration:
                                                InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            decIconColor: Colors.orange,
                                            widgetContainerDecoration:
                                                BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(1)),
                                                    border: Border.all(
                                                      color: Colors.black26,
                                                      width: 1,
                                                    )),
                                            incIconDecoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                              ),
                                            ),
                                            separateIcons: false,
                                            decIconDecoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                              ),
                                            ),
                                            incIconSize: 15,
                                            decIconSize: 15,
                                            style: TextStyle(
                                                fontFamily: 'montserrat',
                                                fontSize: 15),
                                            incIcon: Icons.add,
                                            decIcon: Icons.remove,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 27,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .27,
                                        decoration: BoxDecoration(
//                                            color: Colors.lightGreen,
                                          borderRadius:
                                              BorderRadius.circular(1),
                                          border: Border.all(
                                              width: 1,
                                              color: HexColor("302c98")),
                                        ),
                                        child: FlatButton(
                                            onPressed: () async {
                                              if (!HomePageState.isLogin) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LogInPage(1)));
                                                // await addCartGuest(
                                                //     widget.popularproductList
                                                //         .items[index].sku,
                                                //     qty[index]);
//
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                              } else {
                                                await addCartUser(
                                                    widget.popularproductList
                                                        .items[index].sku,
                                                    qty[index]);
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                              }
//                                                    await addCartUser(popularproductList.items[index].sku);
//                                                    Navigator.push(
//                                                      context,
//                                                      MaterialPageRoute(builder: (context) => CartList()),
//                                                    );
                                            },
                                            child: Text(
                                              'Add to Cart',
                                              style: TextStyle(
                                                  fontFamily: 'montserrat',
                                                  color: HexColor("302c98"),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
//                    Container(
//                      height: 380,
////                      width: 100,
//                      color: Color(0xFFFAFAFA),
//
//                      child: ListView.builder(
//                        padding: const EdgeInsets.all(1),
//                        shrinkWrap: true,
//                        scrollDirection: Axis.horizontal,
//                        itemCount: widget.popularproductList.items.length,
//                        itemBuilder: (context, index) {
////                          return Container(
////                            height: 50,
////                            width: 200,
////                            color: Colors.amber[colorCodes[index]],
////                            child:
////                                Center(child: Text('Entry ${entries[index]}')),
////                          );
//                          return Row(
//                            children: [
//                              InkWell(
//                                onTap: () {
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) =>
////                                            Products("1","1",2.0, "1","1"),
//                                      Products(popularproductList, index,
//                                          popularproductList.items[0].sku),
//                                    ),
//                                  );
//                                },
//                                child: Card(
////                                color: Color(0xFFFAFAFA),
//                                  semanticContainer: true,
//                                  clipBehavior: Clip.antiAliasWithSaveLayer,
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(5.0),
//                                  ),
//                                  elevation: 5,
////                                margin: EdgeInsets.all(10),
//                                  child: Column(
//                                    children: [
//                                      Stack(
//                                        children: [
////                                        Container(
////                                          height: 200,
////                                          width: 200,
////                                          child: CachedNetworkImage(
////                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
////                                                popularproductList
////                                                    .items[index]
////                                                    .mediaGalleryEntries[0]
////                                                    .file,
////                                            fit: BoxFit.fill,height: 100,
////                                            width: 200,
////                                          ),
////                                        ),
//                                          Container(
//                                            width: 200,
//                                            child: CachedNetworkImage(
////                                          width: 200,
//                                              fit: BoxFit.fill,
//                                              imageUrl:
//                                              "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
//                                                  widget.popularproductList
//                                                      .items[index]
//                                                      .mediaGalleryEntries[0]
//                                                      .file,
//                                              placeholder: (context, url) => Center(
//                                                  child:
//                                                   SpinKitPulse(
//                                              color: Colors.red,
//                                              size: 50.0,
//                                            ),),
//                                              errorWidget:
//                                                  (context, url, error) =>
//                                              new Icon(Icons.error),
//                                            ),
//                                          ),
////                                        Container(
////                                          height: 200,
//////                                            decoration: BoxDecoration(
//////                                            ),
////                                          child: Image.network(
////                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475"
////                                                +
////                                                widget.popularproductList
////                                                    .items[index]
////                                                    .mediaGalleryEntries[0]
////                                                    .file,fit: BoxFit.fill,
////                                          ),
////                                        ),
//                                          Positioned(
//                                            top: 10.0,
//                                            left: 10.0,
//                                            child: Image.asset(
//                                              'assets/images/icons/save.png',
//                                              fit: BoxFit.cover,
//                                            ),
//                                          ),
//                                          Positioned(
//                                            top: 10.0,
//                                            right: 10.0,
//                                            child: Image.asset(
//                                              'assets/images/icons/love.png',
////                                        color: Colors.white,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                      SizedBox(
//                                        height: 5,
//                                      ),
//                                      Row(
//                                        children: [
//                                          Text(
//                                            'AED ' +
//                                                widget.popularproductList.items[index].price
//                                                    .toString(),
//                                            style: TextStyle( fontFamily: 'montserrat',
//                                                fontSize: 25,
//                                                color: Colors.black,
//                                                fontWeight: FontWeight.bold),
//                                          ),
//                                          Text('/kg'),
//                                        ],
//                                      ),
////                                    Padding(
////                                      padding: EdgeInsets.only(left: 10,right: 10),
////                                      child:
////                                    ),
//                                      Flexible(
//                                        child: Center(
//                                          child: Container(
//                                            width: 200,
//                                            padding: EdgeInsets.only(
//                                                left: 10, right: 10),
//                                            child: Text(
//                                              widget.popularproductList.items[index].name
//                                                  .toString(),
//                                              textAlign: TextAlign.center,
//                                              overflow: TextOverflow.clip,
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        height: 45.0,
//                                        width: MediaQuery.of(context).size.width *
//                                            .45,
//                                        // fixed width and height
//                                        child: NumberInputWithIncrementDecrement(
//                                          controller: TextEditingController(),
//                                          min: 0,
//                                          max: 100,
//                                          onIncrement: (num newVal) {
//                                            setState(() {
//                                              HomePageState.productqty[index] = newVal;
//                                            });
//                                          },
//                                          onDecrement:
//                                              (num newlyDecrementedValue) {
//                                            setState(() {
//                                              HomePageState.productqty[index] =
//                                                  newlyDecrementedValue;
//                                            });
//                                          },
//                                          numberFieldDecoration: InputDecoration(
//                                            border: InputBorder.none,
//                                          ),
//                                          widgetContainerDecoration:
//                                          BoxDecoration(
//                                              borderRadius: BorderRadius.all(
//                                                  Radius.circular(5)),
//                                              border: Border.all(
//                                                color: Colors.black26,
//                                                width: 1,
//                                              )),
//                                          incIconDecoration: BoxDecoration(
//                                            color: Colors.white,
//                                            borderRadius: BorderRadius.only(
//                                              bottomLeft: Radius.circular(0),
//                                            ),
//                                          ),
//                                          separateIcons: false,
//                                          decIconDecoration: BoxDecoration(
//                                            color: Colors.white,
//                                            borderRadius: BorderRadius.only(
//                                              topLeft: Radius.circular(0),
//                                            ),
//                                          ),
//                                          incIconSize: 30,
//                                          decIconSize: 30,
//                                          style: TextStyle( fontFamily: 'montserrat', fontSize: 20),
//                                          incIcon: Icons.add,
//                                          decIcon: Icons.remove,
//                                        ),
//                                      ),
////                                    SizedBox(
////                                      height: 5,
////                                    ),
//                                      Container(
//                                        height: 35,
//                                        width: MediaQuery.of(context).size.width *
//                                            .45,
//                                        decoration: BoxDecoration(
////                                            color: Colors.lightGreen,
//                                          borderRadius: BorderRadius.circular(5),
//                                          border: Border.all(
//                                              width: 1, color: Colors.green),
//                                        ),
//                                        child: FlatButton(
//                                            onPressed: () async {
//                                              if (!isloggedIn) {
//                                                await addCartGuest(
//                                                    widget.popularproductList.items[index].sku,
//                                                    HomePageState.productqty[index]);
////
////                                                      Navigator.push(
////                                                        context,
////                                                        MaterialPageRoute(builder: (context) => CartList()),
////                                                      );
//                                              } else {
//                                                await addCartUser(
//                                                    widget.popularproductList.items[index].sku,
//                                                    HomePageState.productqty[index]);
////                                                      Navigator.push(
////                                                        context,
////                                                        MaterialPageRoute(builder: (context) => CartList()),
////                                                      );
//                                              }
////                                                    await addCartUser(popularproductList.items[index].sku);
////                                                    Navigator.push(
////                                                      context,
////                                                      MaterialPageRoute(builder: (context) => CartList()),
////                                                    );
//                                            },
////
//                                            child: Text(
//                                              'Add to Cart',
//                                              style: TextStyle( fontFamily: 'montserrat',
//                                                  color: Colors.green,
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 15),
//                                            )),
//                                      ),
//                                      SizedBox(
//                                        height: 10,
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ],
//                          );
//                        },
//                      ),
//                    ),

//                    Container(
//                      padding:
//                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
//                      height: 270,
//                      child: ListView.builder(
//                        shrinkWrap: true,
//                        scrollDirection: Axis.horizontal,
//                        itemCount: widget.popularproductList.items.length,
//                        itemBuilder: (context, index) {
//                          return Builder(
//                            builder: (BuildContext context) {
//                              return Container(
//                                width: 200.0,
//                                height: 240.0,
//                                child: Card(
//                                  clipBehavior: Clip.antiAlias,
//                                  child: InkWell(
//                                    onTap: () {
//                                      print("clicked product");
//                                      Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                            builder: (context) => Products(
//                                                widget.popularproductList,
//                                                index,
//                                                widget.sku),
//                                          ),);
////
//                                    },
//                                    child: Column(
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        SizedBox(
//                                          height: 125,
//                                          child: Hero(
//                                            tag: Random().nextInt(1000),
//                                            child:
////                                        ClipRRect(
////                                          borderRadius: BorderRadius.circular(15.0),
////                                          child:
////                                          CachedNetworkImage(
////                                            fit: BoxFit.fill,
////
////                                            imageUrl: "https://aswaqrak.ae/pub/media/catalog/product" + popularproductList.items[index].mediaGalleryEntries[0].file,
////                                            placeholder: (context, url) => Center(
////                                                child: CircularProgressIndicator()
////                                            ),
////                                            errorWidget: (context, url, error) => Image(
////                                              fit: BoxFit.fill,
////                                              image: AssetImage('assets/images/banner-1.png'),
////                                            ),
////
////                                          ),
////                                        ),
//                                                Container(
//                                                    decoration: BoxDecoration(
//                                                      // color: const Color(0xff7c94b6),
//                                                      color: Colors.white,
//                                                      image: DecorationImage(
//                                                        image: NetworkImage(
//                                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
//                                                                widget
//                                                                    .popularproductList
//                                                                    .items[
//                                                                        index]
//                                                                    .mediaGalleryEntries[
//                                                                        0]
//                                                                    .file),
//                                                        fit: BoxFit.fill,
//                                                      ),
//                                                    ),
//                                                    child: new Stack(
//                                                      children: <Widget>[
//                                                        new Positioned(
//                                                          right: 15.0,
//                                                          top: 15.0,
//                                                          child: Image.asset(
//                                                              'assets/images/heart.png',
//                                                              height: 15.0),
//                                                        ),
//                                                        new Positioned(
//                                                          right: 42.0,
//                                                          top: 15.0,
//                                                          child: Image.asset(
//                                                              'assets/images/flag.png',
//                                                              height: 15.0),
//                                                        ),
//                                                        new Positioned(
//                                                          left: 15.0,
//                                                          top: 15.0,
//                                                          child: new Icon(
//                                                            Icons.star,
//                                                            color:
//                                                                Colors.orange,
//                                                            size: 15.0,
//                                                          ),
//                                                        ),
//                                                        new Positioned(
//                                                          left: 32.0,
//                                                          top: 16.0,
//                                                          child: new Text(
//                                                            '4.2',
//                                                            style:
//                                                                new TextStyle( fontFamily: 'montserrat',
//                                                              fontWeight:
//                                                                  FontWeight
//                                                                      .bold,
//                                                              fontSize: 12.0,
//                                                            ),
//                                                          ),
//                                                        ),
//                                                      ],
//                                                    )),
//                                          ),
//                                        ),
//
//                                        Padding(
//                                          padding: EdgeInsets.only(top: 0.0),
//                                          child: Align(
//                                              alignment: Alignment.center,
//                                              child: Flexible(
//                                                child: Text(
//                                                  widget.popularproductList
//                                                      .items[index].name,
//                                                  overflow:
//                                                      TextOverflow.ellipsis,
//                                                  textAlign: TextAlign.center,
//                                                  style: TextStyle( fontFamily: 'montserrat',
//                                                      color: Colors.black,
//                                                      fontWeight:
//                                                          FontWeight.w500,
//                                                      fontSize: 14),
//                                                ),
//                                              )),
//                                        ),
//                                        Padding(
//                                          padding: EdgeInsets.only(top: 0.0),
//                                          child: Align(
//                                            alignment: Alignment.center,
//                                            child: RichText(
//                                              overflow: TextOverflow.ellipsis,
//                                              text: TextSpan(
//                                                text: 'AED ',
//                                                style: TextStyle( fontFamily: 'montserrat',
//                                                    color: Colors.black,
//                                                    fontWeight: FontWeight.w500,
//                                                    fontSize: 14),
//                                                /*defining default style is optional */
//                                                children: <TextSpan>[
//                                                  TextSpan(
//                                                      text: widget.popularproductList
//                                                          .items[index].price
//                                                          .toString(),
//                                                      style: TextStyle( fontFamily: 'montserrat',
//                                                          fontWeight:
//                                                              FontWeight.bold,
//                                                          fontSize: 16)),
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//
////
//                                        Padding(
//                                          padding: EdgeInsets.only(top: 0.0),
//                                          child: Align(
//                                            alignment: Alignment.center,
//                                            child: RichText(
//                                              overflow: TextOverflow.ellipsis,
//                                              text: TextSpan(
//                                                text: 'Pieces: 12 pcs',
//                                                style: TextStyle( fontFamily: 'montserrat',
//                                                    color: Colors.grey,
//                                                    fontWeight: FontWeight.w400,
//                                                    fontSize: 11),
//                                                /*defining default style is optional */
//                                                children: <TextSpan>[
//                                                  TextSpan(
//                                                      text: ' | ',
//                                                      style: TextStyle( fontFamily: 'montserrat',
//                                                          fontWeight:
//                                                              FontWeight.bold,
//                                                          fontSize: 11)),
//                                                  TextSpan(
//                                                      text: 'Net wt: ' +
//                                                          widget
//                                                              .popularproductList
//                                                              .items[index]
//                                                              .weight
//                                                              .toString() +
//                                                          "gm",
//                                                      style: TextStyle( fontFamily: 'montserrat',
//                                                          color: Colors.grey,
//                                                          fontWeight:
//                                                              FontWeight.w400,
//                                                          fontSize: 11)),
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//
//                                        Padding(
//                                          padding: EdgeInsets.symmetric(
//                                              horizontal: 10),
//                                          child: Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.center,
//                                            crossAxisAlignment:
//                                                CrossAxisAlignment.center,
//                                            children: <Widget>[
//                                              Padding(
//                                                padding: EdgeInsets.only(
//                                                    top: 5.0, right: 0),
//                                                child: Column(
//                                                  children: <Widget>[
//                                                    SizedBox(
//                                                      height: 17,
//                                                    ),
//                                                    SizedBox(
//                                                      width: 75,
//                                                      child:
//                                                          NumberInputPrefabbed
//                                                              .squaredButtons(
//                                                        scaleHeight: 0.6,
//                                                        scaleWidth: 0.9,
//                                                        incDecBgColor:
//                                                            Colors.white,
//                                                        controller:
//                                                            TextEditingController(),
//                                                        min: 1,
//                                                        max: 50,
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//
//                                              Padding(
//                                                padding: EdgeInsets.only(
//                                                    top: 0.0, right: 0),
//                                                child: SizedBox(
//                                                  width: 90,
//                                                  child: RaisedButton(
//                                                      color: HexColor("649FC3"),
//                                                      child: Text('Add to cart',
//                                                          style: TextStyle( fontFamily: 'montserrat',
//                                                              color:
//                                                                  Colors.white,
//                                                              fontSize: 10.0)),
//                                                      onPressed: () async {
//                                                        if (isloggedIn) {
//                                                          print(
//                                                              "in logged.....");
//                                                          await addCartUser(
//                                                              widget
//                                                                  .popularproductList
//                                                                  .items[index]
//                                                                  .sku);
//                                                        } else {
//                                                          print(
//                                                              "in guest.....");
//
//                                                          addCartGuest(widget
//                                                              .popularproductList
//                                                              .items[index]
//                                                              .sku);
//                                                        }
////                                                      await addCartUser(widget.popularproductList.items[index].sku);
//                                                      }),
//                                                ),
//                                              ),
////
//                                            ],
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              );
//                            },
//                          );
//                        },
//                      ),
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) =>
////                                            Products("1","1",2.0, "1","1"),
//                            Products(
//                                widget.popularproductList,
//                                widget.index,
//                                widget.popularproductList
//                                    .items[0].sku
//                            ),
//                          ),
//                        );
//                      },
//                      child: Container(
//                        height: 380,
////                      width: 100,
//                        color: Color(0xFFFAFAFA),
//
//                        child: ListView.builder(
//                          padding: const EdgeInsets.all(1),
//                          shrinkWrap: true,
//                          scrollDirection: Axis.horizontal,
//                          itemCount: widget.popularproductList.items.length,
//                          itemBuilder: (context, index) {
////                          return Container(
////                            height: 50,
////                            width: 200,
////                            color: Colors.amber[colorCodes[index]],
////                            child:
////                                Center(child: Text('Entry ${entries[index]}')),
////                          );
//                            return Row(
//                              children: [
//                                Card(
////                                color: Color(0xFFFAFAFA),
//                                  semanticContainer: true,
//                                  clipBehavior: Clip.antiAliasWithSaveLayer,
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(5.0),
//                                  ),
//                                  elevation: 5,
////                                margin: EdgeInsets.all(10),
//                                  child: Column(
//                                    children: [
//                                      Stack(
//                                        children: [
//                                          Container(
//                                            height: 200,
//                                            child: Image.network(
//                                              "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
//                                                  widget
//                                                      .popularproductList
//                                                      .items[index]
//                                                      .mediaGalleryEntries[0]
//                                                      .file,
//                                              fit: BoxFit.fill,
//                                            ),
//                                          ),
////                                        Container(
////                                          height: 200,
//////                                            decoration: BoxDecoration(
//////                                            ),
////                                          child: Image.network(
////                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475"
////                                                +
////                                                widget.popularproductList
////                                                    .items[index]
////                                                    .mediaGalleryEntries[0]
////                                                    .file,fit: BoxFit.fill,
////                                          ),
////                                        ),
//                                          Positioned(
//                                            top: 10.0,
//                                            left: 10.0,
//                                            child: Image.asset(
//                                              'assets/images/icons/save.png',
//                                              fit: BoxFit.cover,
//                                            ),
//                                          ),
//                                          Positioned(
//                                            top: 10.0,
//                                            right: 10.0,
//                                            child: Image.asset(
//                                              'assets/images/icons/love.png',
////                                        color: Colors.white,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                      SizedBox(
//                                        height: 5,
//                                      ),
//                                      Row(
//                                        children: [
//                                          Text(
//                                            'AED ' +
//                                                widget.popularproductList.items[index]
//                                                    .price
//                                                    .toString(),
//                                            style: TextStyle( fontFamily: 'montserrat',
//                                                fontSize: 25,
//                                                color: Colors.black,
//                                                fontWeight: FontWeight.bold),
//                                          ),
//                                          Text('/kg'),
//                                        ],
//                                      ),
//                                      Padding(
//                                        padding: EdgeInsets.all(5),
//                                        child: Text(
//                                          widget.popularproductList.items[index].name
//                                              .trimRight(),
//                                          textAlign: TextAlign.center,
//                                          overflow: TextOverflow.ellipsis,
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        height: 10,
//                                      ),
//                                      SizedBox(
//                                        height: 45.0,
//                                        width: MediaQuery.of(context).size.width *
//                                            .45,
//                                        // fixed width and height
//                                        child: new Row(
//                                          children: <Widget>[
//                                            Expanded(
//                                              child: Container(
////                                                height:45.0,
////                                              width: 50,
//                                                  decoration: BoxDecoration(
//                                                      border: Border.all(
//                                                        color: HexColor("649FC3"),
//                                                      ),
//                                                      borderRadius:
//                                                          BorderRadius.all(
//                                                              Radius.circular(
//                                                                  5))),
////                                  color: Colors.black,
//                                                  child: new IconButton(
//                                                      icon:
//                                                          new Icon(Icons.remove),
//                                                      iconSize: 25,
//                                                      color: Colors.black,
//                                                      onPressed: () {
//                                                        if (qty > 1) {
//                                                          setState(() {
//                                                            qty = qty - 1;
//                                                          });
//                                                        }
//                                                      })),
//                                            ),
//                                            SizedBox(
//                                              width: 5,
//                                            ),
//                                            Expanded(
//                                              child: Container(
////                                            width: 50.0,
////                                              height: 45,
//                                                alignment: Alignment.center,
//                                                padding: const EdgeInsets.only(
//                                                    left: 5.0,
//                                                    right: 5,
//                                                    top: 3,
//                                                    bottom: 3),
//                                                child: new Text(
//                                                  qty.toString(),
//                                                  style: TextStyle( fontFamily: 'montserrat', fontSize: 20),
//                                                ),
//                                                decoration: BoxDecoration(
//                                                  border: Border(
//                                                    top: BorderSide(
//                                                        width: 1.0,
//                                                        color: Colors.black12),
//                                                    bottom: BorderSide(
//                                                        width: 1.0,
//                                                        color: Colors.black12),
//                                                    left: BorderSide(
//                                                        width: 1.0,
//                                                        color: Colors.black12),
//                                                    right: BorderSide(
//                                                        width: 1.0,
//                                                        color: Colors.black12),
//                                                  ),
//                                                  borderRadius: BorderRadius.all(
//                                                      Radius.circular(5)),
//                                                  color: Colors.white,
//                                                ),
//                                              ),
//                                            ),
//                                            SizedBox(
//                                              width: 5,
//                                            ),
//                                            Expanded(
//                                              child: Container(
////                                              width: 50.0,
////                                                height: 45,
//                                                  decoration: BoxDecoration(
//                                                      border: Border.all(
//                                                        color: HexColor("649FC3"),
//                                                      ),
//                                                      borderRadius:
//                                                          BorderRadius.all(
//                                                              Radius.circular(
//                                                                  5))),
//                                                  child: new IconButton(
//                                                    icon: new Icon(Icons.add),
//                                                    iconSize: 25,
//                                                    color: Colors.black,
//                                                    onPressed: () {
//                                                      setState(() {
//                                                        qty = qty + 1;
//                                                      });
////                                      addCartUser(item.sku, 1);
//                                                    },
//                                                  )),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        height: 5,
//                                      ),
//                                      GestureDetector(
//                                        onTap: () async {
//                                          if (isloggedIn) {
//                                            print("in logged.....");
//                                            await addCartUser(widget.sku);
//                                          } else {
//                                            print("in guest..with sku...");
//                                            print(widget.popularproductList
//                                                .items[widget.index].sku);
//
//                                            addCartGuest(widget.sku);
//                                          }
////                              await addCartUser(widget.sku);
//                                        },
//                                        child: Container(
//                                          height: 45,
//                                          width:
//                                              MediaQuery.of(context).size.width *
//                                                  .45,
//                                          decoration: BoxDecoration(
////                                            color: Colors.lightGreen,
//                                            borderRadius:
//                                                BorderRadius.circular(5),
//                                            border: Border.all(
//                                                width: 1, color: Colors.green),
//                                          ),
//                                          child: FlatButton(
//                                              onPressed: () {
//                                                Navigator.push(
//                                                    context,
//                                                    MaterialPageRoute(
//                                                        builder: (context) =>
//                                                            ThankYouPage()));
//                                              },
//                                              child: Text(
//                                                'Add to Cart',
//                                                style: TextStyle( fontFamily: 'montserrat',
//                                                    color: Colors.green,
//                                                    fontWeight: FontWeight.bold,
//                                                    fontSize: 15),
//                                              )),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            );
//                          },
//                        ),
//                      ),
//                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75))
        ], color: Colors.white),
        alignment: Alignment.center,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListView.builder(
                padding: const EdgeInsets.all(1),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(
                        height: 45.0,
                        width: MediaQuery.of(context).size.width * .45,
                        // fixed width and height
                        child: NumberInputWithIncrementDecrement3(
                          controller: TextEditingController(),
                          initialValue: 1,
                          min: 1,
                          max: 100,
                          onIncrement: (num newVal) {
                            setState(() {
                              qty[index] = newVal;
                            });
                          },
                          onDecrement: (num newlyDecrementedValue) {
                            setState(() {
                              qty[index] = newlyDecrementedValue;
                            });
                          },
                          numberFieldDecoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          widgetContainerDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              )),
                          incIconDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                            ),
                          ),
                          separateIcons: false,
                          decIconDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                            ),
                          ),
                          incIconSize: 30,
                          decIconSize: 30,
                          style:
                              TextStyle(fontFamily: 'montserrat', fontSize: 22),
                          incIcon: Icons.add,
                          incIconColor: HexColor("302c98"),
                          decIcon: Icons.remove,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * .5,
                        decoration: BoxDecoration(
                            color: HexColor("302c98"),
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                            onPressed: () async {
                              if (!isloggedIn) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogInPage(1)));
                                // await addCartGuest(
                                //     widget.sku, qty[widget.index]);
//
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                              } else {
                                await addCartUser(
                                    widget.sku, qty[widget.index]);
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                              }
//                                                    await addCartUser(popularproductList.items[index].sku);
//                                                    Navigator.push(
//                                                      context,
//                                                      MaterialPageRoute(builder: (context) => CartList()),
//                                                    );
                            },
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(
                                  fontFamily: 'montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getAttributeValues() async {
    for (var i = 0;
        i <
            widget
                .popularproductList.items[widget.index].customAttributes.length;
        i++) {
      if (widget.popularproductList.items[widget.index].customAttributes[i]
              .attributeCode ==
          "custom_label") {
        setState(() {
          shortDesc = widget
              .popularproductList.items[widget.index].customAttributes[i].value;
        });
      }
      if (widget.popularproductList.items[widget.index].customAttributes[i]
              .attributeCode ==
          "description") {
        setState(() {
          productDesc = widget
              .popularproductList.items[widget.index].customAttributes[i].value;
        });
      }
      if (widget.popularproductList.items[widget.index].customAttributes[i]
              .attributeCode ==
          "size") {
        setState(() {
          packSize = widget
              .popularproductList.items[widget.index].customAttributes[i].value;
          packageSizeList = packSize.split(",");
        });
      }
      if (widget.popularproductList.items[widget.index].customAttributes[i]
              .attributeCode ==
          "temperture_value") {
        setState(() {
          temperature = widget
              .popularproductList.items[widget.index].customAttributes[i].value;
        });
      }
    }
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint(prefs.getBool('isLoggedIn').toString());
    final loginStatus = prefs.getBool('isLoggedIn');
    print("logged staus");
    print(loginStatus);
    if (loginStatus == true) {
      print("logged user");
      setState(() {
        isloggedIn = true;
      });

      await getUserCartList();
    } else {
      setState(() {
        isloggedIn = false;
      });

      print("guest user");
      await getGuestCartList();
    }
    return prefs.getBool('isLoggedIn');
//    await getUserCartList();
  }

  Future addCartGuest(String skuVAl, int qty) async {
    _key.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.white,
      duration: new Duration(seconds: 2),
      content: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            "assets/images/icons/loadingicon2.gif",
            height: 60.0,
            width: 60.0,
          ),
          new Text(
            "Adding to cart..",
            style: TextStyle(
                fontFamily: 'montserrat',
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    ));
    print(" this nis sku val in main");
    print(skuVAl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    var url = baseUrl + 'rest/V1/guest-carts/$token2/items';
    print(url);

    Map data = {
      "cartItem": {"quote_id": token2, "sku": skuVAl, "qty": qty}
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("guest cart added");
    print(response);
    final responseJson = json.decode(response.body);
    print(responseJson);
    setState(() {
      getGuestCartList();
    });

    return response;
  }

  Future addCartUser(String skuVAl, int qty) async {
    _key.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.white,
      duration: new Duration(seconds: 2),
      content: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            "assets/images/icons/loadingicon2.gif",
            height: 60.0,
            width: 60.0,
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    print(skuVAl);
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
    print(responseJson);
    setState(() {
      getUserCartList();
    });
    return response;
  }

  Future getCartStatus() async {
    final sku = widget.sku;
    print(baseUrl + 'rest/V1/stockStatuses/$sku');
    final response = await http.get(Uri.parse(
      baseUrl + 'rest/V1/stockStatuses/$sku'),
      headers: {"Content-Type": "application/json"},
    );
    final responseJson = json.decode(response.body);
    StockStatusModel stockStatus = StockStatusModel.fromJson(responseJson);
    debugPrint('stock parsing');
    print(stockStatus.stockStatus);
    setState(() {
      availability = stockStatus.stockStatus;
    });
  }

  Future getGuestCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    print(baseUrl + 'rest/V1/guest-carts/$token2/items');
    final response = await http.get(Uri.parse(
      baseUrl + 'rest/V1/guest-carts/$token2/items'),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
    );
    final responseJson = json.decode(response.body);
    var count = responseJson.length;
    print("number of items in cart");
    print(count);
    setState(() {
      HomePage.cartCount = responseJson.length;
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
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
    );
    final responseJson = json.decode(response.body);
    var count = responseJson.length;
    print("cart count");
    print(count);
    setState(() {
      HomePage.cartCount = responseJson.length;
    });
//    totalUserCart();
  }

  Future totalGuestCartUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    var response = await http
        .get(Uri.parse(baseUrl + 'rest/V1/guest-carts/$token2/totals'), headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: headerText
    });
    final responseJson = json.decode(response.body);

    print(responseJson);
//      MainHome.cartListModel =  cartListModel.fromJson(responseJson);
  }

  Future totalUserCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    var response = await http.get(Uri.parse(baseUrl + 'rest/V1/carts/mine/totals'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        });
    final responseJson = json.decode(response.body);
    print("cart total");
    print(responseJson);
//    MainHome.cartListModel =  cartListModel.fromJson(responseJson);
  }
}
