import 'dart:convert';
import 'dart:io';
import 'package:Alaswaq/Model/cart_list_model.dart';
import 'package:Alaswaq/Model/category_model.dart';
import 'package:Alaswaq/Model/popular_model.dart' as popular;
import 'package:Alaswaq/Model/price_model.dart';
import 'package:Alaswaq/Model/product_list_model.dart';
import 'package:Alaswaq/Model/register_model.dart';
import 'package:Alaswaq/Network/api_repository.dart';
import 'package:Alaswaq/account/login/login_page.dart';
import 'package:Alaswaq/common/drawer.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/dashboard.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input2.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input4.dart';
import 'package:Alaswaq/payment/shopping_cart.dart';
import 'package:Alaswaq/product/search/price_search.dart';
import 'package:Alaswaq/product/search/search_from_home.dart';
import 'package:Alaswaq/product/search/search_home_cat_buttons.dart';
import 'package:Alaswaq/product/search/showAllBestDeals.dart';
import 'package:Alaswaq/product/search/show_search_product_page.dart';
import 'package:Alaswaq/product/single_product/popular_single_product.dart';
import 'package:Alaswaq/product/single_product/single_product.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:html/parser.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

class HomePage extends StatefulWidget {
  static CartListModel cartListModel;

  static var cartCount = 0;

  static List<Address> addressValue;
  static var isGuestManagement = false;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  List<String> productCategories = [
    'assets/images/icons/fruits.png',
    'assets/images/icons/vegetables.png',
    'assets/images/icons/seafood.png',
    'assets/images/icons/meat.png',
    'assets/images/icons/bakery.png',
    'assets/images/icons/dairy.png',
    'assets/images/icons/drinks.png',
    'assets/images/icons/chicken.png',
  ];

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  TextEditingController controller;
  static CategoryModel categoryList;
  int categoryIndex = 0;

  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController editingController = TextEditingController();
//  static var isLogin = false;
  static var isLogin = false;
  List<Item> productList = [];
  ProductListModel bestDealList;
  ProductListModel popularList;
  ProductListModel popularhealthList;
  ProductListModel babycareList;
  ProductListModel groceryList;
  ProductListModel householdList;
  ProductListModel frozenList;
  ProductListModel beveragesList;
  var popularListImage = [];
  var babycareListImage = [];
  var groceryListImage = [];
  var householdListImage = [];
  var frozenListImage = [];
  var beveragesListImage = [];
  var popularhealthListImage = [];
  var bestSellingListImage = [];
  var productqty = [];
  var productPrice = [];
  var specialPrice = [];
//  static var allOptionPrice = [];
  var productSku = [];
//  static var allProductSku = [];
  var productType = [];
  var popularqty = [];
  var popularhealthqty = [];
  var babycareqty = [];
  var groceryqty = [];
  var householdqty = [];
  var frozenqty = [];
  var beveragesqty = [];
  var popularPrice = [];
  var babycarePrice = [];
  var groceryPrice = [];
  var householdPrice = [];
  var frozenPrice = [];
  var beveragesPrice = [];
  var popularSku = [];
  var popularType = [];
  var bestSellingqty = [];

  var freshProductQty = [];
  var healthProductQty = [];
  var hotProductQty = [];
  ProductListModel bestSellingList;
  ProductListModel topSellingList;
  ProductListModel topFreshList;
  ProductListModel topHealthList;
  static var userName = "";
  var subTotal = 0.0;
  var grandTotal = 0.0;
  var vat = 0;
  var bannerCount = 1;
  var isnetworkAvailable = false;
  List<String> bannetList = [];
  List<String> categoryBannerList = [];
  List<String> categoryBannerList1 = [];
  List<String> categoryBannerList2 = [];
  List<String> categoryBannerList3 = [];
  List<String> categoryBannerList4 = [];
  List<String> offerBannerList = [];
  List<String> add1BannerList = [];
  List<String> add2BannerList = [];
  var bannerUrl1 = baseUrl + "pub/media/";
  var bannerUrl2 = baseUrl + "pub/media/";
  var bannerUrl3 = baseUrl + "pub/media/";
  var bannerUrl4 = baseUrl + "pub/media/";
  var bannerUrl5 = baseUrl + "pub/media/";
  var bannerUrl6 = baseUrl + "pub/media/";
  var bannerUrl7 = baseUrl + "pub/media/";
  var bannerUrl8 = baseUrl + "pub/media/";
  var pressed1 = true;

  var pressed2 = false;

  var pressed3 = false;

  var pressed4 = false;

  var pressed5 = false;

  var pressed6 = false;

  var pressed7 = false;

  var pressed8 = false;
  List<Widget> imageSliders = [];
  bool _progressController = true;
  var qty = 1;
  var searchName;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    searchController.text = searchName;
    bannetList = [];
//    numberController.text = "1";
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {
          _progressController = false;
          isnetworkAvailable = false;
        });
        print("no internet");
      } else {
        setState(() {
          isnetworkAvailable = true;
        });
        isLoggedIn();
        loadBanner();
        loadCoupenBanner();
        loadCategoryBanner();
        loadCategoryBanner1();
        loadCategoryBanner2();
        loadCategoryBanner3();
        loadCategoryBanner4();
//    freshFoodBanner();
        getProductList();
//
        getBestSellingList();
        getHotSellingList();
        //getFreshFruitsList();
        listenForAdminKey();
        getHealthcareProduct();
        getBabycareProduct();
        getGroceryProduct();
        getHouseholdProduct();
        getFrozenProduct();
        getBeveragesProduct();
        getFreshProduct();
        getBestDealList();
      }
    });
  }

  @override
  dispose() {
    super.dispose();
//    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: AppColor.whiteColor,
      backgroundColor: Colors.white,
      key: _key,
      drawer: AppDrawer(),
      appBar: AppBar(
//          toolbarHeight: 30,
        elevation: 0,
        backgroundColor: AppColor.brandColor,
        centerTitle: true,
        leading: Builder(
          builder: (context) => GestureDetector(
            //onTap: () => _key.currentState.openDrawer(),
//            child: Icon(
//              Icons.dehaze,
//              color: Colors.black87,
//              size: 40,
//            ),

            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 0),
              child: new Image.asset(
                'assets/images/logo.png',
              ),
            ),
//            child: Container(
//              height: 10,
//              width: 100,
//              child: Image.asset(
//                'assets/images/icons/drawer.png',
//              ),
//            ),
          ),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchFromHome(name: editingController.text)),
                );
              },
              controller: editingController,

              decoration: new InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 20.0, top: 0.0, bottom: 20.0),
//                              labelText: "Search your products",
//                              labelStyle: TextStyle(
//                                  color:  Colors.black
//                              ),
                suffixIcon: IconButton(
                  onPressed: () {
                    print("search");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchFromHome(name: editingController.text)),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: HexColor("A3A3A3"),
                    size: 25,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: HexColor("A3A3A3"), width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: HexColor("A3A3A3"), width: 0.5),
                ),
                hintText: "What are you looking for?",
              ),
              style: TextStyle(
                  fontSize: 13, fontFamily: 'lato' // This is not so important
                  ),
//
            ),
          ),
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
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Image.asset(
                    'assets/images/icons/cart.png',
                    height: 35,
                  ),
                ),
                HomePage.cartCount == 0 || HomePage.cartCount == null
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

      body: isnetworkAvailable
          ? _progressController
              ? Center(
                  child: Image.asset(
                  "assets/images/icons/loadingicon2.gif",
                  height: 60.0,
                  width: 60.0,
                ))
              : SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
//        Padding(
//        padding: const EdgeInsets.only(
//            top: 10, left: 0, right: 0, bottom: 0),
//        child:
//            CarouselSlider(
//              options: CarouselOptions(
//                height: 230,
//                viewportFraction: 1.0,
//                enlargeCenterPage: false,
//                // autoPlay: false,
//              ),
//              items: bannetList.map((item) => Container(
//                child: Center(
//                  child:
//                  CachedNetworkImage(
//                    fit: BoxFit.fill,
//                    height: 230,
//
//                    imageUrl: item,
//                    placeholder: (context, url) => Center(
//                      child: SpinKitPulse(
//                        color: Colors.red,
//                        size: 50.0,
//                      ),
//                    ),
//                    errorWidget: (context, url, error) => Image(
//                      fit: BoxFit.fill,
//                      height: 400,
//                      image: AssetImage('assets/images/bg2.jpg', ),
//                    ),
//                  ),
////                        Image.network(item, fit: BoxFit.cover, width: MediaQuery.of(context).size.width)
//                ),
//              )).toList(),
//            ),
//        ),

