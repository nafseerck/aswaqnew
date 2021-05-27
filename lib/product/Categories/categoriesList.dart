//import 'dart:convert';
//import 'dart:io';
//import 'package:Alaswaq/Model/category_model.dart';
//import 'package:Alaswaq/Model/product_list_model.dart';
//import 'package:Alaswaq/Network/api_repository.dart';
//import 'package:Alaswaq/common/drawer.dart';
//import 'package:Alaswaq/home/home_page_new.dart';
//import 'package:Alaswaq/packages/text_box/lib/product_box_input.dart';
//import 'package:Alaswaq/packages/text_box/lib/product_box_input4.dart';
//import 'package:Alaswaq/payment/shopping_cart.dart';
//import 'package:Alaswaq/product/filter/filters.dart';
//import 'package:Alaswaq/product/single_product/single_product.dart';
//import 'package:Alaswaq/utils/constants.dart';
//import 'package:Alaswaq/utils/style/color.dart';
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';
//
//class CategoryProductPage extends StatefulWidget {
//
//  @override
//  CategoryProductPageState createState() => CategoryProductPageState();
//}
//
//class CategoryProductPageState extends State<CategoryProductPage> {
//  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
//
//  static CategoryModel categoryList;
//  List<int> level1CatId = [];
//  List<int> level2CatId = [];
//  List<int> level3CatId = [];
//  List<String> catName = [];
//  List<String> catLevel2 = [];
//  List<String> catLevel3 = [];
//  List<String> imagePaths = ['assets/images/icons/cat1.png','assets/images/icons/cat2.png','assets/images/icons/cat3.png','assets/images/icons/cat4.png','assets/images/icons/cat5.png','assets/images/icons/cat6.png','assets/images/icons/cat7.png','assets/images/icons/cat8.png','assets/images/icons/cat9.png'];
//  static var categoryQty = [];
////  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//  int _selectedIndex = 0;
//  int pressedIndex = 0;
//  int level3Index = 0;
//int catId = 0;
//  var meatqty = [];
//  bool _progressController = true;
//  var isLogin = false;
//
//  _onSelected(int index) {
//    setState(() => _selectedIndex = index);
//  }
//  _onlevel3Selected(int index) {
//    setState(() => level3Index = index);
//  }
//
//  _onPressed(int index) {
//    setState(() => pressedIndex = index );
//  }
//
//  static  ProductListModel productList;
//
//  @override
//  void initState() {
//    super.initState();
//    SchedulerBinding.instance.addPostFrameCallback((_) async {
//     await  getCategoryList();
//     await getProductList(88);
//     await  isLoggedIn();
////
////      getProductList(
////          widget.categoryId);
//    });
//    // Setting the initial value for the field.
//  }
//
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    var size = MediaQuery.of(context).size;
//    final double itemHeight = (size.height) / 2;
//    final double itemWidth = size.width / 2;
//
//    return Scaffold(
//      backgroundColor: Colors.white,
//      key: _key,
//      drawer: AppDrawer(),
//      appBar: AppBar(
//        backgroundColor: Colors.white,
//        centerTitle: true,
//        automaticallyImplyLeading: true,
//        // hides leading widget
////        flexibleSpace: Container(),
////        leading: GestureDetector(
////          onTap: () {
////            Navigator.pop(context);
////          },
////          child: Icon(
////            Icons.keyboard_backspace,
////            color: Colors.black87,
////            size: 30,
////          ),
////        ),
//        title: Text(
//          'Search Products',
//          style: TextStyle( fontFamily: 'montserrat',
//              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
//        ),
//        actions: [
//          IconButton(
//            icon: Icon(
//              Icons.search,
//              size: 30,
//              color: Colors.blue,
//            ),
//            onPressed: null,
//          ),
//          Center(
//            child: GestureDetector(
//              onTap: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => ShoppingCart()));
//              },
////                    child: Image.asset(
////                      'assets/images/icons/cart.png',
////                      height: 35,
//////          height:10,
//////          width: 100,
////                    ),
//              child: new Stack(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.all(10.0),
//                    child: Image.asset(
//                      'assets/images/icons/cart.png',
//                      height: 25,
//                    ),
//                  ),
//                  HomePage.cartCount == 0
//                      ? new Container()
//                      : new Stack(
//                    children: <Widget>[
//                      new Icon(Icons.brightness_1,
//                          size: 22.0, color: Colors.redAccent),
//                      new Positioned(
//                        top: 3.0,
//                        right: 7.0,
//                        child: new Center(
//                          child: new Text(
//                            HomePage.cartCount.toString(),
//                            style: new TextStyle( fontFamily: 'montserrat',
//                                color: Colors.black,
//                                fontSize: 12.0,
//                                fontWeight: FontWeight.w500),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//      body: _progressController
//          ?  Center(
//        child:  SpinKitPulse(
//                                              color: Colors.red,
//                                              size: 50.0,
//                                            ),
//      )
//          :
//      SingleChildScrollView(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: [
//            Container(
//              padding: EdgeInsets.only(
//                  left: 16.0, top: 10.0), height: 120,
//              child: ListView.builder(
//                shrinkWrap: true,
//                scrollDirection: Axis.horizontal,
//                itemCount: imagePaths.length, itemBuilder: (context, index) {
//                return Builder(
//                  builder: (BuildContext context) {
//                    return Container(
//                      width: 115.0,
//                      height: 188.0,
//
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment
//                            .center,
//
//                        children: <Widget>[
//
//                          Column(
//                            mainAxisAlignment: MainAxisAlignment
//                                .center,
//                            children: [
//                             Center(
//                               child:  Card(
//                                 shape:  RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(5.0),
//                                   side: BorderSide(
//                                     color: pressedIndex != null &&
//                                         pressedIndex == index
//                                         ? HexColor("302c98")
//                                         : Colors.transparent,
//                                     width: 2.0,
//                                   ),
//                                 ),
//                                 elevation: 5,
//                                 clipBehavior: Clip.antiAlias,
////                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
//                                 child: Container(
//                                   height: 67,
//                                   width: MediaQuery.of(context).size.width / 4 - 30,
//                                   alignment: Alignment.center,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       _progressController = true ;
//                                       setState(() {
//                                         _onPressed(index);
//                                         catId = level1CatId[index];
//                                         getLevel2List(index + 3);
//                                         getProductList(categoryList.childrenData[index + 3].id);
//                                       });
//
//                                     },
//                                     //padding: EdgeInsets.all(10.0),
//                                     child: Image.asset(
//                                       imagePaths[index],
//                                       fit: BoxFit.contain,
//                                       height: 40,
//                                       width: 40,
////                              height: 50.0,
////                              color: pressed1 ? Colors.transparent : Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                              SizedBox(
//                                height: 5,
//                              ),
//                              Container(
//                                  width: 100.0,
//
//                                  child: Text(
//                                    catName[index],
//                                    maxLines: 2,
//
//                                    style: TextStyle( fontFamily: 'montserrat',
//
//                                      color: Colors.black,
//                                      fontWeight: FontWeight.w400,
//                                      fontSize: 12,
//                                    ),
//                                    textAlign: TextAlign.center,
//                                  ),
//                              )
//
//
//                            ],
//                          ),
//
//SizedBox(
//  width: 10,
//)
//                        ],
//                      ),
//
//                    );
//                  },
//                );
//              },
//              ),
//            ),
//            catLevel2.length > 0 ? Container(
//              padding: EdgeInsets.only(
//                  left: 16.0, top: 0.0),
//              height: 60,
//              child: ListView.builder(
////                              shrinkWrap: true,
//                scrollDirection: Axis.horizontal,
//                itemCount: catLevel2.length, itemBuilder: (context, index) {
//                return Builder(
//                  builder: (BuildContext context) {
//                    return Container(
//                      width: MediaQuery.of(context).size.width / 4 + 10,
//                      height: 50.0,
//
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment
//                            .spaceBetween,
//                        children: <Widget>[
//                          Card(
//                            shape:  RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(5.0),
//                              side: BorderSide(
//                                color: _selectedIndex != null &&
//                                    _selectedIndex == index
//                                    ? HexColor("302c98")
//                                    : Colors.transparent,
//                                width: 2.0,
//                              ),
//                            ),
//                            elevation: 5,
//                            clipBehavior: Clip.antiAlias,
////                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
//                            child: Container(
//                              height: 50,
//                              width: MediaQuery.of(context).size.width / 4 ,
//                              alignment: Alignment.center,
//                              child: GestureDetector(
//                                onTap: () async {
//                                  setState(() {
//                                    _onSelected(index);
//                                    catId = level2CatId[index];
//
//                                  });
//                                  await getLevel3List(pressedIndex + 3 , _selectedIndex);
//                                  await  getProductList(categoryList.childrenData[pressedIndex + 3].childrenData[_selectedIndex].id);
//
//                                },
//                                //padding: EdgeInsets.all(10.0),
//                                child: Text(catLevel2[index],
//                                  style: TextStyle( fontFamily: 'montserrat',
//
//                                    color: Colors.black,
//                                    fontWeight: FontWeight.w400,
//                                    fontSize: 11,
//
//                                  ),
//                                  textAlign: TextAlign.center,
//                              ),
//                            ),
//                          ),
//                          ),
//
//
//
//                        ],
//                      ),
//
//                    );
//                  },
//                );
//              },
//              ),
//            ) : Container(),
//            catLevel3.length > 0 ? Container(
//              padding: EdgeInsets.only(
//                  left: 16.0, top: 0.0),
//              height: 50,
//              child: ListView.builder(
////                              shrinkWrap: true,
//                scrollDirection: Axis.horizontal,
//                itemCount: catLevel3.length, itemBuilder: (context, index) {
//                return Builder(
//                  builder: (BuildContext context) {
//                    return Container(
////                      width: 100.0,
//                      height: 50.0,
//
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment
//                            .spaceBetween,
//                        children: <Widget>[
//                          Card(
//                            shape:  RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(5.0),
//                              side: BorderSide(
//                                color: level3Index != null &&
//                                    level3Index == index
//                                    ? HexColor("302c98")
//                                    : Colors.transparent,
//                                width: 2.0,
//                              ),
//                            ),
//                            elevation: 5,
//                            clipBehavior: Clip.antiAlias,
////                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
//                            child: Container(
//                              height: 50,
//                              width: MediaQuery.of(context).size.width / 4 ,
//                              alignment: Alignment.center,
//                              child: GestureDetector(
//
//                                onTap: () async {
//                                  setState(() {
//                                    catId = level3CatId[index];
//                                    _onlevel3Selected(index);
//
//                                  });
//                                  await  getProductList(categoryList.childrenData[pressedIndex + 3].childrenData[_selectedIndex].childrenData[index].id);
//
//
//                                },
//                                //padding: EdgeInsets.all(10.0),
//
//                                child: Text( catLevel3[index],
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle( fontFamily: 'montserrat',
//
//                                    color: Colors.black,
//                                    fontWeight: FontWeight.w400,
//                                    fontSize: 11,
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//
//
//
//                        ],
//                      ),
//
//                    );
//                  },
//                );
//              },
//              ),
//            ) : Container(),
//            productList != null ? Container(
//              height: 45,
//              color: Colors.white,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  Padding(
//                    padding: const EdgeInsets.only(left: 10),
//                    child: Text(productList.items.length.toString()+' Results Found',style: TextStyle( fontFamily: 'montserrat', fontSize: 12),),
//                  ),
//                  Row(
//                    children: [
//                      GestureDetector(
//                        onTap: () {
//                          _key.currentState
//                              .showBottomSheet((context) => Filters("From Category List", widget));
//                        },
//                        child: Image.asset(
//                          'assets/images/icons/icon.png',
//                          height: 20,
//                        ),
//                      ),
//                      SizedBox(
//                        width: 10,
//                      ),
//                      Image.asset(
//                        'assets/images/icons/icon2.png',
//                        height: 20,
//                      ),
//                      SizedBox(
//                        width: 10,
//                      ),
//                    ],
//                  )
//                ],
//              ),
//            ) : Container(),
//            productList != null  ?  Container(
//              height: productList.items.length == 1 ? 310 : 100 * productList.items.length.toDouble(),
////              height: 242,
////                      width: 100,
//
//
//              child: GridView.builder(
//                physics: NeverScrollableScrollPhysics(),
//                padding: const EdgeInsets.all(1),
//                shrinkWrap: true,
//                scrollDirection: Axis.vertical,
//                itemCount: productList.items.length,
//                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: 3,
////                  childAspectRatio: 16 / 20,
//                  childAspectRatio: 18/34,
////                  crossAxisSpacing: 1,
////                  mainAxisSpacing: 1,
//
//                ),
//                itemBuilder: (context, index) {
////                          return Container(
////                            height: 50,
////                            width: 200,
////                            color: Colors.amber[colorCodes[index]],
////                            child:
////                                Center(child: Text('Entry ${entries[index]}')),
////                          );
//                  return Row(
//                    children: [
//                      InkWell(
//                        onTap: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) =>
////                                            Products("1","1",2.0, "1","1"),
//                              Products(productList, index,
//                                  productList.items[index].sku, productList.items[index].price, "normal"),
//                            ),
//                          );
//                        },
//                        child: Card(
//                          color: Colors.white,
////                                color: Color(0xFFFAFAFA),
//                          semanticContainer: true,
//                          clipBehavior: Clip.antiAliasWithSaveLayer,
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(5.0),
//                          ),
//                          elevation: 5,
////                                margin: EdgeInsets.all(10),
//                          child: Column(
//                            children: [
//                              Stack(
//                                children: [
////                                        Container(
////                                          height: 200,
////                                          width: 200,
////                                          child: CachedNetworkImage(
////                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
////                                                productList
////                                                    .items[index]
////                                                    .mediaGalleryEntries[0]
////                                                    .file,
////                                            fit: BoxFit.fill,height: 100,
////                                            width: 200,
////                                          ),
////                                        ),
//                                  Container(
////                                    width: 100,
//                                    height: 100,
//                                    child: CachedNetworkImage(
////                                          width: 200,
//                                      width: 100,
//                                      height: 100,
//                                      fit: BoxFit.contain,
//                                      imageUrl:
//                                      "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
//                                          productList
//                                              .items[index]
//                                              .mediaGalleryEntries[0]
//                                              .file,
//                                      placeholder: (context, url) => Center(
//                                          child:
//                                           SpinKitPulse(
//                                              color: Colors.red,
//                                              size: 50.0,
//                                            ),),
//                                      errorWidget:
//                                          (context, url, error) =>
//                                      new Icon(Icons.error),
//                                    ),
//                                  ),
////                                        Container(
////                                          height: 200,
//////                                            decoration: BoxDecoration(
//////                                            ),
////                                          child: Image.network(
////                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475"
////                                                +
////                                                widget.productList
////                                                    .items[index]
////                                                    .mediaGalleryEntries[0]
////                                                    .file,fit: BoxFit.fill,
////                                          ),
////                                        ),
////                                  Positioned(
////                                    top: 10.0,
////                                    left: 5.0,
////                                    child: Image.asset(
////                                      'assets/images/icons/save.png',
////                                      height: 15,
////                                      fit: BoxFit.cover,
////                                    ),
////                                  ),
////                                  Positioned(
////                                    top: 10.0,
////                                    right: 5.0,
////                                    child: Image.asset(
////                                      'assets/images/icons/love.png',
////                                      height: 15,
//////                                        color: Colors.white,
////                                    ),
////                                  ),
//                                ],
//                              ),
//                              SizedBox(height: 2,),
//                              Row(
//                                children: [
//                                  Text(
//                                    'AED ' +
//                                        productList.items[index].price
//                                            .toString(),
//                                    style: GoogleFonts.openSans(
//                                      textStyle: TextStyle( fontFamily: 'montserrat',
//                                          fontSize: 14,
//                                          color: Colors.black87,
//                                          fontWeight: FontWeight.bold),
//                                    ),
//                                  ),
//                                  Text('/kg',style: GoogleFonts.openSans(
//                                    textStyle: TextStyle( fontFamily: 'montserrat',
//                                      fontSize: 12,
//                                      color: Colors.black87,
//                                    ),
//                                  ),),
//                                ],
//                              ),
////                                    Padding(
////                                      padding: EdgeInsets.only(left: 10,right: 10),
////                                      child:
////                                    ),
////                              Flexible(
////                                child: Container(
////                                  width: 100,
////                                  padding: EdgeInsets.only(
////                                      left: 5, right: 5,top: 5,bottom: 5),
////                                  child:
////                                  Text(
////                                    productList.items[index].name
////                                        .toString().substring(0,9),
////                                    textAlign: TextAlign.center,
////                                    overflow: TextOverflow.clip,
////                                  ),
////                                ),
////                              ),
//                              SizedBox(
//                                height: 44,
//                                width: MediaQuery.of(context).size.width / 3 - 20,
//                                child:  Text(
//                                  productList.items[index].name,
//                                  maxLines: 3,
//                                  textAlign: TextAlign.center,
//                                  overflow: TextOverflow.ellipsis,
//                                  style: TextStyle( fontFamily: 'montserrat',
//
//                                    color: Colors.black,
//                                    fontWeight: FontWeight.w400,
//                                    fontSize: 12,
//                                  ),
//                                ),
////                                      ),
////                                    ),
//                              ),
//                              Align(
//                                alignment: Alignment.center,
//                                child:  Container(
//                                  padding: EdgeInsets.only(left: 5),
//                                  height: 25.0,
//                                  width: MediaQuery.of(context).size.width *
//                                      .3,
//                                  // fixed width and height
//                                  child: NumberInputWithIncrementDecrement4(
//                                    controller: TextEditingController(),
//                                    min: 0,
//                                    max: 100,
//                                    onIncrement: (num newVal) {
//                                      setState(() {
//                                        HomePageState.productqty[index] = newVal;
//                                      });
//                                    },
//                                    onDecrement:
//                                        (num newlyDecrementedValue) {
//                                      setState(() {
//                                        HomePageState.productqty[index] =
//                                            newlyDecrementedValue;
//                                      });
//                                    },
//                                    numberFieldDecoration: InputDecoration(
//                                      border: InputBorder.none,
//                                    ),
//                                    decIconColor: Colors.orange,
//                                    widgetContainerDecoration:
//                                    BoxDecoration(
//                                        borderRadius: BorderRadius.all(
//                                            Radius.circular(1)),
//                                        border: Border.all(
//                                          color: Colors.black26,
//                                          width: 1,
//                                        )),
//                                    incIconDecoration: BoxDecoration(
//                                      color: Colors.white,
//                                      borderRadius: BorderRadius.only(
//                                        bottomLeft: Radius.circular(0),
//                                      ),
//                                    ),
//                                    separateIcons: false,
//                                    decIconDecoration: BoxDecoration(
//                                      color: Colors.white,
//                                      borderRadius: BorderRadius.only(
//                                        topLeft: Radius.circular(0),
//                                      ),
//                                    ),
//                                    incIconSize: 15,
//                                    decIconSize: 15,
//                                    style: TextStyle( fontFamily: 'montserrat', fontSize: 15),
//                                    incIcon: Icons.add,
//                                    decIcon: Icons.remove,
//                                  ),
//                                ),),
//                              SizedBox(
//                                height: 5,
//                              ),
//                              Container(
//                                height: 27,
//                                width: MediaQuery.of(context).size.width *
//                                    .27,
//                                decoration: BoxDecoration(
////                                            color: Colors.lightGreen,
//                                  borderRadius: BorderRadius.circular(1),
//                                  border: Border.all(
//                                      width: 1, color: HexColor('302c98')),
//                                ),
//                                child: FlatButton(
//                                    onPressed: () async {
//                                      if (!HomePageState.isLogin) {
//                                        await addCartGuest(
//                                            productList.items[index].sku,
//                                            HomePageState.productqty[index]);
////
////                                                      Navigator.push(
////                                                        context,
////                                                        MaterialPageRoute(builder: (context) => CartList()),
////                                                      );
//                                      } else {
//                                        await addCartUser(
//                                            productList.items[index].sku,
//                                            HomePageState.productqty[index]);
////                                                      Navigator.push(
////                                                        context,
////                                                        MaterialPageRoute(builder: (context) => CartList()),
////                                                      );
//                                      }
////                                                    await addCartUser(productList.items[index].sku);
////                                                    Navigator.push(
////                                                      context,
////                                                      MaterialPageRoute(builder: (context) => CartList()),
////                                                    );
//                                    },
//                                    child: Text(
//                                      'Add to Cart',
//                                      style: TextStyle( fontFamily: 'montserrat',
//                                          color: HexColor('302c98'),
////                                                fontWeight: FontWeight.bold,
//                                          fontSize: 8),
//                                    )),
//                              ),
//                              SizedBox(
//                                height: 10,
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ],
//                  );
//                },
//              ),
//            ): Container(),
//          ],
//        ),
//      ),
//    );
//  }
//
//  bool isloggedIn = false;
//
//
//
//  Future addCartGuest(String skuVAl, int qty) async {
//    print(" this nis sku val in main");
//    print(skuVAl);
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('guestKey');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    var url = baseUrl + 'rest/V1/guest-carts/$token2/items';
//    print(url);
//
//    Map data = { "cartItem": { "quote_id": token2, "sku": skuVAl, "qty": qty}};
//    //encode Map to JSON
//    var body = json.encode(data);
//    var response = await http.post(url,
//        headers: {"Content-Type": "application/json"},
//        body: body
//    );
//    print("guest cart added");
//    print(response);
//    final responseJson = json.decode(response.body);
//    print(responseJson);
//    setState(() {
//      getGuestCartList();
//    });
//
//    return response;
//  }
//
//  Future addCartUser(String skuVAl, int qty) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('userKey');
//    String quoteId = prefs.getString('userQuoteId');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//
//    Map data = { "cartItem": { "quote_id": quoteId, "sku": skuVAl, "qty": qty}};
//    //encode Map to JSON
//    var body = json.encode(data);
//
//    var response = await http.post(
//        baseUrl + 'rest/V1/carts/mine/items',
//        headers: {
//          "Content-Type": "application/json",
//          HttpHeaders.authorizationHeader: headerText
//        },
//        body: body
//    );
//    print("cart logined user added");
//
//    final responseJson = json.decode(response.body);
//    print(responseJson);
//    setState(() {
//      getUserCartList();
//    });
//    return response;
//  }
//
//  Future getUserCartList() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('userKey');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//    final response = await http.get(
//      baseUrl + 'rest/V1/carts/mine/items',
//      headers: {
//        "Content-Type": "application/json",
//        HttpHeaders.authorizationHeader: headerText
//      },
//    );
//    final responseJson = json.decode(response.body);
//    var count = responseJson.length;
//    setState(() {
//      HomePage.cartCount = responseJson.length;
//    });
//  }
//
//  Future getGuestCartList() async {
//
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('guestKey');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//    final response = await http.get(
//      baseUrlguest-carts/$token2/items',
//      headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText},
//    );
//    final responseJson = json.decode(response.body);
//    setState(() {
//      HomePage.cartCount =  responseJson.length;
//    });
//
//  }
//
//  Future<bool> isLoggedIn() async {
//
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//    debugPrint(prefs.getBool('isLoggedIn').toString());
//    final  loginStatus =   prefs.getBool('isLoggedIn');
//    if(loginStatus == true) {
//      print("for  listen user key  user");
////      await listenForUserKey();
////      await addCartUserQuote();
////      await getUserCartList();
////      await getUserInfo();
//      isLogin = true;
//      HomePageState.isLogin = true;
//    } else {
//      print("for  listen guest user");
////      await  listenForGuestKey();
////      await getGuestCartList();
//      HomePageState.isLogin = false;
//    }
//    return prefs.getBool('isLoggedIn');
//  }
//
////  Future<bool> isLoggedIn() async {
////    final SharedPreferences prefs = await SharedPreferences.getInstance();
////    debugPrint(prefs.getBool('isLoggedIn').toString());
////    final loginStatus = prefs.getBool('isLoggedIn');
////    print("logged staus");
////    print(loginStatus);
////    if (loginStatus == true) {
////      print("logged user");
////      setState(() {
////        isloggedIn = true;
////      });
////
////      await getUserCartList();
////    } else {
////      setState(() {
////        isloggedIn = false;
////      });
////
////      print("guest user");
////      await getGuestCartList();
////    }
////    return prefs.getBool('isLoggedIn');
//////    await getUserCartList();
////  }
//
////  Future addCartGuest(String skuVAl, int qty) async {
////    _key.currentState.showSnackBar(new SnackBar(
////      duration: new Duration(seconds: 2),
////      content: new Row(
////        children: <Widget>[
////          new  SpinKitPulse(
////                                              color: Colors.red,
////                                              size: 50.0,
////                                            ),,
////          new Text("Adding to cart..")
////        ],
////      ),
////    ));
////    print(" this nis sku val in main");
////    print(qty);
////    SharedPreferences prefs = await SharedPreferences.getInstance();
////    String token = prefs.getString('guestKey');
////    String token1 = token.replaceFirst(RegExp('"'), '');
////    String token2 = token1.replaceFirst(RegExp('"'), '');
////    var url = baseUrl + 'rest/V1/guest-carts/$token2/items';
////    print(url);
////
////    Map data = {
////      "cartItem": {"quote_id": token2, "sku": skuVAl, "qty": qty}
////    };
////    //encode Map to JSON
////    var body = json.encode(data);
////    var response = await http.post(url,
////        headers: {"Content-Type": "application/json"}, body: body);
////    print("guest cart added");
////    print(response);
////    final responseJson = json.decode(response.body);
////    print(responseJson);
////    setState(() {
////      getGuestCartList();
////    });
////
////    return response;
////  }
////
////  Future addCartUser(String skuVAl, int qty) async {
////    _key.currentState.showSnackBar(new SnackBar(
////      duration: new Duration(seconds: 2),
////      content: new Row(
////        children: <Widget>[
////          new  SpinKitPulse(
////                                              color: Colors.red,
////                                              size: 50.0,
////                                            ),,
////          new Text("Adding to cart..")
////        ],
////      ),
////    ));
////    SharedPreferences prefs = await SharedPreferences.getInstance();
////    String token = prefs.getString('userKey');
////    String quoteId = prefs.getString('userQuoteId');
////    String token1 = token.replaceFirst(RegExp('"'), '');
////    String token2 = token1.replaceFirst(RegExp('"'), '');
////    String headerText = "Bearer " + token2;
////
////    Map data = {
////      "cartItem": {"quote_id": quoteId, "sku": skuVAl, "qty": qty}
////    };
////    //encode Map to JSON
////    var body = json.encode(data);
////
////    var response = await http.post(
////        baseUrl + 'rest/V1/carts/mine/items',
////        headers: {
////          "Content-Type": "application/json",
////          HttpHeaders.authorizationHeader: headerText
////        },
////        body: body);
////    print("cart logined user added");
////
////    final responseJson = json.decode(response.body);
////    print(responseJson);
////    setState(() {
////      getUserCartList();
////    });
////    return response;
////  }
////
////  Future getGuestCartList() async {
////    SharedPreferences prefs = await SharedPreferences.getInstance();
////    String token = prefs.getString('guestKey');
////    String token1 = token.replaceFirst(RegExp('"'), '');
////    String token2 = token1.replaceFirst(RegExp('"'), '');
////    String headerText = "Bearer " + token2;
////    print(baseUrl + 'rest/V1/guest-carts/$token2/items');
////    final response = await http.get(
////      baseUrl + 'rest/V1/guest-carts/$token2/items',
////      headers: {
////        "Content-Type": "application/json",
////        HttpHeaders.authorizationHeader: headerText
////      },
////    );
////    final responseJson = json.decode(response.body);
////    var count = responseJson.length;
////    print("number of items in cart");
////    print(count);
////    setState(() {
////      HomePage.cartCount = responseJson.length;
////    });
////  }
////
////  Future getUserCartList() async {
////    SharedPreferences prefs = await SharedPreferences.getInstance();
////    String token = prefs.getString('userKey');
////    String token1 = token.replaceFirst(RegExp('"'), '');
////    String token2 = token1.replaceFirst(RegExp('"'), '');
////    String headerText = "Bearer " + token2;
////    final response = await http.get(
////      baseUrl + 'rest/V1/carts/mine/items',
////      headers: {
////        "Content-Type": "application/json",
////        HttpHeaders.authorizationHeader: headerText
////      },
////    );
////    final responseJson = json.decode(response.body);
////    var count = responseJson.length;
////    print("cart count");
////    print(count);
////    setState(() {
////      HomePage.cartCount = responseJson.length;
////    });
//////    totalUserCart();
////  }
//
//  Future totalGuestCartUser() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('guestKey');
//    String quoteId = prefs.getString('userQuoteId');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//    var response = await http.get(
//        baseUrl + 'rest/V1/guest-carts/$token2/totals',
//        headers: {
//          "Content-Type": "application/json",
//          HttpHeaders.authorizationHeader: headerText
//        });
//    final responseJson = json.decode(response.body);
//
//    print(responseJson);
////      HomePage.cartListModel =  cartListModel.fromJson(responseJson);
//  }
//
//  Future totalUserCart() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('guestKey');
//    String quoteId = prefs.getString('userQuoteId');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//    var response = await http
//        .get(baseUrl + 'rest/V1/carts/mine/totals', headers: {
//      "Content-Type": "application/json",
//      HttpHeaders.authorizationHeader: headerText
//    });
//    final responseJson = json.decode(response.body);
//    print("cart total");
//    print(responseJson);
////    HomePage.cartListModel =  cartListModel.fromJson(responseJson);
//  }
//
//  Future getCategoryList() async {
//    ApiRepository.loadCategoryList().then((userDataFromServer) {
//      if (userDataFromServer != null) {
//        _progressController = false;
//        setState(() {
//          categoryList = userDataFromServer;
//          for (var i = 0; i < categoryList.childrenData.length; i++) {
//            if( categoryList.childrenData[i].name != "On Sale" && categoryList.childrenData[i].name != "Featured"&& categoryList.childrenData[i].name != "All Products") {
//              setState(() {
//                catName.add(categoryList.childrenData[i].name)  ;
//                level1CatId.add(categoryList.childrenData[i].id);
//              });
//
//            }
//          }
//
//        });
//        getLevel2List(3);
//        getLevel3List(3, 0);
//      } else {
//        print("Somithing went wrong...!");
//      }
//    });
//  }
//
//  Future getLevel2List(int index) async {
//setState(() {
//  catLevel2 = [];
//  catLevel3 = [];
//});
//
//    for (var i = 0; i < categoryList.childrenData[index].childrenData.length; i++) {
//
//        setState(() {
//          catLevel2.add(categoryList.childrenData[index].childrenData[i].name)  ;
//          level2CatId.add(categoryList.childrenData[index].childrenData[i].id);
//        });
//
//
//    }
//  }
//  Future getLevel3List(int index1, int index2) async {
//    print(index1);
//    print(index2);
//    setState(() {
//      catLevel3 = [];
//    });
//    for (var i = 0; i < categoryList.childrenData[index1].childrenData[index2].childrenData.length; i++) {
//    setState(() {
//          catLevel3.add(categoryList.childrenData[index1].childrenData[index2].childrenData[i].name)  ;
//          level3CatId.add(categoryList.childrenData[index1].childrenData[index2].childrenData[i].id);
//        });
//
//
//    }
//    for (var i = 0; i < categoryList.childrenData[index1].childrenData[index2].childrenData.length; i++) {
//      print(level3CatId[i]);
//    }
//  }
//  Future<ProductListModel> getProductList (int id) async {
//    print(id);
//    var url =baseUrl + 'rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id& searchCriteria[filter_groups][0][filters][0][value]=$id';
//    print(url);
//    try {
//      var response = await http.get(url,
//        headers: {"Content-Type": "application/json"},
//      );
//      _progressController = false;
//      if (response.statusCode == 200) {
//        final responseJson = json.decode(response.body);
//        print("product listing response");
//
//        setState(() {
//          productList =   ProductListModel.fromJson(responseJson);
//        });
//
//
//        debugPrint('after parsing');
//        return productList;
//      } else
//      {
//        debugPrint('list ERROR');
//        return null;
//        throw Exception("Error");
//      }
//    } catch (e) {
//      throw Exception(e.toString());
//    }
//  }
//
//}
