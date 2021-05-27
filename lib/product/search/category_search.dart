import 'dart:convert';
import 'dart:io';
import 'package:Alaswaq/account/login/login_page.dart';
import 'package:Alaswaq/Model/category_model.dart';
import 'package:Alaswaq/Model/product_list_model.dart';
import 'package:Alaswaq/Network/api_repository.dart';
import 'package:Alaswaq/common/drawer.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input4.dart';
import 'package:Alaswaq/payment/shopping_cart.dart';
import 'package:Alaswaq/product/filter/filters.dart';
import 'package:Alaswaq/product/search/search_from_home.dart';
import 'package:Alaswaq/product/single_product/configurable_single_product.dart';
import 'package:Alaswaq/product/single_product/single_product.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class categorySearch extends StatefulWidget {
  ProductListModel productList;
  categorySearch(this.productList);

  @override
  categorySearchState createState() => categorySearchState();
}

class categorySearchState extends State<categorySearch> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static var productType = [];
//  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController editingController = TextEditingController();
  static var productPrice = [];
  int _selectedIndex = 0;
  var pressedIndex = 0;
  var productqty = [];
  List<int> level1CatId = [];
  List<String> catName = [];

  var isLogin = false;
  static var allOptionPrice = [];
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  _onPressed(int index) {
    setState(() => pressedIndex = index);
  }

  static ProductListModel productList;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      isLoggedIn();
//      await  getProductList(
//          widget.categoryId);

      widget.productList = widget.productList;
    });
    // Setting the initial value for the field.
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      key: _key,
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
      body: SingleChildScrollView(
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
                      widget.productList.items.length.toString() +
                          ' Results Found',
                      style: TextStyle(fontFamily: 'montserrat', fontSize: 12),
                    ),
                  ),
//                  Row(
//                    children: [
//                      GestureDetector(
//                        onTap: () async {
//                          setState(() {
//                            _progressController = true;
//                          });
//
//                          await getCategoryList();
//
//
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
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .82,
//              height: 242,
//                      width: 100,

              child: GridView.builder(
                padding: const EdgeInsets.all(1),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: widget.productList.items.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
//                  childAspectRatio: 16 / 20,
                  childAspectRatio: 18 / 34,
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
                                      widget.productList.items,
                                      index,
                                      widget.productList.items[index].sku,
                                      widget.productList.items[index].price,
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
//                                                widget.productList
//                                                    .items[index]
//                                                    .c[0]
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
                                      imageUrl: widget.productList.items[index]
                                                  .mediaGalleryEntries.length >
                                              0
                                          ? "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                              widget.productList.items[index]
                                                  .mediaGalleryEntries[0].file
                                          : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                      placeholder: (context, url) => Center(
                                        child: Image.asset(
                                          "assets/images/icons/loadingicon2.gif",
                                          height: 60.0,
                                          width: 60.0,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
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
//                                                widget.widget.productList
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
                                    'AED ' + productPrice[index].toString(),
                                    style: TextStyle(
                                        fontFamily: 'montserrat',
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
//                                  Text('/kg',style: GoogleFonts.openSans(
//                                    textStyle: TextStyle( fontFamily: 'montserrat',
//                                      fontSize: 12,
//                                      color: Colors.black87,
//                                    ),
//                                  ),),
                                ],
                              ),
//                                    Padding(
//                                      padding: EdgeInsets.only(left: 10,right: 10),
//                                      child:
//                                    ),
//                              Flexible(
//                                child: Container(
//                                  width: 100,
//                                  padding: EdgeInsets.only(
//                                      left: 5, right: 5,top: 5,bottom: 5),
//                                  child: Text(
//                                    widget.productList.items[index].name
//                                        .toString().substring(0,9),
//                                    textAlign: TextAlign.center,
//                                    overflow: TextOverflow.clip,
//                                  ),
//                                ),
//                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 20,
                                height: 44,
                                child: Text(
                                  widget.productList.items[index].name,
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
                                  width: MediaQuery.of(context).size.width * .3,
                                  // fixed width and height
                                  child: NumberInputWithIncrementDecrement4(
                                    controller: TextEditingController(),
                                    min: 1,
                                    max: 100,
                                    onIncrement: (num newVal) {
                                      setState(() {
                                        productqty[index] = newVal;
                                      });
                                    },
                                    onDecrement: (num newlyDecrementedValue) {
                                      setState(() {
                                        productqty[index] =
                                            newlyDecrementedValue;
                                      });
                                    },
                                    numberFieldDecoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    decIconColor: HexColor('e25814'),
                                    widgetContainerDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
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
                                        fontFamily: 'montserrat', fontSize: 15),
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
                                width: MediaQuery.of(context).size.width * .27,
                                decoration: BoxDecoration(
//                                            color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(1),
                                  border: Border.all(
                                      width: 1, color: HexColor('302c98')),
                                ),
                                child: FlatButton(
                                    onPressed: () async {
                                      if (!HomePageState.isLogin) {
                                        if (widget.productList.items[index]
                                                .typeId ==
                                            "configurable") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ConfirabaleProducts(
                                                        widget.productList,
                                                        index,
                                                        widget.productList
                                                            .items[index].sku,
                                                        productPrice[index],
                                                        "configurable")),
                                          );
                                        } else {
                                          // await addCartGuest(
                                          //     widget
                                          //         .productList.items[index].sku,
                                          //     productqty[index]);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LogInPage(1)));
                                        }
                                      } else {
                                        if (widget.productList.items[index]
                                                .typeId ==
                                            "configurable") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Products(
                                                          productList.items,
                                                          index,
                                                          productList
                                                              .items[index].sku,
                                                          productPrice[index],
                                                          "configurable")));
                                        } else {
                                          await addCartUser(
                                              widget
                                                  .productList.items[index].sku,
                                              productqty[index]);
                                          ;
                                        }