//start of slider
                      Column(children: [
                        CarouselSlider(
                          items: imageSliders,
                          options: CarouselOptions(
                              height: 170,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: bannetList.map((url) {
                            int index = bannetList.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ]),
//end of slider
//start of fresh fruits and vegetables
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                "FRESH FRUITS & VEGETABLES",
                                style: TextStyle(
                                    fontFamily: 'montserrat',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              height: 25,
                              padding: const EdgeInsets.only(
                                top: 5,
                                left: 10,
                              ),
                            ),
                            flex: 7,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ShowHomeButtonCatPage("from home", 99)),
                              );
                            },
                            child: Container(
                              child: Text(
                                "See All",
                                style: TextStyle(
                                  fontFamily: 'montserrat',
                                  fontSize: 14,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                              height: 25,
                              margin: const EdgeInsets.only(right: 10.0),
                              padding: const EdgeInsets.only(
                                top: 2,
                                left: 10,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                //color: Colors.yellow,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFF2E3192)),
                              ),
                              //child: Container(color: Colors.orange, height: 25),
                            ),
                            //flex: 2,
                          ),
                        ],
                      ),
                      verticalSpace(),
                      verticalSpace(),

                      Container(
                        height: 260,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(right: 10, bottom: 20),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: popularList.items.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Products(
                                            popularList.items,
                                            index,
                                            popularList.items[index].sku,
                                            popularList.items[index].price,
                                            "normal"),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 5,
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 100,
                                              child: CachedNetworkImage(
                                                width: 120,
                                                height: 100,
                                                fit: BoxFit.contain,
                                                imageUrl: popularList
                                                            .items[index]
                                                            .mediaGalleryEntries
                                                            .length >
                                                        0
                                                    ? "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                        popularList
                                                            .items[index]
                                                            .mediaGalleryEntries[
                                                                0]
                                                            .file
                                                    : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                                placeholder: (context, url) =>
                                                    Center(

                                                        // child: SpinKitPulse(
                                                        //   color: Colors.red,
                                                        //   size: 50.0,
                                                        // ),
                                                        child: Image.asset(
                                                  "assets/images/icons/loadingicon2.gif",
                                                  height: 60.0,
                                                  width: 60.0,
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'AED ' +
                                                  popularList.items[index].price
                                                      .toString(),
                                              style: TextStyle(
                                                  fontFamily: 'montserrat',
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 160,
                                          height: 44,
                                          child: Text(
                                            popularList.items[index].name,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            padding: EdgeInsets.only(left: 5),
                                            height: 25.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            child:
                                                NumberInputWithIncrementDecrement(
                                              controller:
                                                  TextEditingController(),
                                              initialValue: 1,
                                              min: 1,
                                              max: 100,
                                              onIncrement: (num newVal) {
                                                setState(() {
                                                  popularqty[index] = newVal;
                                                });
                                              },
                                              onDecrement:
                                                  (num newlyDecrementedValue) {
                                                setState(() {
                                                  popularqty[index] =
                                                      newlyDecrementedValue;
                                                });
                                              },
                                              numberFieldDecoration:
                                                  InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              decIconColor: HexColor("e25814"),
                                              widgetContainerDecoration:
                                                  BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  1)),
                                                      border: Border.all(
                                                        color: Colors.black26,
                                                        width: 0.5,
                                                      )),
                                              incIconDecoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
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
                                              incIconColor: HexColor("302c98"),
                                              decIcon: Icons.remove,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 27,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .37,
                                          decoration: BoxDecoration(
                                            color: HexColor("302c98"),
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                                width: 0.5,
                                                color: HexColor("302c98")),
                                          ),
                                          child: FlatButton(
                                              onPressed: () async {
                                                if (!HomePageState.isLogin) {
                                                  // await addCartGuest(
                                                  //     popularList
                                                  //         .items[index].sku,
                                                  //     popularqty[index]);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LogInPage(1)));

                                                  print("Add to Cart guest...");
                                                } else {
                                                  await addCartUser(
                                                      popularList
                                                          .items[index].sku,
                                                      popularqty[index]);
                                                }
                                              },
                                              child: Text(
                                                'Add to Cart',
                                                style: TextStyle(
                                                    fontFamily: 'montserrat',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              )),
                                        ),
                                        SizedBox(
                                          height: 10,
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
//end of fresh fruits and vegetables

//start of shop by category

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                "SHOP BY CATEGORY",
                                style: TextStyle(
                                    fontFamily: 'montserrat',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              height: 25,
                              padding: const EdgeInsets.only(
                                top: 5,
                                left: 10,
                              ),
                            ),
                            flex: 7,
                          ),
                          InkWell(
                            child: Container(
                              child: Text(
                                "",
                              ),
                              height: 25,
                              margin: const EdgeInsets.only(right: 10.0),
                              padding: const EdgeInsets.only(
                                top: 2,
                                left: 10,
                                right: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(),
                      Container(
                        margin:
                            EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Card(
                                      elevation: 10,
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    4 -
                                                30,
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              pressed1 = !pressed1;
                                              pressed2 = false;
                                              pressed3 = false;
                                              pressed4 = false;
                                              pressed5 = false;
                                              pressed6 = false;
                                              pressed7 = false;
                                              pressed8 = false;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowHomeButtonCatPage(
                                                        "from home",
                                                        100,
                                                      )),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/fruits.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Fruits",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        color: pressed2
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Card(
                                      elevation: 10,
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    4 -
                                                30,
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              pressed1 = false;
                                              pressed2 = false;
                                              pressed3 = !pressed3;
                                              pressed4 = false;
                                              pressed5 = false;
                                              pressed6 = false;
                                              pressed7 = false;
                                              pressed8 = false;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowHomeButtonCatPage(
                                                          "from home", 101)),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/vegetables.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Vegetables",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        color: pressed2
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Card(
                                      elevation: 10,
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    4 -
                                                30,
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              pressed1 = false;
                                              pressed2 = false;
                                              pressed3 = false;
                                              pressed4 = !pressed4;
                                              pressed5 = false;
                                              pressed6 = false;
                                              pressed7 = false;
                                              pressed8 = false;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowHomeButtonCatPage(
                                                          "from home", 119)),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/seafood.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Seafood",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        color: pressed2
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Card(
                                      elevation: 10,
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    4 -
                                                30,
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              pressed1 = false;
                                              pressed2 = false;
                                              pressed3 = false;
                                              pressed4 = !pressed4;
                                              pressed5 = false;
                                              pressed6 = false;
                                              pressed7 = false;
                                              pressed8 = false;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowHomeButtonCatPage(
                                                          "from home", 107)),
                                            );
                                          },
                                          //padding: EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            'assets/images/icons/meat.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Meat",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        color: pressed2
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Card(
                                      elevation: 10,
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    4 -
                                                30,
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              pressed1 = false;
                                              pressed2 = false;
                                              pressed3 = false;
                                              pressed4 = false;
                                              pressed6 = false;
                                              pressed7 = false;
                                              pressed8 = false;
                                              pressed5 = !pressed5;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowHomeButtonCatPage(
                                                          "from home", 95)),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/bakery.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Bakery",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        color: pressed2
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Card(
                                      elevation: 10,
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    4 -
                                                30,
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              pressed1 = false;
                                              pressed2 = false;
                                              pressed3 = false;
                                              pressed4 = false;
                                              pressed5 = false;
                                              pressed7 = false;
                                              pressed8 = false;
                                              pressed6 = !pressed6;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowHomeButtonCatPage(
                                                          "from home", 89)),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/dairy.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Dairy",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        color: pressed2
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Card(
                                      elevation: 10,
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    4 -
                                                30,
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              pressed1 = false;
                                              pressed2 = false;
                                              pressed3 = false;
                                              pressed4 = false;
                                              pressed5 = false;
                                              pressed6 = false;
                                              pressed8 = false;
                                              pressed7 = !pressed7;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowHomeButtonCatPage(
                                                          "from home", 193)),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/drinks.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Drinks",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        color: pressed2
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Card(
                                      elevation: 10,
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    4 -
                                                30,
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              pressed1 = false;
                                              pressed2 = false;
                                              pressed3 = false;
                                              pressed4 = false;
                                              pressed5 = false;
                                              pressed6 = false;
                                              pressed7 = false;
                                              pressed8 = !pressed8;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowHomeButtonCatPage(
                                                          "from home", 108)),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/chicken.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Chicken",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        color: pressed2
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
//end of shop by category

                      productList.length > 0 ? verticalSpace() : Container(),
                      productList.length > 0 ? verticalSpace() : Container(),
                      // verticalSpace(),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                        child: Column(
                          children: [
                            productList.length > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            "BEST DEALS",
                                            style: TextStyle(
                                                fontFamily: 'montserrat',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          height: 25,
                                          padding: const EdgeInsets.only(
                                            top: 5,
                                            left: 10,
                                          ),
                                        ),
                                        flex: 7,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowBestDealsPage(
                                                          "from home", 1542)));
                                        },
                                        child: Container(
                                          child: Text(
                                            "See All",
                                            style: TextStyle(
                                              fontFamily: 'montserrat',
                                              fontSize: 14,
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          height: 25,
                                          margin: const EdgeInsets.only(
                                              right: 10.0),
                                          padding: const EdgeInsets.only(
                                            top: 2,
                                            left: 10,
                                            right: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            //color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                                color: Color(0xFF2E3192)),
                                          ),
                                          //child: Container(color: Colors.orange, height: 25),
                                        ),
                                        //flex: 2,
                                      ),
                                    ],
                                  )
                                : Text(""),
                            verticalSpace(),
                                  bestDealList.items.length > 0 ?  Container(
                    height: 280,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(right: 10,bottom: 20),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: bestDealList.items.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Products(bestDealList.items, index,
                                            bestDealList.items[index].sku, bestDealList.items[index].price, "normal"),


                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
//                                color: Color(0xFFFAFAFA),
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
                                        Container(
                                          width: 160,
                                          height: 120,
                                          child: CachedNetworkImage(
//                                          width: 200,
                                            fit: BoxFit.contain,
                                            imageUrl: bestDealList
                                                .items[index]
                                                .mediaGalleryEntries.length > 0 ?
                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                bestDealList
                                                    .items[index]
                                                    .mediaGalleryEntries[
                                                0]
                                                    .file : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                            placeholder: (context, url) => Center(
                                              child:
//                                                Image.asset(
//                                                  'assets/images/logo.png',
//                                                  height: 35,
//                                                ),),
//                                            errorWidget:
//                                                (context, url, error) =>
//                                                    new Icon(Icons.error),
                                              SpinKitPulse(
                                                color: Colors.red,
                                                size: 50.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'AED ' +
                                              bestDealList.items[index].price
                                                  .toString(),
                                          style:  TextStyle( fontFamily: 'montserrat',
                                              fontSize: 14,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),

                                        ),
                                      ],
                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(left: 10,right: 10),
//                                      child:
//                                    ),
//                                    Flexible(
//                                      child: Container(
//                                        width: 100,
//                                        padding: EdgeInsets.only(
//                                            left: 5,
//                                            right: 5,
//                                            top: 5,
//                                            bottom: 5),
//                                        child:
                                    SizedBox(
                                      width: 160,
                                      height: 44,
                                      child:  Text(
                                        bestDealList.items[index].name,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),

//                                      ),
//                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 5),
                                        height: 25.0,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            .4,
                                        // fixed width and height
                                        child:
                                        NumberInputWithIncrementDecrement(
                                          controller: TextEditingController(),
                                          initialValue: 1,
                                          min: 1,
                                          max: 100,
                                          onIncrement: (num newVal) {
                                            setState(() {
                                              popularqty[index] = newVal;
                                            });
                                          },
                                          onDecrement:
                                              (num newlyDecrementedValue) {
                                            setState(() {
                                              popularqty[index] =
                                                  newlyDecrementedValue;
                                            });
                                          },
                                          numberFieldDecoration:
                                          InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          decIconColor: HexColor("e25814"),
                                          widgetContainerDecoration:
                                          BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(1)),
                                              border: Border.all(
                                                color: Colors.black26,
                                                width: 0.5,
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
                                          style: TextStyle( fontFamily: 'montserrat', fontSize: 15),
                                          incIcon: Icons.add,incIconColor: HexColor("302c98"),
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
                                          .37,
                                      decoration: BoxDecoration(
                                        color: HexColor("302c98"),
                                        borderRadius:
                                        BorderRadius.circular(3),
                                        border: Border.all(
                                            width: 0.5, color: HexColor("9ba905")),
                                      ),
                                      child: FlatButton(
                                          onPressed: () async {
                                            if (!isLogin) {
                                              await addCartGuest(
                                                  bestDealList
                                                      .items[index].sku,
                                                  popularqty[index]);
//
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                            } else {
                                              await addCartUser(
                                                  bestDealList
                                                      .items[index].sku,
                                                  popularqty[index]);
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                            }
//                                                    await addCartUser(productList.items[index].sku);
//                                                    Navigator.push(
//                                                      context,
//                                                      MaterialPageRoute(builder: (context) => CartList()),
//                                                    );
                                          },
                                          child: Text(
                                            'Add to Cart',
                                            style: TextStyle( fontFamily: 'montserrat',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ) : Container(),

                            
                            
                            offerBannerList.length > 0
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShowHomeButtonCatPage(
                                                  "from home",
                                                  87,
                                                )),
                                      );
                                    },
                                    child: CachedNetworkImage(
//                                          width: 200,
                                      fit: BoxFit.contain,
                                      imageUrl: offerBannerList[0],
                                      placeholder: (context, url) => Center(
                                          child: Image.asset(
                                        "assets/images/icons/loadingicon2.gif",
                                        height: 60.0,
                                        width: 60.0,
                                      )),
                                    ),
                                  )
                                : Container(),

//start of Fresh Foods Cards
                            verticalSpace(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 99,
                                                  name: "Fruits & Vegetables")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .97,
                                    height: 150,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList[0],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                  //flex: 2,
                                ),
                              ],
                            ),
                            verticalSpace(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 103,
                                                  name: "Poultry")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .48,
                                    height: 73,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList[1],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 95,
                                                  name: "Baked")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .48,
                                    height: 73,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList[2],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 89,
                                                  name: "Diary Products")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .48,
                                    height: 73,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList[3],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 1182,
                                                  name: "Delicatessen")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .48,
                                    height: 73,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList[4],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                ),
                              ],
                            ),
