import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:Alaswaq/Model/product_list_model.dart';
import 'package:Alaswaq/common/drawer.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input4.dart';
import 'package:Alaswaq/payment/checkout.dart';
import 'package:Alaswaq/payment/shopping_cart.dart';
import 'package:Alaswaq/product/filter/filters.dart';
import 'package:Alaswaq/product/search/search_from_home.dart';
import 'package:Alaswaq/product/single_product/single_product.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:Alaswaq/account/login/login_page.dart';

class PriceSearch extends StatefulWidget {
  String searchUrl;
  // ProductListModel productList;
  PriceSearch(this.searchUrl);

  PriceSearchState createState() => PriceSearchState();
}

class PriceSearchState extends State<PriceSearch> {
  TextEditingController editingController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  GlobalKey<ScaffoldState> _key = GlobalKey();
  int _selectedIndex = 0;
  bool _progressController = true;
  var pressedIndex = 0;
  var productqty = [];
  var isLogin = true;
  var productPrice = [];
  var currentPage = 1;
  var currentProductCount = 24;
  bool isBottom = false;
  bool isloading = false;
  ProductListModel productList;
  ScrollController _controller = new ScrollController();
  var action = "product";
  bool _progressPriceController = true;
  List<String> get allOptionPrice => null;
  List<int> get listID => null;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  _onPressed(int index) {
    setState(() => pressedIndex = index);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getProductList();
    });
    _controller.addListener(() {
      // reached bottom
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() => isBottom = true);
      }

      // IS SCROLLING
      if (_controller.offset >= _controller.position.minScrollExtent &&
          _controller.offset < _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() {
          isBottom = false;
        });
      }

      // REACHED TOP
      if (_controller.offset <= _controller.position.minScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() => isBottom = false);
      }
    });
    // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
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
            Icons.arrow_back,
            color: Colors.black87,
            size: 30,
          ),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 40,
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
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: HexColor("A3A3A3"), width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: HexColor("A3A3A3"), width: 0.5),
              ),
              hintText: "Search your products",
            ),
            style: TextStyle(
                fontSize: 13, fontFamily: 'lato' // This is not so important
                ),
//
          ),
        ),