//
                                      }
//
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
            ),
          ],
        ),
      ),
    );
  }

  bool isloggedIn = false;

//   Future getProductList(int catId) async {
//     ApiRepository.loadhotSellingProduct(catId).then((userDataFromServer) {
//       if (userDataFromServer != null) {
//         setState(() {
//           productList = userDataFromServer;
//           productqty = new List<int>.generate(productList.totalCount, (i) =>  1);
//
//         });
//         print(productList.totalCount);
//         for(int i = 0; i<productList.totalCount; i++ ){
//           print("sdfevfd");
//           if(productList.items[i].typeId == "configurable") {
//             setState(() {
//               getProductPrice(productList.items[i].sku);
//               productType.add("configurable");
//             });
//
//           } else {
//             setState(() {
//               productPrice.add(productList.items[i].price);
// //              productSku.add(widget.productList.items[i].sku);
//               productType.add("normal");
//             });
//           }
//         }
//       } else {
//         print("Somithing went wrong..s.!");
//       }
//     }
//     );
//   }
  Future getProductPrice(String sku) async {
    print(baseUrl + 'rest/V1/configurable-products/$sku/children');
    final response = await http.get(Uri.parse(
      baseUrl + 'rest/V1/configurable-products/$sku/children'),
      headers: {"Content-Type": "application/json"},
    );
    final responseJson = json.decode(response.body);
    var count = responseJson.length;
    print(count);
    print("pricdddde");
    print(responseJson[0]['price']);

//    PriceModel priceList =   PriceModel.fromJson(responseJson);
    print("pricdddde");
    setState(() {
      productPrice.add(responseJson[0]['price']);
      productType.add("configurable");

      if (responseJson[0]['sku'] != null) {
        allOptionPrice.add(responseJson[0]['price']);
      }
      if (responseJson[1]['sku'] != null) {
        allOptionPrice.add(responseJson[1]['price']);
      }
      if (responseJson[2]['sku'] != null) {
        allOptionPrice.add(responseJson[2]['price']);
      }
      if (responseJson[3]['sku'] != null) {
        allOptionPrice.add(responseJson[3]['price']);
      }
      if (responseJson[4]['sku'] != null) {
        allOptionPrice.add(responseJson[4]['price']);
      }
      if (responseJson[5]['sku'] != null) {
        allOptionPrice.add(responseJson[5]['price']);
      }
      if (responseJson[6]['sku'] != null) {
        allOptionPrice.add(responseJson[6]['price']);
      }
      if (responseJson[7]['sku'] != null) {
        allOptionPrice.add(responseJson[7]['price']);
      }
      if (responseJson[8]['sku'] != null) {
        allOptionPrice.add(responseJson[8]['price']);
      }
    });

    debugPrint('after parsing price allOptionPrice');
    print(productPrice.length);

    print(allOptionPrice.length);
  }