//end fo Fresh Food Cards
                            verticalSpace(),
                            verticalSpace(),

//start of grocery needs

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      "GROCERY NEEDS",
                                      style: TextStyle(
                                          fontFamily: 'montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    height: 25,
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 10,
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowHomeButtonCatPage(
                                                  "from home", 125)),
                                    );
                                  },
                                  child: Container(
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    height: 25,
                                    margin: const EdgeInsets.only(right: 10.0),
                                    padding: const EdgeInsets.only(
                                      top: 2,
                                      left: 10,
                                      right: 10,
                                    ),

                                    decoration: BoxDecoration(
                                      // color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border:
                                          Border.all(color: Color(0xFF2E3192)),
                                    ),
                                    //child: Container(color: Colors.orange, height: 25),
                                  ),
                                  //flex: 2,
                                ),
                              ],
                            ),
                            verticalSpace(),
                            verticalSpace(),

                            Container(
                              height: 260,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 20),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: groceryList.items.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Products(
                                                  groceryList.items,
                                                  index,
                                                  groceryList.items[index].sku,
                                                  groceryList
                                                      .items[index].price,
                                                  "normal"),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          color: Colors.white,
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    child: CachedNetworkImage(
                                                      width: 120,
                                                      height: 100,
                                                      fit: BoxFit.contain,
                                                      imageUrl: groceryList
                                                                  .items[index]
                                                                  .mediaGalleryEntries
                                                                  .length >
                                                              0
                                                          ? "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                              groceryList
                                                                  .items[index]
                                                                  .mediaGalleryEntries[
                                                                      0]
                                                                  .file
                                                          : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  Image.asset(
                                                        "assets/images/icons/loadingicon2.gif",
                                                        height: 60.0,
                                                        width: 60.0,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'AED ' +
                                                        groceryList
                                                            .items[index].price
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 14,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 160,
                                                height: 44,
                                                child: Text(
                                                  groceryList.items[index].name,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  height: 25.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child:
                                                      NumberInputWithIncrementDecrement(
                                                    controller:
                                                        TextEditingController(),
                                                    initialValue: 1,
                                                    min: 1,
                                                    max: 100,
                                                    onIncrement: (num newVal) {
                                                      setState(() {
                                                        groceryqty[index] =
                                                            newVal;
                                                      });
                                                    },
                                                    onDecrement: (num
                                                        newlyDecrementedValue) {
                                                      setState(() {
                                                        groceryqty[index] =
                                                            newlyDecrementedValue;
                                                      });
                                                    },
                                                    numberFieldDecoration:
                                                        InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    decIconColor:
                                                        HexColor("e25814"),
                                                    widgetContainerDecoration:
                                                        BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            1)),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black26,
                                                              width: 0.5,
                                                            )),
                                                    incIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    separateIcons: false,
                                                    decIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    incIconSize: 15,
                                                    decIconSize: 15,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 15),
                                                    incIcon: Icons.add,
                                                    incIconColor:
                                                        HexColor("302c98"),
                                                    decIcon: Icons.remove,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 27,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .37,
                                                decoration: BoxDecoration(
                                                  color: HexColor("302c98"),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color:
                                                          HexColor("302c98")),
                                                ),
                                                child: FlatButton(
                                                    onPressed: () async {
                                                      if (!HomePageState
                                                          .isLogin) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LogInPage(
                                                                            1)));
                                                        // await addCartGuest(
                                                        //     groceryList
                                                        //         .items[index]
                                                        //         .sku,
                                                        //     groceryqty[index]);
                                                      } else {
                                                        await addCartUser(
                                                            groceryList
                                                                .items[index]
                                                                .sku,
                                                            groceryqty[index]);
                                                      }
                                                    },
                                                    child: Text(
                                                      'Add to Cart',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'montserrat',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10,
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

//end of grocery needs

//start of Food Cards

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 196,
                                                  name: "Drinking Water")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .97,
                                    height: 240,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList1[2],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                  //flex: 2,
                                ),
                              ],
                            ),
                            verticalSpace(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 1644,
                                                  
                                                  name: "brazilian chocolate")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .48,
                                    height: 130,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList1[0],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 166,
                                                  name: "Chips")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .48,
                                    height: 130,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList1[1],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                ),
                              ],
                            ),