//        Text(
//          'Search Products',
//          style: TextStyle( fontFamily: 'montserrat',
//              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
//        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.blue,
            ),
            onPressed: null,
          ),
          Center(
            child: GestureDetector(
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
                      height: 35,
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
          ),
        ],
      ),
      body: _progressController
          ? Center(
              child: Image.asset(
                "assets/images/icons/loadingicon2.gif",
                height: 60.0,
                width: 60.0,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            productList.totalCount.toString() +
                                ' Results Found',
                            style: TextStyle(
                                fontFamily: 'montserrat', fontSize: 12),
                          ),
                        ),
                        Row(
                          children: [
                            // GestureDetector(
                            //   onTap: () {
                            //     _key.currentState
                            //         .showBottomSheet((context) => Filters("From Price Search", 80.toString(), allOptionPrice,listID));
                            //   },
                            //   child: Image.asset(
                            //     'assets/images/icons/icon.png',
                            //     height: 20,
                            //   ),
                            // ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              'assets/images/icons/icon2.png',
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * .79,
//              height: 242,
//                      width: 100,

                      child: Stack(
                        children: [
                          GridView.builder(
                            padding: const EdgeInsets.all(1),
                            shrinkWrap: true,
                            controller: _controller,
                            scrollDirection: Axis.vertical,
                            itemCount: productList.items.length,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
//                  childAspectRatio: 16 / 20,
                              childAspectRatio: 18 / 30,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                            ),
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
                                              Products(
                                                  productList.items,
                                                  index,
                                                  productList.items[index].sku,
                                                  productList
                                                      .items[index].price,
                                                  "normal"),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.white,
//                                color: Color(0xFFFAFAFA),
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
//                                                productList
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
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.contain,
                                                  imageUrl:
                                                      "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                          productList
                                                              .items[index]
                                                              .mediaGalleryEntries[
                                                                  0]
                                                              .file,
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
//                                                productList
//                                                    .items[index]
//                                                    .mediaGalleryEntries[0]
//                                                    .file,fit: BoxFit.fill,
//                                          ),
//                                        ),
//                                  Positioned(
//                                    top: 10.0,
//                                    left: 5.0,
//                                    child: Image.asset(
//                                      'assets/images/icons/save.png',
//                                      height: 15,
//                                      fit: BoxFit.cover,
//                                    ),
//                                  ),
//                                  Positioned(
//                                    top: 10.0,
//                                    right: 5.0,
//                                    child: Image.asset(
//                                      'assets/images/icons/love.png',
//                                      height: 15,
////                                        color: Colors.white,
//                                    ),
//                                  ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'AED ' +
                                                    productList
                                                        .items[index].price
                                                        .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'montserrat',
                                                    fontSize: 14,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                          Flexible(
                                            child: Container(
                                              width: 100,
                                              padding: EdgeInsets.only(
                                                  left: 5,
                                                  right: 5,
                                                  top: 5,
                                                  bottom: 5),
                                              child: Text(
                                                productList.items[index].name
                                                    .toString()
                                                    .substring(0, 9),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                              ),
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
                                                  .3,
                                              // fixed width and height
                                              child:
                                                  NumberInputWithIncrementDecrement4(
                                                controller:
                                                    TextEditingController(),
                                                min: 0,
                                                max: 100,
                                                onIncrement: (num newVal) {
                                                  setState(() {
                                                    productqty[index] = newVal;
                                                  });
                                                },
                                                onDecrement: (num
                                                    newlyDecrementedValue) {
                                                  setState(() {
                                                    productqty[index] =
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
                                                                Radius.circular(
                                                                    1)),
                                                        border: Border.all(
                                                          color: Colors.black26,
                                                          width: 1,
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                                            builder:
                                                                (context) =>
                                                                    LogInPage(
                                                                        1)));
                                                    // await addCartGuest(
                                                    //     productList
                                                    //         .items[index].sku);
//                                            HomePageState.productqty[index]);
//
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                                  } else {
                                                    await addCartUser(
                                                        productList
                                                            .items[index].sku);
//                                            HomePageState.productqty[index]);
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
                                                  style: TextStyle(
                                                      fontFamily: 'montserrat',
                                                      color: HexColor('302c98'),
//                                                fontWeight: FontWeight.bold,
                                                      fontSize: 8),
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
                          isBottom
                              ? Positioned(
                                  bottom: 0,
                                  left: 18,
                                  right: 18,
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: HexColor("302c98"),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: SizedBox(
                                        width: double.infinity, // match_parent
                                        child: FlatButton(
                                            onPressed: () async {
                                              setState(() {
                                                currentPage = currentPage + 1;
                                                currentProductCount =
                                                    currentPage * 24;
                                                isloading = true;
                                              });
                                              getProductList();
                                            },
                                            child: isloading
                                                ? Text('Loading...',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14))
                                                : Text(
                                                    'Load more',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  )),
                                      )))
                              : Container()
                        ],
                      )),
                ],
              ),
            ),
    );
  }

  getProductList() async {
    try {
      var url = widget.searchUrl +
          '&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[pageSize]=$currentProductCount';
      var response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        _progressController = false;
        final responseJson = json.decode(response.body);
        print("meat listing response");
        print(responseJson);
        setState(() {
          productList = ProductListModel.fromJson(responseJson);
          numberController.text = "0";
          productqty =
              new List<int>.generate(productList.items.length, (i) => 1);
          productPrice =
              new List<double>.generate(productList.items.length, (i) => 0.0);
          _progressController = false;
        });

        callPrice();
        debugPrint('after parsing');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  callPrice() async {
    setState(() {
      _progressPriceController = false;
    });

    for (int i = 0; i < productList.items.length; i++) {
      if (productList.items[i].typeId == "configurable") {
        setState(() {
          _progressPriceController = true;
        });

        getProductPrice(productList.items[i].sku, i);
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
      _progressPriceController = false;
      productPrice.insert(i, price);
    });

    return;
  }

  Future addCartGuest(String skuVAl) async {
    print(" this nis sku val in main");
    print(skuVAl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    var url = baseUrl + 'rest/V1/guest-carts/$token2/items';
    print(url);

    Map data = {
      "cartItem": {"quote_id": token2, "sku": skuVAl, "qty": 1}
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

  Future addCartUser(String skuVAl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;

    Map data = {
      "cartItem": {"quote_id": quoteId, "sku": skuVAl, "qty": 1}
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
    setState(() {
      HomePage.cartCount = responseJson.length;
    });
  }

  Future getGuestCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    final response = await http.get(Uri.parse(
      baseUrl + 'guest-carts/$token2/items'),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
    );
    final responseJson = json.decode(response.body);
    setState(() {
      HomePage.cartCount = responseJson.length;
    });
  }
}