//  Future getProductPrice(String sku) async {
//
//    print(baseUrl + 'rest/V1/configurable-products/$sku/children');
//    final response = await http.get(
//      baseUrl + 'rest/V1/configurable-products/$sku/children',
//      headers: {
//        "Content-Type": "application/json"
//      },
//    );
//    final responseJson = json.decode(response.body);
//    var count = responseJson.length;
//    print(count);
//    print("pricdddde");
//    print(responseJson[0]['price']);
//
////    PriceModel priceList =   PriceModel.fromJson(responseJson);
//    print("pricdddde");
//    setState(() {
//
//      productPrice.add(responseJson[0]['price']);
//
//      productType.add("configurable");
//
//      if(responseJson[0]['sku'] != null ){
//        allOptionPrice.add(responseJson[0]['price']);
//      }
//      if(responseJson[1]['sku'] != null ){
//        allOptionPrice.add(responseJson[1]['price']);
//      }
//      if(responseJson[2]['sku'] != null ){
//        allOptionPrice.add(responseJson[2]['price']);
//      }
//      if(responseJson[3]['sku'] != null ){
//        allOptionPrice.add(responseJson[3]['price']);
//      }
//      if(responseJson[4]['sku'] != null ){
//        allOptionPrice.add(responseJson[4]['price']);
//      }
//      if(responseJson[5]['sku'] != null ){
//        allOptionPrice.add(responseJson[5]['price']);
//      }if(responseJson[6]['sku'] != null ){
//        allOptionPrice.add(responseJson[6]['price']);
//      }
//      if(responseJson[7]['sku'] != null ){
//        allOptionPrice.add(responseJson[7]['price']);
//      }
//      if(responseJson[8]['sku'] != null ){
//        allOptionPrice.add(responseJson[8]['price']);
//      }
//
//
//    });
//
//    debugPrint('after parsing price allOptionPrice');
//    print(productPrice.length);
//
//    print(allOptionPrice.length);
//  }

  Future addCartGuest(String skuVAl, int qty) async {
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

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint(prefs.getBool('isLoggedIn').toString());
    final loginStatus = prefs.getBool('isLoggedIn');
    if (loginStatus == true) {
      print("for  listen user key  user");
//      await listenForUserKey();
//      await addCartUserQuote();
//      await getUserCartList();
//      await getUserInfo();
      isLogin = true;
      HomePageState.isLogin = true;
    } else {
      print("for  listen guest user");
//      await  listenForGuestKey();
//      await getGuestCartList();
      HomePageState.isLogin = false;
    }
    return prefs.getBool('isLoggedIn');
  }

//  Future<bool> isLoggedIn() async {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    debugPrint(prefs.getBool('isLoggedIn').toString());
//    final loginStatus = prefs.getBool('isLoggedIn');
//    print("logged staus");
//    print(loginStatus);
//    if (loginStatus == true) {
//      print("logged user");
//      setState(() {
//        isloggedIn = true;
//      });
//
//      await getUserCartList();
//    } else {
//      setState(() {
//        isloggedIn = false;
//      });
//
//      print("guest user");
//      await getGuestCartList();
//    }
//    return prefs.getBool('isLoggedIn');
////    await getUserCartList();
//  }
//
//  Future addCartGuest(String skuVAl, int qty) async {
//    _key.currentState.showSnackBar(new SnackBar(
//      duration: new Duration(seconds: 2),
//      content: new Row(
//        children: <Widget>[
//          new  SpinKitPulse(
//                                              color: Colors.red,
//                                              size: 50.0,
//                                            ),,
//          new Text("Adding to cart..")
//        ],
//      ),
//    ));
//    print(" this nis sku val in main");
//    print(qty);
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('guestKey');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    var url = baseUrl + 'rest/V1/guest-carts/$token2/items';
//    print(url);
//
//    Map data = {
//      "cartItem": {"quote_id": token2, "sku": skuVAl, "qty": qty}
//    };
//    //encode Map to JSON
//    var body = json.encode(data);
//    var response = await http.post(url,
//        headers: {"Content-Type": "application/json"}, body: body);
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
//    _key.currentState.showSnackBar(new SnackBar(
//      duration: new Duration(seconds: 2),
//      content: new Row(
//        children: <Widget>[
//          new  SpinKitPulse(
//                                              color: Colors.red,
//                                              size: 50.0,
//                                            ),,
//          new Text("Adding to cart..")
//        ],
//      ),
//    ));
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('userKey');
//    String quoteId = prefs.getString('userQuoteId');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//
//    Map data = {
//      "cartItem": {"quote_id": quoteId, "sku": skuVAl, "qty": qty}
//    };
//    //encode Map to JSON
//    var body = json.encode(data);
//
//    var response = await http.post(
//        baseUrl + 'rest/V1/carts/mine/items',
//        headers: {
//          "Content-Type": "application/json",
//          HttpHeaders.authorizationHeader: headerText
//        },
//        body: body);
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
//  Future getGuestCartList() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('guestKey');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//    print(baseUrl + 'rest/V1/guest-carts/$token2/items');
//    final response = await http.get(
//      baseUrl + 'rest/V1/guest-carts/$token2/items',
//      headers: {
//        "Content-Type": "application/json",
//        HttpHeaders.authorizationHeader: headerText
//      },
//    );
//    final responseJson = json.decode(response.body);
//    var count = responseJson.length;
//    print("number of items in cart");
//    print(count);
//    setState(() {
//      HomePage.cartCount = responseJson.length;
//    });
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
//    print("cart count");
//    print(count);
//    setState(() {
//      HomePage.cartCount = responseJson.length;
//    });
////    totalUserCart();
//  }
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

}