//end of Food Cards
                            verticalSpace(),
//start of baby care

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      "BABY CARE",
                                      style: TextStyle(
                                          fontFamily: 'montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    height: 25,
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 10,
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowHomeButtonCatPage(
                                                  "from home", 199)),
                                    );
                                  },
                                  child: Container(
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    height: 25,
                                    margin: const EdgeInsets.only(right: 10.0),
                                    padding: const EdgeInsets.only(
                                      top: 2,
                                      left: 10,
                                      right: 10,
                                    ),

                                    decoration: BoxDecoration(
                                      // color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border:
                                          Border.all(color: Color(0xFF2E3192)),
                                    ),
                                    //child: Container(color: Colors.orange, height: 25),
                                  ),
                                  //flex: 2,
                                ),
                              ],
                            ),
                            verticalSpace(),
                            verticalSpace(),

                            Container(
                              height: 260,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 20),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: babycareList.items.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Products(
                                                  babycareList.items,
                                                  index,
                                                  babycareList.items[index].sku,
                                                  babycareList
                                                      .items[index].price,
                                                  "normal"),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          color: Colors.white,
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    child: CachedNetworkImage(
                                                      width: 120,
                                                      height: 100,
                                                      fit: BoxFit.contain,
                                                      imageUrl: babycareList
                                                                  .items[index]
                                                                  .mediaGalleryEntries
                                                                  .length >
                                                              0
                                                          ? "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                              babycareList
                                                                  .items[index]
                                                                  .mediaGalleryEntries[
                                                                      0]
                                                                  .file
                                                          : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  Image.asset(
                                                        "assets/images/icons/loadingicon2.gif",
                                                        height: 60.0,
                                                        width: 60.0,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'AED ' +
                                                        babycareList
                                                            .items[index].price
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 14,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 160,
                                                height: 44,
                                                child: Text(
                                                  babycareList
                                                      .items[index].name,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  height: 25.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child:
                                                      NumberInputWithIncrementDecrement(
                                                    controller:
                                                        TextEditingController(),
                                                    initialValue: 1,
                                                    min: 1,
                                                    max: 100,
                                                    onIncrement: (num newVal) {
                                                      setState(() {
                                                        babycareqty[index] =
                                                            newVal;
                                                      });
                                                    },
                                                    onDecrement: (num
                                                        newlyDecrementedValue) {
                                                      setState(() {
                                                        babycareqty[index] =
                                                            newlyDecrementedValue;
                                                      });
                                                    },
                                                    numberFieldDecoration:
                                                        InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    decIconColor:
                                                        HexColor("e25814"),
                                                    widgetContainerDecoration:
                                                        BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            1)),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black26,
                                                              width: 0.5,
                                                            )),
                                                    incIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    separateIcons: false,
                                                    decIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    incIconSize: 15,
                                                    decIconSize: 15,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 15),
                                                    incIcon: Icons.add,
                                                    incIconColor:
                                                        HexColor("302c98"),
                                                    decIcon: Icons.remove,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 27,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .37,
                                                decoration: BoxDecoration(
                                                  color: HexColor("302c98"),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color:
                                                          HexColor("302c98")),
                                                ),
                                                child: FlatButton(
                                                    onPressed: () async {
                                                      if (!HomePageState
                                                          .isLogin) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LogInPage(
                                                                            1)));
                                                        // await addCartGuest(
                                                        //     babycareList
                                                        //         .items[index]
                                                        //         .sku,
                                                        //     babycareqty[index]);
                                                      } else {
                                                        await addCartUser(
                                                            babycareList
                                                                .items[index]
                                                                .sku,
                                                            babycareqty[index]);
                                                      }
                                                    },
                                                    child: Text(
                                                      'Add to Cart',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'montserrat',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10,
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

//end of baby care

//start of Health Care Essentials
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      "HEALTH CARE ESSENTIALS",
                                      style: TextStyle(
                                          fontFamily: 'montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    height: 25,
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 10,
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowHomeButtonCatPage(
                                                  "from home", 314)),
                                    );
                                  },
                                  child: Container(
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    height: 25,
                                    margin: const EdgeInsets.only(right: 10.0),
                                    padding: const EdgeInsets.only(
                                      top: 2,
                                      left: 10,
                                      right: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      //color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border:
                                          Border.all(color: Color(0xFF2E3192)),
                                    ),
                                    //child: Container(color: Colors.orange, height: 25),
                                  ),
                                  //flex: 2,
                                ),
                              ],
                            ),
                            verticalSpace(),
                            verticalSpace(),

                            Container(
                              height: 260,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 20),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: popularhealthList.items.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Products(
                                                  popularhealthList.items,
                                                  index,
                                                  popularhealthList
                                                      .items[index].sku,
                                                  popularhealthList
                                                      .items[index].price,
                                                  "normal"),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          color: Colors.white,
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    child: CachedNetworkImage(
                                                      width: 120,
                                                      height: 100,
                                                      fit: BoxFit.contain,
                                                      imageUrl: popularhealthList
                                                                  .items[index]
                                                                  .mediaGalleryEntries
                                                                  .length >
                                                              0
                                                          ? "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                              popularhealthList
                                                                  .items[index]
                                                                  .mediaGalleryEntries[
                                                                      0]
                                                                  .file
                                                          : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  Image.asset(
                                                        "assets/images/icons/loadingicon2.gif",
                                                        height: 60.0,
                                                        width: 60.0,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'AED ' +
                                                        popularhealthList
                                                            .items[index].price
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 14,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 160,
                                                height: 44,
                                                child: Text(
                                                  popularhealthList
                                                      .items[index].name,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  height: 25.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child:
                                                      NumberInputWithIncrementDecrement(
                                                    controller:
                                                        TextEditingController(),
                                                    initialValue: 1,
                                                    min: 1,
                                                    max: 100,
                                                    onIncrement: (num newVal) {
                                                      setState(() {
                                                        popularqty[index] =
                                                            newVal;
                                                      });
                                                    },
                                                    onDecrement: (num
                                                        newlyDecrementedValue) {
                                                      setState(() {
                                                        popularqty[index] =
                                                            newlyDecrementedValue;
                                                      });
                                                    },
                                                    numberFieldDecoration:
                                                        InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    decIconColor:
                                                        HexColor("e25814"),
                                                    widgetContainerDecoration:
                                                        BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            1)),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black26,
                                                              width: 0.5,
                                                            )),
                                                    incIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    separateIcons: false,
                                                    decIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    incIconSize: 15,
                                                    decIconSize: 15,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 15),
                                                    incIcon: Icons.add,
                                                    incIconColor:
                                                        HexColor("302c98"),
                                                    decIcon: Icons.remove,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 27,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .37,
                                                decoration: BoxDecoration(
                                                  color: HexColor("302c98"),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color:
                                                          HexColor("302c98")),
                                                ),
                                                child: FlatButton(
                                                    onPressed: () async {
                                                      if (!HomePageState
                                                          .isLogin) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LogInPage(
                                                                            1)));
                                                        // await addCartGuest(
                                                        //     popularhealthList
                                                        //         .items[index]
                                                        //         .sku,
                                                        //     popularqty[index]);
                                                      } else {
                                                        await addCartUser(
                                                            popularhealthList
                                                                .items[index]
                                                                .sku,
                                                            popularqty[index]);
                                                      }
                                                    },
                                                    child: Text(
                                                      'Add to Cart',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'montserrat',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10,
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

//end of Health Care Essentials

//start of Food Cards 2

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 152,
                                                  name: "Baking Essential")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .97,
                                    height: 200,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList2[0],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                  //flex: 2,
                                ),
                              ],
                            ),
                            verticalSpace(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 126,
                                                  name: "Breakfast")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .48,
                                    height: 95,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList2[1],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 135,
                                                  name: "Rice & Pasta")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .48,
                                    height: 95,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList2[2],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                ),
                              ],
                            ),
//end of Food Cards 2
                            verticalSpace(),
                            verticalSpace(),
//start of household & kitchen essentials

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      "HOUSEHOLD & KITCHEN ESSENTIALS",
                                      style: TextStyle(
                                          fontFamily: 'montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    height: 25,
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 10,
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowHomeButtonCatPage(
                                                  "from home", 210)),
                                    );
                                  },
                                  child: Container(
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    height: 25,
                                    margin: const EdgeInsets.only(right: 10.0),
                                    padding: const EdgeInsets.only(
                                      top: 2,
                                      left: 10,
                                      right: 10,
                                    ),

                                    decoration: BoxDecoration(
                                      // color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border:
                                          Border.all(color: Color(0xFF2E3192)),
                                    ),
                                    //child: Container(color: Colors.orange, height: 25),
                                  ),
                                  //flex: 2,
                                ),
                              ],
                            ),
                            verticalSpace(),
                            verticalSpace(),

                            Container(
                              height: 260,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 20),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: householdList.items.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Products(
                                                  householdList.items,
                                                  index,
                                                  householdList
                                                      .items[index].sku,
                                                  householdList
                                                      .items[index].price,
                                                  "normal"),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          color: Colors.white,
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    child: CachedNetworkImage(
                                                      width: 120,
                                                      height: 100,
                                                      fit: BoxFit.contain,
                                                      imageUrl: householdList
                                                                  .items[index]
                                                                  .mediaGalleryEntries
                                                                  .length >
                                                              0
                                                          ? "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                              householdList
                                                                  .items[index]
                                                                  .mediaGalleryEntries[
                                                                      0]
                                                                  .file
                                                          : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  Image.asset(
                                                        "assets/images/icons/loadingicon2.gif",
                                                        height: 60.0,
                                                        width: 60.0,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'AED ' +
                                                        householdList
                                                            .items[index].price
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 14,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 160,
                                                height: 44,
                                                child: Text(
                                                  householdList
                                                      .items[index].name,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  height: 25.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child:
                                                      NumberInputWithIncrementDecrement(
                                                    controller:
                                                        TextEditingController(),
                                                    initialValue: 1,
                                                    min: 1,
                                                    max: 100,
                                                    onIncrement: (num newVal) {
                                                      setState(() {
                                                        householdqty[index] =
                                                            newVal;
                                                      });
                                                    },
                                                    onDecrement: (num
                                                        newlyDecrementedValue) {
                                                      setState(() {
                                                        householdqty[index] =
                                                            newlyDecrementedValue;
                                                      });
                                                    },
                                                    numberFieldDecoration:
                                                        InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    decIconColor:
                                                        HexColor("e25814"),
                                                    widgetContainerDecoration:
                                                        BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            1)),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black26,
                                                              width: 0.5,
                                                            )),
                                                    incIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    separateIcons: false,
                                                    decIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    incIconSize: 15,
                                                    decIconSize: 15,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 15),
                                                    incIcon: Icons.add,
                                                    incIconColor:
                                                        HexColor("302c98"),
                                                    decIcon: Icons.remove,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 27,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .37,
                                                decoration: BoxDecoration(
                                                  color: HexColor("302c98"),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color:
                                                          HexColor("302c98")),
                                                ),
                                                child: FlatButton(
                                                    onPressed: () async {
                                                      if (!HomePageState
                                                          .isLogin) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LogInPage(
                                                                            1)));
                                                        // await addCartGuest(
                                                        //     householdList
                                                        //         .items[index]
                                                        //         .sku,
                                                        //     householdqty[
                                                        //         index]);
                                                      } else {
                                                        await addCartUser(
                                                            householdList
                                                                .items[index]
                                                                .sku,
                                                            householdqty[
                                                                index]);
                                                      }
                                                    },
                                                    child: Text(
                                                      'Add to Cart',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'montserrat',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10,
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

//end of household & kitchen essentials

// start of delivery strip banner

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 87,
                                                  name: "All Products")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .97,
                                    height: 60,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList3[0],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                  //flex: 2,
                                ),
                              ],
                            ),

// end of delivery strip banner
                            verticalSpace(),
//start of frozen

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      "FROZEN",
                                      style: TextStyle(
                                          fontFamily: 'montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    height: 25,
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 10,
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowHomeButtonCatPage(
                                                  "from home", 113)),
                                    );
                                  },
                                  child: Container(
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    height: 25,
                                    margin: const EdgeInsets.only(right: 10.0),
                                    padding: const EdgeInsets.only(
                                      top: 2,
                                      left: 10,
                                      right: 10,
                                    ),

                                    decoration: BoxDecoration(
                                      // color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border:
                                          Border.all(color: Color(0xFF2E3192)),
                                    ),
                                    //child: Container(color: Colors.orange, height: 25),
                                  ),
                                  //flex: 2,
                                ),
                              ],
                            ),
                            verticalSpace(),
                            verticalSpace(),

                            Container(
                              height: 260,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 20),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: householdList.items.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Products(
                                                  frozenList.items,
                                                  index,
                                                  frozenList.items[index].sku,
                                                  frozenList.items[index].price,
                                                  "normal"),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          color: Colors.white,
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    child: CachedNetworkImage(
                                                      width: 120,
                                                      height: 100,
                                                      fit: BoxFit.contain,
                                                      imageUrl: frozenList
                                                                  .items[index]
                                                                  .mediaGalleryEntries
                                                                  .length >
                                                              0
                                                          ? "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                              frozenList
                                                                  .items[index]
                                                                  .mediaGalleryEntries[
                                                                      0]
                                                                  .file
                                                          : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  Image.asset(
                                                        "assets/images/icons/loadingicon2.gif",
                                                        height: 60.0,
                                                        width: 60.0,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'AED ' +
                                                        frozenList
                                                            .items[index].price
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 14,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 160,
                                                height: 44,
                                                child: Text(
                                                  frozenList.items[index].name,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  height: 25.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child:
                                                      NumberInputWithIncrementDecrement(
                                                    controller:
                                                        TextEditingController(),
                                                    initialValue: 1,
                                                    min: 1,
                                                    max: 100,
                                                    onIncrement: (num newVal) {
                                                      setState(() {
                                                        frozenqty[index] =
                                                            newVal;
                                                      });
                                                    },
                                                    onDecrement: (num
                                                        newlyDecrementedValue) {
                                                      setState(() {
                                                        frozenqty[index] =
                                                            newlyDecrementedValue;
                                                      });
                                                    },
                                                    numberFieldDecoration:
                                                        InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    decIconColor:
                                                        HexColor("e25814"),
                                                    widgetContainerDecoration:
                                                        BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            1)),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black26,
                                                              width: 0.5,
                                                            )),
                                                    incIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    separateIcons: false,
                                                    decIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    incIconSize: 15,
                                                    decIconSize: 15,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 15),
                                                    incIcon: Icons.add,
                                                    incIconColor:
                                                        HexColor("302c98"),
                                                    decIcon: Icons.remove,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 27,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .37,
                                                decoration: BoxDecoration(
                                                  color: HexColor("302c98"),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color:
                                                          HexColor("302c98")),
                                                ),
                                                child: FlatButton(
                                                    onPressed: () async {
                                                      if (!HomePageState
                                                          .isLogin) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LogInPage(
                                                                            1)));
                                                        // await addCartGuest(
                                                        //     frozenList
                                                        //         .items[index]
                                                        //         .sku,
                                                        //     frozenqty[index]);
                                                      } else {
                                                        await addCartUser(
                                                            frozenList
                                                                .items[index]
                                                                .sku,
                                                            frozenqty[index]);
                                                      }
                                                    },
                                                    child: Text(
                                                      'Add to Cart',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'montserrat',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10,
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

//end of frozen

                            verticalSpace(),
//start of Beverage

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      "BEVERAGES",
                                      style: TextStyle(
                                          fontFamily: 'montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    height: 25,
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 10,
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowHomeButtonCatPage(
                                                  "from home", 177)),
                                    );
                                  },
                                  child: Container(
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    height: 25,
                                    margin: const EdgeInsets.only(right: 10.0),
                                    padding: const EdgeInsets.only(
                                      top: 2,
                                      left: 10,
                                      right: 10,
                                    ),

                                    decoration: BoxDecoration(
                                      // color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border:
                                          Border.all(color: Color(0xFF2E3192)),
                                    ),
                                    //child: Container(color: Colors.orange, height: 25),
                                  ),
                                  //flex: 2,
                                ),
                              ],
                            ),
                            verticalSpace(),
                            verticalSpace(),

                            Container(
                              height: 260,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 20),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: beveragesList.items.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Products(
                                                  beveragesList.items,
                                                  index,
                                                  beveragesList
                                                      .items[index].sku,
                                                  beveragesList
                                                      .items[index].price,
                                                  "normal"),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          color: Colors.white,
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    child: CachedNetworkImage(
                                                      width: 120,
                                                      height: 100,
                                                      fit: BoxFit.contain,
                                                      imageUrl: beveragesList
                                                                  .items[index]
                                                                  .mediaGalleryEntries
                                                                  .length >
                                                              0
                                                          ? "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                              beveragesList
                                                                  .items[index]
                                                                  .mediaGalleryEntries[
                                                                      0]
                                                                  .file
                                                          : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  Image.asset(
                                                        "assets/images/icons/loadingicon2.gif",
                                                        height: 60.0,
                                                        width: 60.0,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'AED ' +
                                                        beveragesList
                                                            .items[index].price
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 14,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 160,
                                                height: 44,
                                                child: Text(
                                                  beveragesList
                                                      .items[index].name,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  height: 25.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child:
                                                      NumberInputWithIncrementDecrement(
                                                    controller:
                                                        TextEditingController(),
                                                    initialValue: 1,
                                                    min: 1,
                                                    max: 100,
                                                    onIncrement: (num newVal) {
                                                      setState(() {
                                                        beveragesqty[index] =
                                                            newVal;
                                                      });
                                                    },
                                                    onDecrement: (num
                                                        newlyDecrementedValue) {
                                                      setState(() {
                                                        beveragesqty[index] =
                                                            newlyDecrementedValue;
                                                      });
                                                    },
                                                    numberFieldDecoration:
                                                        InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    decIconColor:
                                                        HexColor("e25814"),
                                                    widgetContainerDecoration:
                                                        BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            1)),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black26,
                                                              width: 0.5,
                                                            )),
                                                    incIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    separateIcons: false,
                                                    decIconDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(0),
                                                      ),
                                                    ),
                                                    incIconSize: 15,
                                                    decIconSize: 15,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 15),
                                                    incIcon: Icons.add,
                                                    incIconColor:
                                                        HexColor("302c98"),
                                                    decIcon: Icons.remove,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 27,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .37,
                                                decoration: BoxDecoration(
                                                  color: HexColor("302c98"),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color:
                                                          HexColor("302c98")),
                                                ),
                                                child: FlatButton(
                                                    onPressed: () async {
                                                      if (!HomePageState
                                                          .isLogin) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LogInPage(
                                                                            1)));
                                                        // await addCartGuest(
                                                        //     beveragesList
                                                        //         .items[index]
                                                        //         .sku,
                                                        //     beveragesqty[
                                                        //         index]);
                                                      } else {
                                                        await addCartUser(
                                                            beveragesList
                                                                .items[index]
                                                                .sku,
                                                            beveragesqty[
                                                                index]);
                                                      }
                                                    },
                                                    child: Text(
                                                      'Add to Cart',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'montserrat',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10,
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

//end of Beverages

                            verticalSpace(),

//start of Food Cards 3

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 261,
                                                  name: "Hair Care")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .48,
                                    height: 135,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList4[0],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowSearchProductPage(
                                                  categoryId: 314,
                                                  name: "Health Care")),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * .48,
                                    height: 135,
                                    fit: BoxFit.contain,
                                    imageUrl: categoryBannerList4[1],
                                    placeholder: (context, url) => Center(
                                        child: Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    )),
                                  ),
                                ),
                              ],
                            ),
//end of Food Cards 3
                          ],
                        ),
                      ),
                      verticalSpace(),
                    ],
                  ),
                )
          : Container(
              decoration: BoxDecoration(),
              child: Center(
                  child: Column(
//            mainAxisAlignment: ,
                children: [
                  Expanded(
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Oops! \nInternet Connection \nis not detected! ",
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please check your network connection.",
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              color: HexColor("302c98"),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                            color: HexColor("302c98"),
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                width: 0.5, color: HexColor("302c98")),
                          ),
                          child: FlatButton(
                              onPressed: () async {
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult ==
                                    ConnectivityResult.none) {
                                  setState(() {
                                    _progressController = false;
                                    isnetworkAvailable = false;
                                  });
                                  print("no internet");
                                } else {
                                  setState(() {
                                    _progressController = true;
                                    isnetworkAvailable = true;
                                  });
                                  isLoggedIn();
                                  loadBanner();
                                  loadCategoryBanner();
                                  loadCategoryBanner1();
                                  loadCategoryBanner2();
                                  loadCategoryBanner3();
                                  loadCategoryBanner4();
                                  loadCoupenBanner();
//    freshFoodBanner();
                                  getProductList();

                                  getBestSellingList();
                                  getHealthcareProduct();
                                  getBabycareProduct();
                                  getGroceryProduct();
                                  getHouseholdProduct();
                                  getFrozenProduct();
                                  getBeveragesProduct();
                                  getFreshProduct();
                                  listenForAdminKey();
                                }
                              },
                              child: Text(
                                'Try Again',
                                style: TextStyle(
                                    fontFamily: 'montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )),
                        ),
                      ],
                    )),
                  ),
                ],
              )),
            ),
    );
  }

  Future loadBanner() async {
    var url = baseUrl + 'rest/V1/cmsBlock/26';
    try {
      print(url);
      var response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
//        print("banner response");
//        print(responseJson);
        bannerUrl1 = baseUrl + "pub/media/";
        bannerUrl2 = baseUrl + "pub/media/";

        var bannerString = responseJson['content'];

        var document = parse(bannerString);
        setState(() {
          bannerCount = document.getElementsByTagName('img').length;
        });
        for (var i = 0; i < document.getElementsByTagName('img').length; i++) {
          final start = '\"';
          final end = '\"';
          String urlString =
              document.getElementsByTagName('img')[i].attributes['src'];
          print("responseJson");

          final startIndex = urlString.indexOf(start);
          final endIndex = urlString.indexOf(end, startIndex + start.length);
          setState(() {
            bannetList.add(bannerUrl1 +
                urlString.substring(startIndex + start.length, endIndex));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    setState(() {
      imageSliders = bannetList
          .map((item) => Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Center(
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 230,
                        imageUrl: item,
                        placeholder: (context, url) => Center(
                            child: Image.asset(
                          "assets/images/icons/loadingicon2.gif",
                          height: 60.0,
                          width: 60.0,
                        )),
                        errorWidget: (context, url, error) => Image(
                          fit: BoxFit.contain,
                          height: 400,
                          image: AssetImage(
                            'assets/images/bg2.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ))
          .toList();
    });
  }

  Future loadCoupenBanner() async {
    ApiRepository.loadCategoryList().then((userDataFromServer) async {
      if (userDataFromServer != null) {
        _progressController = false;

        categoryList = userDataFromServer;
        for (var i = 0; i < categoryList.childrenData.length; i++) {
          if (categoryList.childrenData[i].id == 1584) {
            for (var j = 0;
                j < categoryList.childrenData[i].childrenData.length;
                j++) {
              if (categoryList.childrenData[i].childrenData[j].id == 1586 &&
                  categoryList.childrenData[i].childrenData[j].isActive ==
                      true) {
                var url = baseUrl + 'rest/V1/cmsBlock/53';
                try {
                  print(url);
                  var response = await http.get(
                    Uri.parse(url),
                    headers: {"Content-Type": "application/json"},
                  );
                  if (response.statusCode == 200) {
                    final responseJson = json.decode(response.body);
                    bannerUrl1 = baseUrl + "pub/media/";
                    bannerUrl2 = baseUrl + "pub/media/";
                    var bannerString = responseJson['content'];

                    var document = parse(bannerString);

                    for (var i = 0;
                        i < document.getElementsByTagName('img').length;
                        i++) {
                      final start = '\"';
                      final end = '\"';
                      String urlString = document
                          .getElementsByTagName('img')[i]
                          .attributes['src'];
                      print("responseJson");

                      final startIndex = urlString.indexOf(start);
                      final endIndex =
                          urlString.indexOf(end, startIndex + start.length);
                      setState(() {
                        offerBannerList.add(bannerUrl1 +
                            urlString.substring(
                                startIndex + start.length, endIndex));
                      });
                    }
                  }
                } catch (e) {
                  throw Exception(e.toString());
                }
              }
            }
          }
        }
      } else {
        print("Somithing went wrong...!");
      }
    });
  }

  Future loadCategoryBanner() async {
    var url = baseUrl + 'rest/V1/cmsBlock/50';
    try {
      print(url);
      var response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        bannerUrl1 = baseUrl + "pub/media/";
        bannerUrl2 = baseUrl + "pub/media/";
        var bannerString = responseJson['content'];

        var document = parse(bannerString);

        for (var i = 0; i < document.getElementsByTagName('img').length; i++) {
          final start = '\"';
          final end = '\"';
          String urlString =
              document.getElementsByTagName('img')[i].attributes['src'];
          print("responseJson");

          final startIndex = urlString.indexOf(start);
          final endIndex = urlString.indexOf(end, startIndex + start.length);
          setState(() {
            categoryBannerList.add(bannerUrl1 +
                urlString.substring(startIndex + start.length, endIndex));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    setState(() {
      imageSliders = bannetList
          .map((item) => Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Center(
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 230,
                        imageUrl: item,
                        placeholder: (context, url) => Center(
                            child: Image.asset(
                          "assets/images/icons/loadingicon2.gif",
                          height: 60.0,
                          width: 60.0,
                        )),
                        errorWidget: (context, url, error) => Image(
                          fit: BoxFit.contain,
                          height: 400,
                          image: AssetImage(
                            'assets/images/bg2.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ))
          .toList();
    });
  }

  Future loadCategoryBanner1() async {
    var url1 = baseUrl + 'rest/V1/cmsBlock/61';
    try {
      print(url1);
      var response = await http.get(Uri.parse(
        url1),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        bannerUrl3 = baseUrl + "pub/media/";
        bannerUrl4 = baseUrl + "pub/media/";
        var bannerString0 = responseJson['content'];

        var document = parse(bannerString0);

        for (var i = 0; i < document.getElementsByTagName('img').length; i++) {
          final start = '\"';
          final end = '\"';
          String urlString =
              document.getElementsByTagName('img')[i].attributes['src'];
          print("responseJson");

          final startIndex = urlString.indexOf(start);
          final endIndex = urlString.indexOf(end, startIndex + start.length);
          setState(() {
            categoryBannerList1.add(bannerUrl3 +
                urlString.substring(startIndex + start.length, endIndex));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future loadCategoryBanner2() async {
    var url2 = baseUrl + 'rest/V1/cmsBlock/67';
    try {
      print(url2);
      var response = await http.get(
       Uri.parse(url2),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        bannerUrl5 = baseUrl + "pub/media/";
        bannerUrl6 = baseUrl + "pub/media/";
        var bannerString01 = responseJson['content'];

        var document = parse(bannerString01);

        for (var i = 0; i < document.getElementsByTagName('img').length; i++) {
          final start = '\"';
          final end = '\"';
          String urlString =
              document.getElementsByTagName('img')[i].attributes['src'];
          print("responseJson");

          final startIndex = urlString.indexOf(start);
          final endIndex = urlString.indexOf(end, startIndex + start.length);
          setState(() {
            categoryBannerList2.add(bannerUrl5 +
                urlString.substring(startIndex + start.length, endIndex));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future loadCategoryBanner3() async {
    var url3 = baseUrl + 'rest/V1/cmsBlock/68';
    try {
      print(url3);
      var response = await http.get(
        Uri.parse(url3),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        bannerUrl7 = baseUrl + "pub/media/";
        var bannerString02 = responseJson['content'];

        var document = parse(bannerString02);

        for (var i = 0; i < document.getElementsByTagName('img').length; i++) {
          final start = '\"';
          final end = '\"';
          String urlString =
              document.getElementsByTagName('img')[i].attributes['src'];
          print("responseJson");

          final startIndex = urlString.indexOf(start);
          final endIndex = urlString.indexOf(end, startIndex + start.length);
          setState(() {
            categoryBannerList3.add(bannerUrl7 +
                urlString.substring(startIndex + start.length, endIndex));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future loadCategoryBanner4() async {
    var url4 = baseUrl + 'rest/V1/cmsBlock/66';
    try {
      print(url4);
      var response = await http.get(Uri.parse(
        url4),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        bannerUrl8 = baseUrl + "pub/media/";
        var bannerString03 = responseJson['content'];

        var document = parse(bannerString03);

        for (var i = 0; i < document.getElementsByTagName('img').length; i++) {
          final start = '\"';
          final end = '\"';
          String urlString =
              document.getElementsByTagName('img')[i].attributes['src'];
          print("responseJson");

          final startIndex = urlString.indexOf(start);
          final endIndex = urlString.indexOf(end, startIndex + start.length);
          setState(() {
            categoryBannerList4.add(bannerUrl8 +
                urlString.substring(startIndex + start.length, endIndex));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }



 Future getBestDealList() async {
    ApiRepository.loadhotSellingProduct(79,19).then((userDataFromServer) {

      if (userDataFromServer != null) {
        setState(() {
          _progressController = false;
          bestDealList = userDataFromServer;
          bestSellingqty =
          new List<int>.generate(bestDealList.items.length, (i) =>  1);
        });
      } else {
        print("Somithing went wrong...!");
      }
    });
  }


  Future getProductList() async {
    ApiRepository.loadhotSellingProduct(79, 10).then((userDataFromServer) {
      if (userDataFromServer != null) {
        setState(() {
          var newproductList = userDataFromServer;
          _progressController = false;

          for (var i = 0; i < newproductList.items.length; i++) {
            for (var j = 0;
                j < newproductList.items[i].customAttributes.length;
                j++) {
              if (newproductList.items[i].customAttributes[j].attributeCode ==
                  "special_price") {
                setState(() {
                  productqty.add(1);
                  productPrice.add(newproductList.items[i].price);
                  specialPrice
                      .add(newproductList.items[i].customAttributes[j].value);
                  productList.add(newproductList.items[i]);
                });
              }
            }
          }
        });
//       callPrice();
      } else {
        print("Somithing went wrong...!");
      }
    });
  }

  Future getHealthcareProduct() async {
    ApiRepository.loadhotSellingProduct(314, 10).then((userDataFromServer) {
      print("heathcare went wrong...!");
      if (userDataFromServer != null) {
        setState(() {
          print("heathcare went wrong...!");
          popularhealthList = userDataFromServer;
          popularhealthqty =
              new List<int>.generate(popularhealthList.items.length, (i) => 1);
          popularPrice = new List<double>.generate(
              popularhealthList.items.length, (i) => 0.0);
        });
      } else {
        print("Somithing went wrong...!");
      }
    });
  }

  Future getBabycareProduct() async {
    ApiRepository.loadhotSellingProduct(199, 10).then((userDataFromServer) {
      print("babycare went wrong...!");
      if (userDataFromServer != null) {
        setState(() {
          print("babycare went wrong...!");
          babycareList = userDataFromServer;
          babycareqty =
              new List<int>.generate(babycareList.items.length, (i) => 1);
          babycarePrice =
              new List<double>.generate(babycareList.items.length, (i) => 0.0);
        });
      } else {
        print("Somithing went wrong...!");
      }
    });
  }

  Future getGroceryProduct() async {
    ApiRepository.loadhotSellingProduct(125, 10).then((userDataFromServer) {
      print("grocery went wrong...!");
      if (userDataFromServer != null) {
        setState(() {
          print("household went wrong...!");
          groceryList = userDataFromServer;
          groceryqty =
              new List<int>.generate(groceryList.items.length, (i) => 1);
          groceryPrice =
              new List<double>.generate(groceryList.items.length, (i) => 0.0);
        });
      } else {
        print("Somithing went wrong...!");
      }
    });
  }

  Future getHouseholdProduct() async {
    ApiRepository.loadhotSellingProduct(210, 10).then((userDataFromServer) {
      print("frozen went wrong...!");
      if (userDataFromServer != null) {
        setState(() {
          print("household went wrong...!");
          householdList = userDataFromServer;
          householdqty =
              new List<int>.generate(householdList.items.length, (i) => 1);
          householdPrice =
              new List<double>.generate(householdList.items.length, (i) => 0.0);
        });
      } else {
        print("Somithing went wrong...!");
      }
    });
  }

  Future getFrozenProduct() async {
    ApiRepository.loadhotSellingProduct(113, 10).then((userDataFromServer) {
      print("frozen went wrong...!");
      if (userDataFromServer != null) {
        setState(() {
          print("frozen went wrong...!");
          frozenList = userDataFromServer;
          frozenqty = new List<int>.generate(frozenList.items.length, (i) => 1);
          frozenPrice =
              new List<double>.generate(frozenList.items.length, (i) => 0.0);
        });
      } else {
        print("Somithing went wrong...!");
      }
    });
  }

  Future getBeveragesProduct() async {
    ApiRepository.loadhotSellingProduct(177, 10).then((userDataFromServer) {
      print("frozen went wrong...!");
      if (userDataFromServer != null) {
        setState(() {
          print("beverages went wrong...!");
          beveragesList = userDataFromServer;
          beveragesqty =
              new List<int>.generate(beveragesList.items.length, (i) => 1);
          beveragesPrice =
              new List<double>.generate(beveragesList.items.length, (i) => 0.0);
        });
      } else {
        print("Somithing went wrong...!");
      }
    });
  }

  Future getFreshProduct() async {
    ApiRepository.loadhotSellingProduct(99, 10).then((userDataFromServer) {
      print("fresh fruits and vegetables went wrong...!");
      if (userDataFromServer != null) {
        setState(() {
          print("fresh fruits and vegetables went wrong...!");
          popularList = userDataFromServer;
          popularqty =
              new List<int>.generate(popularList.items.length, (i) => 1);
          popularPrice =
              new List<double>.generate(popularList.items.length, (i) => 0.0);
        });
      } else {
        print("Somithing went wrong...!");
      }
    });
  }

  callPrice() {
    for (int i = 0; i < productList.length; i++) {
      if (productList[i].typeId == "configurable") {
        getProductPrice(productList[i].sku, i);
      }
    }
  }

  getProductPrice(String sku, int i) async {
    print("inside...");
    print(baseUrl + 'rest/V1/configurable-products/$sku/children');
    final response = await http.get(Uri.parse(
      baseUrl + 'rest/V1/configurable-products/$sku/children'),
      headers: {"Content-Type": "application/json"},
    );
    final responseJson = json.decode(response.body);
    setState(() {
      var price = responseJson[0]['price'] + 0.0;

      productPrice.insert(i, price);
    });

    return;
  }

  Future getBestSellingList() async {
    ApiRepository.loadProductByCat(1516).then((userDataFromServer) {
      if (userDataFromServer != null) {
        setState(() {
          _progressController = false;
          bestSellingList = userDataFromServer;
          bestSellingqty =
              new List<int>.generate(bestSellingList.items.length, (i) => 1);
        });
      } else {
        print("Somithing went wrong...!");
      }
    });
  }

  Future getHotSellingList() async {
    ApiRepository.loadProductByCat(1517).then((userDataFromServer) {
      if (userDataFromServer != null) {
        setState(() {
          _progressController = false;
          topSellingList = userDataFromServer;
          hotProductQty =
              new List<int>.generate(topSellingList.items.length, (i) => 1);
        });
      } else {
        print("Something went wrong...!");
      }
    });
  }

  // Future getFreshFruitsList() async {
  //   ApiRepository.loadProductByCat(99).then((userDataFromServer) {
  //     if (userDataFromServer != null) {
  //       setState(() {
  //         _progressController = false;
  //         topFreshList = userDataFromServer;
  //         freshProductQty =
  //             new List<int>.generate(topFreshList.items.length, (i) => 1);
  //       });
  //     } else {
  //       print("Something went wrong in Fresh Fruits and Vegetables...!");
  //     }
  //   });
  // }

  // Future getHealthList() async {
  //   ApiRepository.loadProductByCat(314).then((userDataFromServer) {
  //     if (userDataFromServer != null) {
  //       setState(() {
  //         _progressController = false;
  //         topHealthList = userDataFromServer;
  //         healthProductQty =
  //             new List<int>.generate(topHealthList.items.length, (i) => 1);
  //       });
  //     } else {
  //       print("Something went wrong in Health Care Essentials section...!");
  //     }
  //   });
  // }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint(prefs.getBool('isLoggedIn').toString());
    final loginStatus = prefs.getBool('isLoggedIn');
    if (loginStatus == true) {
      print("logged user home");
      await listenForUserKey();
      await addCartUserQuote();
      await getUserCartList();
      await getUserInfo();
      HomePageState.isLogin = true;
    } else {
      print("guest user");
      await listenForGuestKey();
      await getGuestCartList();
      HomePageState.isLogin = false;
    }
    return prefs.getBool('isLoggedIn');
  }

  Future<http.Response> listenForGuestKey() async {
    print("guest key");
    // var url = 'https://aswaqrak.ae/rest/V1/guest-carts';
    http: //alaswaq1.bgm.me/
    var url = baseUrl + 'rest/V1/guest-carts';
    var response =
        await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('guestKey', response.body);
    String token = prefs.getString('guestKey');
    print("guest key");
    print("${token}");
    return response;
  }

  Future<http.Response> listenForAdminKey() async {
    var url = baseUrl + 'rest/V1/integration/admin/token';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
//      "username": "alaswaq1_api",
//      "password": "Nexa.2020",
      "username": "alaswaq_api",
      "password": "Nexa.2020",
    };
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    prefs.setString('adminKey', response.body);
    String token = prefs.getString('adminKey');
    print("admin key");
    print(token);
//    getPopularList(token);
//    getbestSelling(token);
    return response;
  }

  Future<http.Response> listenForUserKey() async {
    var url = baseUrl + 'rest/V1/integration/customer/token';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('email');
    String password = prefs.getString('password');
    print("listen for user key");
    print(username);
    print(password);
    Map data = {"username": username, "password": password};

//    Map data =  {
//      "username": "abc@abc.abc",
//      "password": "Qwerty1@"
//    };

    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    prefs.setString('userKey', response.body);
    String token = prefs.getString('userKey');
    print("user key");
    print("${token}");
    return response;
  }

  Future addCartUserQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;

    final response = await http.post(Uri.parse(
      'http://aswaqrak.ae/rest/V1/carts/mine'),
      headers: {HttpHeaders.authorizationHeader: headerText},
    );
    final responseJson = json.decode(response.body);
    prefs.setString('userQuoteId', response.body);
    return response;
  }

  Future addCartGuest(String skuVAl, int qty) async {
    print("testttt");
    _key.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.white,
      duration: new Duration(seconds: 2),
      content: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // new SpinKitPulse(
          //   color: Colors.red,
          //   size: 50.0,
          // ),
          Center(
              child: Image.asset(
            "assets/images/icons/loadingicon2.gif",
            height: 60.0,
            width: 60.0,
          )),
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
    print(qty);
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
    print("dce");
    _key.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.white,
      duration: new Duration(seconds: 2),
      content: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Image.asset(
            "assets/images/icons/loadingicon2.gif",
            height: 60.0,
            width: 60.0,
          )),
          // new SpinKitPulse(
          //   color: Colors.red,
          //   size: 50.0,
          // ),
          new Text(
            "  Adding to cart..",
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
    print("cart total");
    print(responseJson);
//      MainHome.cartListModel =  CartListModel.fromJson(responseJson);
  }

  Future totalUserCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
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
    print(response);
    var count = responseJson.length;
    print("cart count");
    print(count);
    setState(() {
      HomePage.cartCount = responseJson.length;
    });
//    totalUserCart();
  }

  // ignore: missing_return
  Future<bool> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('firstname');
    });
  }

  void logoutUser() {
    setState(() async {
      print("inside logoutt");
      HomePageState.isLogin = false;
      HomePage.cartCount = 0;
      final pref = await SharedPreferences.getInstance();
      await pref.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    });
  }
}

Future<bool> isInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }
}
