import 'dart:convert';
import 'dart:io';
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
import 'package:Alaswaq/product/search/show_search_product_page.dart';
import 'package:Alaswaq/product/single_product/single_product.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static CategoryModel categoryList;
  List<int> level1CatId = [];
  List<String> catName = [];
  List<int> level2CatId = [];
  List<int> level3CatId = [];

  List<String> catLevel2 = [];
  List<String> catLevel3 = [];
  List<String> imagePaths = [
    'assets/images/icons/cat1.png',
    'assets/images/icons/cat2.png',
    'assets/images/icons/cat3.png',
    'assets/images/icons/cat4.png',
    'assets/images/icons/cat5.png',
    'assets/images/icons/cat6.png',
    'assets/images/icons/cat7.png',
    'assets/images/icons/cat8.png',
    'assets/images/icons/cat9.png'
  ];
  static var categoryQty = [];
//  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPressedSubCategory = false;
  bool isPressedSubCategory1 = false;
  bool isPressedSubCategory2 = false;
  bool isPressedSubCategory3 = false;
  bool isPressedSubCategory4 = false;
  bool isPressedSubCategory5 = false;
  bool isPressedSubCategory6 = false;
  bool isPressedSubCategory7 = false;
  bool isPressedSubCategory8 = false;
  bool isPressedSubCategory9 = false;
  bool isPressedSubCategory10 = false;
  int _selectedIndex = 0;
  int pressedIndex = 0;
  int level3Index = 0;
  int catId = 0;
  var firstIndex = 3;
  var meatqty = [];
  bool _progressController = true;
  var isLogin = false;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  _onlevel3Selected(int index) {
    setState(() => level3Index = index);
  }

  _onPressed(int index) {
    setState(() => pressedIndex = index);
  }

  ProductListModel productList;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getCategoryList();
//      await  isLoggedIn();
//
//      getProductList(
//          widget.categoryId);
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
      backgroundColor: Colors.white,
      key: _key,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: true,
        // hides leading widget
//        flexibleSpace: Container(),
//        leading: GestureDetector(
//          onTap: () {
//            Navigator.pop(context);
//          },
//          child: Icon(
//            Icons.keyboard_backspace,
//            color: Colors.black87,
//            size: 30,
//          ),
//        ),
        title: Text(
          'Categories',
          style: TextStyle(
              fontFamily: 'montserrat',
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        actions: [],
      ),
      body:
//      _progressController
//          ?  Center(
//        child:  SpinKitPulse(
//                                              color: Colors.red,
//                                              size: 50.0,
//                                            ),,
//      )
//          :
          SingleChildScrollView(
              child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 10),
                width: 115,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: 120.0,
                          height: 130.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              catName.length > 0
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              side: BorderSide(
                                                color: pressedIndex != null &&
                                                        pressedIndex == index
                                                    ? HexColor("302c98")
                                                    : Colors.transparent,
                                                width: 2.0,
                                              ),
                                            ),
                                            elevation: 5,
                                            clipBehavior: Clip.antiAlias,
//                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
                                            child: Container(
                                              height: 87,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4 -
                                                  30,
                                              alignment: Alignment.center,
                                              child: GestureDetector(
                                                onTap: () {
                                                  _progressController = true;
                                                  setState(() {
                                                    _onPressed(index);
                                                    catId = level1CatId[index];
                                                    getLevel2List(index + 3);
                                                    firstIndex = index + 3;
                                                  });
                                                },
                                                //padding: EdgeInsets.all(10.0),
                                                child: Image.asset(
                                                  imagePaths[index],
                                                  fit: BoxFit.contain,
                                                  height: 40,
                                                  width: 40,
//                              height: 50.0,
//                              color: pressed1 ? Colors.transparent : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          height: 35.0,
                                          child: Text(
//                                  catName[index],
                                            catName[index],
                                            maxLines: 2,

                                            style: TextStyle(
                                              fontFamily: 'montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    )
                                  : Image.asset(
                                      "assets/images/icons/loadingicon2.gif",
                                      height: 60.0,
                                      width: 60.0,
                                    ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

//                catLevel2.length > 0 ? Container(
//                  padding: EdgeInsets.only(
//                      left: 16.0, top: 0.0),
//                  height: 60,
//                  child: ListView.builder(
////                              shrinkWrap: true,
//                    scrollDirection: Axis.horizontal,
//                    itemCount: catLevel2.length, itemBuilder: (context, index) {
//                    return Builder(
//                      builder: (BuildContext context) {
//                        return Container(
//                          width: MediaQuery.of(context).size.width / 4 + 10,
//                          height: 50.0,
//
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment
//                                .spaceBetween,
//                            children: <Widget>[
//                              Card(
//                                shape:  RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(5.0),
//                                  side: BorderSide(
//                                    color: _selectedIndex != null &&
//                                        _selectedIndex == index
//                                        ? HexColor("302c98")
//                                        : Colors.transparent,
//                                    width: 2.0,
//                                  ),
//                                ),
//                                elevation: 5,
//                                clipBehavior: Clip.antiAlias,
////                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
//                                child: Container(
//                                  height: 50,
//                                  width: MediaQuery.of(context).size.width / 4 ,
//                                  alignment: Alignment.center,
//                                  child: GestureDetector(
//                                    onTap: () async {
//                                      setState(() {
//                                        _onSelected(index);
//                                        catId = level2CatId[index];
//
//                                      });
//                                      await getLevel3List(pressedIndex + 3 , _selectedIndex);
//
//                                    },
//                                    //padding: EdgeInsets.all(10.0),
//                                    child: Text(catLevel2[index],
//                                      style: TextStyle( fontFamily: 'montserrat',
//
//                                        color: Colors.black,
//                                        fontWeight: FontWeight.w400,
//                                        fontSize: 11,
//
//                                      ),
//                                      textAlign: TextAlign.center,
//                                    ),
//                                  ),
//                                ),
//                              ),
//
//
//
//                            ],
//                          ),
//
//                        );
//                      },
//                    );
//                  },
//                  ),
//                ) : Container(),
//                catLevel3.length > 0 ? Container(
//                  padding: EdgeInsets.only(
//                      left: 16.0, top: 0.0),
//                  height: 50,
//                  child: ListView.builder(
////                              shrinkWrap: true,
//                    scrollDirection: Axis.horizontal,
//                    itemCount: catLevel3.length, itemBuilder: (context, index) {
//                    return Builder(
//                      builder: (BuildContext context) {
//                        return Container(
////                      width: 100.0,
//                          height: 50.0,
//
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment
//                                .spaceBetween,
//                            children: <Widget>[
//                              Card(
//                                shape:  RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(5.0),
//                                  side: BorderSide(
//                                    color: level3Index != null &&
//                                        level3Index == index
//                                        ? HexColor("302c98")
//                                        : Colors.transparent,
//                                    width: 2.0,
//                                  ),
//                                ),
//                                elevation: 5,
//                                clipBehavior: Clip.antiAlias,
////                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
//                                child: Container(
//                                  height: 50,
//                                  width: MediaQuery.of(context).size.width / 4 ,
//                                  alignment: Alignment.center,
//                                  child: GestureDetector(
//
//                                    onTap: () async {
//                                      setState(() {
//                                        catId = level3CatId[index];
//                                        _onlevel3Selected(index);
//
//                                      });
//
//
//                                    },
//                                    //padding: EdgeInsets.all(10.0),
//
//                                    child: Text( catLevel3[index],
//                                      textAlign: TextAlign.center,
//                                      style: TextStyle( fontFamily: 'montserrat',
//
//                                        color: Colors.black,
//                                        fontWeight: FontWeight.w400,
//                                        fontSize: 11,
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ),
//
//
//
//                            ],
//                          ),
//
//                        );
//                      },
//                    );
//                  },
//                  ),
//                ) : Container(),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5.0, top: 20.0, bottom: 10),
                width: MediaQuery.of(context).size.width - 120,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: catLevel2.length,
                    itemBuilder: (context, index) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: 115.0,
//                height: categoryList.childrenData[firstIndex].childrenData[index].childrenData.length * 50 + 50.0,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                175,
                                        // height: 20,
                                        child: new GestureDetector(
                                          onTap: () {
                                            if (index == 0) {
                                              setState(() {
                                                isPressedSubCategory =
                                                    !isPressedSubCategory;
                                              });
                                            }

                                            if (index == 1) {
                                              setState(() {
                                                isPressedSubCategory1 =
                                                    !isPressedSubCategory1;
                                              });
                                            }

                                            if (index == 2) {
                                              setState(() {
                                                isPressedSubCategory2 =
                                                    !isPressedSubCategory2;
                                              });
                                            }
                                            if (index == 3) {
                                              setState(() {
                                                isPressedSubCategory3 =
                                                    !isPressedSubCategory3;
                                              });
                                            }
                                            if (index == 4) {
                                              setState(() {
                                                isPressedSubCategory4 =
                                                    !isPressedSubCategory4;
                                              });
                                            }

                                            if (index == 5) {
                                              setState(() {
                                                isPressedSubCategory5 =
                                                    !isPressedSubCategory5;
                                              });
                                            }
                                            if (index == 6) {
                                              setState(() {
                                                isPressedSubCategory6 =
                                                    !isPressedSubCategory6;
                                              });
                                            }
                                            if (index == 7) {
                                              setState(() {
                                                isPressedSubCategory7 =
                                                    !isPressedSubCategory7;
                                              });
                                            }
                                            if (index == 8) {
                                              setState(() {
                                                isPressedSubCategory8 =
                                                    !isPressedSubCategory8;
                                              });
                                            }
                                            if (index == 9) {
                                              setState(() {
                                                isPressedSubCategory9 =
                                                    !isPressedSubCategory9;
                                              });
                                            }

                                            if (index == 10) {
                                              setState(() {
                                                isPressedSubCategory10 =
                                                    !isPressedSubCategory10;
                                              });
                                            }
                                          },
                                          child: new Text(
                                            catLevel2[index],
//                                    overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'montserrat',
                                                fontSize: 14,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    index == 0
                                        ? IconButton(
                                            icon: isPressedSubCategory
                                                ? new Icon(
                                                    Icons.expand_less,
                                                    color: HexColor("649FC3"),
                                                  )
                                                : new Icon(
                                                    Icons.chevron_right,
                                                    color: HexColor("649FC3"),
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                isPressedSubCategory =
                                                    !isPressedSubCategory;
                                              });
                                            },
                                          )
                                        : Container(),
                                    index == 1
                                        ? IconButton(
                                            icon: isPressedSubCategory1
                                                ? new Icon(
                                                    Icons.expand_less,
                                                    color: HexColor("649FC3"),
                                                  )
                                                : new Icon(
                                                    Icons.chevron_right,
                                                    color: HexColor("649FC3"),
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                isPressedSubCategory1 =
                                                    !isPressedSubCategory1;
                                              });
                                            },
                                          )
                                        : Container(),
                                    index == 2
                                        ? IconButton(
                                            icon: isPressedSubCategory2
                                                ? new Icon(
                                                    Icons.expand_less,
                                                    color: HexColor("649FC3"),
                                                  )
                                                : new Icon(
                                                    Icons.chevron_right,
                                                    color: HexColor("649FC3"),
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                isPressedSubCategory2 =
                                                    !isPressedSubCategory2;
                                              });
                                            },
                                          )
                                        : Container(),
                                    index == 3
                                        ? IconButton(
                                            icon: isPressedSubCategory3
                                                ? new Icon(
                                                    Icons.expand_less,
                                                    color: HexColor("649FC3"),
                                                  )
                                                : new Icon(
                                                    Icons.chevron_right,
                                                    color: HexColor("649FC3"),
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                isPressedSubCategory3 =
                                                    !isPressedSubCategory3;
                                              });
                                            },
                                          )
                                        : Container(),
                                    index == 4
                                        ? IconButton(
                                            icon: isPressedSubCategory4
                                                ? new Icon(
                                                    Icons.expand_less,
                                                    color: HexColor("649FC3"),
                                                  )
                                                : new Icon(
                                                    Icons.chevron_right,
                                                    color: HexColor("649FC3"),
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                isPressedSubCategory4 =
                                                    !isPressedSubCategory4;
                                              });
                                            },
                                          )
                                        : Container(),
                                    index == 5
                                        ? IconButton(
                                            icon: isPressedSubCategory5
                                                ? new Icon(
                                                    Icons.expand_less,
                                                    color: HexColor("649FC3"),
                                                  )
                                                : new Icon(
                                                    Icons.chevron_right,
                                                    color: HexColor("649FC3"),
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                isPressedSubCategory5 =
                                                    !isPressedSubCategory5;
                                              });
                                            },
                                          )
                                        : Container(),
                                    index == 6
                                        ? IconButton(
                                            icon: isPressedSubCategory6
                                                ? new Icon(
                                                    Icons.expand_less,
                                                    color: HexColor("649FC3"),
                                                  )
                                                : new Icon(
                                                    Icons.chevron_right,
                                                    color: HexColor("649FC3"),
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                isPressedSubCategory6 =
                                                    !isPressedSubCategory6;
                                              });
                                            },
                                          )
                                        : Container(),
                                    index == 7
                                        ? IconButton(
                                            icon: isPressedSubCategory7
                                                ? new Icon(
                                                    Icons.expand_less,
                                                    color: HexColor("649FC3"),
                                                  )
                                                : new Icon(
                                                    Icons.chevron_right,
                                                    color: HexColor("649FC3"),
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                isPressedSubCategory7 =
                                                    !isPressedSubCategory7;
                                              });
                                            },
                                          )
                                        : Container(),
                                    index == 8
                                        ? IconButton(
                                            icon: isPressedSubCategory8
                                                ? new Icon(
                                                    Icons.expand_less,
                                                    color: HexColor("649FC3"),
                                                  )
                                                : new Icon(
                                                    Icons.chevron_right,
                                                    color: HexColor("649FC3"),
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                isPressedSubCategory8 =
                                                    !isPressedSubCategory8;
                                              });
                                            },
                                          )
                                        : Container(),
                                    index == 9
                                        ? IconButton(
                                            icon: isPressedSubCategory9
                                                ? new Icon(
                                                    Icons.expand_less,
                                                    color: HexColor("649FC3"),
                                                  )
                                                : new Icon(
                                                    Icons.chevron_right,
                                                    color: HexColor("649FC3"),
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                isPressedSubCategory9 =
                                                    !isPressedSubCategory9;
                                              });
                                            },
                                          )
                                        : Container(),
                                    index == 10
                                        ? IconButton(
                                            icon: isPressedSubCategory10
                                                ? new Icon(
                                                    Icons.expand_less,
                                                    color: HexColor("649FC3"),
                                                  )
                                                : new Icon(
                                                    Icons.chevron_right,
                                                    color: HexColor("649FC3"),
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                isPressedSubCategory10 =
                                                    !isPressedSubCategory10;
                                              });
                                            },
                                          )
                                        : Container(),
                                  ],
                                ),
                                index == 0 && isPressedSubCategory
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryList
                                            .childrenData[firstIndex]
                                            .childrenData[index]
                                            .childrenData
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 115.0,
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              175,
                                                          height: 50,
                                                          child:
                                                              GestureDetector(
                                                            child: Text(
                                                              "   " +
                                                                  categoryList
                                                                      .childrenData[
                                                                          firstIndex]
                                                                      .childrenData[
                                                                          index]
                                                                      .childrenData[
                                                                          index2]
                                                                      .name,
//                                    overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ShowSearchProductPage(
                                                                        categoryId: categoryList
                                                                            .childrenData[
                                                                                firstIndex]
                                                                            .childrenData[
                                                                                index]
                                                                            .childrenData[
                                                                                index2]
                                                                            .id,
                                                                        name:
                                                                            "All"))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        })
                                    : Container(),
                                index == 1 && isPressedSubCategory1
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryList
                                            .childrenData[firstIndex]
                                            .childrenData[index]
                                            .childrenData
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 115.0,
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              175,
                                                          height: 50,
                                                          child:
                                                              GestureDetector(
                                                            child: Text(
                                                              "   " +
                                                                  categoryList
                                                                      .childrenData[
                                                                          firstIndex]
                                                                      .childrenData[
                                                                          index]
                                                                      .childrenData[
                                                                          index2]
                                                                      .name,
//                                    overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ShowSearchProductPage(
                                                                        categoryId: categoryList
                                                                            .childrenData[
                                                                                firstIndex]
                                                                            .childrenData[
                                                                                index]
                                                                            .childrenData[
                                                                                index2]
                                                                            .id,
                                                                        name:
                                                                            "All"))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        })
                                    : Container(),
                                index == 2 && isPressedSubCategory2
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryList
                                            .childrenData[firstIndex]
                                            .childrenData[index]
                                            .childrenData
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 115.0,
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              175,
                                                          height: 50,
                                                          child:
                                                              GestureDetector(
                                                            child: Text(
                                                              "   " +
                                                                  categoryList
                                                                      .childrenData[
                                                                          firstIndex]
                                                                      .childrenData[
                                                                          index]
                                                                      .childrenData[
                                                                          index2]
                                                                      .name,
//                                    overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ShowSearchProductPage(
                                                                        categoryId: categoryList
                                                                            .childrenData[
                                                                                firstIndex]
                                                                            .childrenData[
                                                                                index]
                                                                            .childrenData[
                                                                                index2]
                                                                            .id,
                                                                        name:
                                                                            "All"))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        })
                                    : Container(),
                                index == 3 && isPressedSubCategory3
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryList
                                            .childrenData[firstIndex]
                                            .childrenData[index]
                                            .childrenData
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 115.0,
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              175,
                                                          height: 50,
                                                          child:
                                                              GestureDetector(
                                                            child: Text(
                                                              "   " +
                                                                  categoryList
                                                                      .childrenData[
                                                                          firstIndex]
                                                                      .childrenData[
                                                                          index]
                                                                      .childrenData[
                                                                          index2]
                                                                      .name,
//                                    overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ShowSearchProductPage(
                                                                        categoryId: categoryList
                                                                            .childrenData[
                                                                                firstIndex]
                                                                            .childrenData[
                                                                                index]
                                                                            .childrenData[
                                                                                index2]
                                                                            .id,
                                                                        name:
                                                                            "All"))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        })
                                    : Container(),
                                index == 4 && isPressedSubCategory4
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryList
                                            .childrenData[firstIndex]
                                            .childrenData[index]
                                            .childrenData
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 115.0,
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              175,
                                                          height: 50,
                                                          child:
                                                              GestureDetector(
                                                            child: Text(
                                                              "   " +
                                                                  categoryList
                                                                      .childrenData[
                                                                          firstIndex]
                                                                      .childrenData[
                                                                          index]
                                                                      .childrenData[
                                                                          index2]
                                                                      .name,
//                                    overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ShowSearchProductPage(
                                                                        categoryId: categoryList
                                                                            .childrenData[
                                                                                firstIndex]
                                                                            .childrenData[
                                                                                index]
                                                                            .childrenData[
                                                                                index2]
                                                                            .id,
                                                                        name:
                                                                            "All"))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        })
                                    : Container(),
                                index == 5 && isPressedSubCategory5
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryList
                                            .childrenData[firstIndex]
                                            .childrenData[index]
                                            .childrenData
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 115.0,
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              175,
                                                          height: 50,
                                                          child:
                                                              GestureDetector(
                                                            child: Text(
                                                              "   " +
                                                                  categoryList
                                                                      .childrenData[
                                                                          firstIndex]
                                                                      .childrenData[
                                                                          index]
                                                                      .childrenData[
                                                                          index2]
                                                                      .name,
//                                    overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ShowSearchProductPage(
                                                                        categoryId: categoryList
                                                                            .childrenData[
                                                                                firstIndex]
                                                                            .childrenData[
                                                                                index]
                                                                            .childrenData[
                                                                                index2]
                                                                            .id,
                                                                        name:
                                                                            "All"))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        })
                                    : Container(),
                                index == 6 && isPressedSubCategory6
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryList
                                            .childrenData[firstIndex]
                                            .childrenData[index]
                                            .childrenData
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 115.0,
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              175,
                                                          height: 50,
                                                          child:
                                                              GestureDetector(
                                                            child: Text(
                                                              "   " +
                                                                  categoryList
                                                                      .childrenData[
                                                                          firstIndex]
                                                                      .childrenData[
                                                                          index]
                                                                      .childrenData[
                                                                          index2]
                                                                      .name,
//                                    overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ShowSearchProductPage(
                                                                        categoryId: categoryList
                                                                            .childrenData[
                                                                                firstIndex]
                                                                            .childrenData[
                                                                                index]
                                                                            .childrenData[
                                                                                index2]
                                                                            .id,
                                                                        name:
                                                                            "All"))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        })
                                    : Container(),
                                index == 7 && isPressedSubCategory7
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryList
                                            .childrenData[firstIndex]
                                            .childrenData[index]
                                            .childrenData
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 115.0,
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              175,
                                                          height: 50,
                                                          child:
                                                              GestureDetector(
                                                            child: Text(
                                                              "   " +
                                                                  categoryList
                                                                      .childrenData[
                                                                          firstIndex]
                                                                      .childrenData[
                                                                          index]
                                                                      .childrenData[
                                                                          index2]
                                                                      .name,
//                                    overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ShowSearchProductPage(
                                                                        categoryId: categoryList
                                                                            .childrenData[
                                                                                firstIndex]
                                                                            .childrenData[
                                                                                index]
                                                                            .childrenData[
                                                                                index2]
                                                                            .id,
                                                                        name:
                                                                            "All"))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        })
                                    : Container(),
                                index == 8 && isPressedSubCategory8
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryList
                                            .childrenData[firstIndex]
                                            .childrenData[index]
                                            .childrenData
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 115.0,
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              175,
                                                          height: 50,
                                                          child:
                                                              GestureDetector(
                                                            child: Text(
                                                              "   " +
                                                                  categoryList
                                                                      .childrenData[
                                                                          firstIndex]
                                                                      .childrenData[
                                                                          index]
                                                                      .childrenData[
                                                                          index2]
                                                                      .name,
//                                    overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ShowSearchProductPage(
                                                                        categoryId: categoryList
                                                                            .childrenData[
                                                                                firstIndex]
                                                                            .childrenData[
                                                                                index]
                                                                            .childrenData[
                                                                                index2]
                                                                            .id,
                                                                        name:
                                                                            "All"))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        })
                                    : Container(),
                                index == 9 && isPressedSubCategory9
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryList
                                            .childrenData[firstIndex]
                                            .childrenData[index]
                                            .childrenData
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 115.0,
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              175,
                                                          height: 50,
                                                          child:
                                                              GestureDetector(
                                                            child: Text(
                                                              "   " +
                                                                  categoryList
                                                                      .childrenData[
                                                                          firstIndex]
                                                                      .childrenData[
                                                                          index]
                                                                      .childrenData[
                                                                          index2]
                                                                      .name,
//                                    overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ShowSearchProductPage(
                                                                        categoryId: categoryList
                                                                            .childrenData[
                                                                                firstIndex]
                                                                            .childrenData[
                                                                                index]
                                                                            .childrenData[
                                                                                index2]
                                                                            .id,
                                                                        name:
                                                                            "All"))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        })
                                    : Container(),
                                index == 10 && isPressedSubCategory10
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryList
                                            .childrenData[firstIndex]
                                            .childrenData[index]
                                            .childrenData
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 115.0,
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              175,
                                                          height: 50,
                                                          child:
                                                              GestureDetector(
                                                            child: Text(
                                                              "   " +
                                                                  categoryList
                                                                      .childrenData[
                                                                          firstIndex]
                                                                      .childrenData[
                                                                          index]
                                                                      .childrenData[
                                                                          index2]
                                                                      .name,
//                                    overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'montserrat',
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ShowSearchProductPage(
                                                                        categoryId: categoryList
                                                                            .childrenData[
                                                                                firstIndex]
                                                                            .childrenData[
                                                                                index]
                                                                            .childrenData[
                                                                                index2]
                                                                            .id,
                                                                        name:
                                                                            "All"))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        })
                                    : Container(),
                              ],
                            ),
                          );
                        },
                      );
                    }),
//                verticalSpace(),
//                Container(
////                    height: MediaQuery.of(context).size.height*.4,
//                  height: 280,
////                      width: 100,
//
//                  child: ListView.builder(
//                    padding: const EdgeInsets.only(right: 10,bottom: 20),
//                    shrinkWrap: true,
//                    scrollDirection: Axis.horizontal,
//                    itemCount: 10,
//                    itemBuilder: (context, index) {
////                          return Container(
////                            height: 50,
////                            width: 200,
////                            color: Colors.amber[colorCodes[index]],
////                            child:
////                                Center(child: Text('Entry ${entries[index]}')),
////                          );
//                      return Row(
//                        children: [
//                          InkWell(
//                            onTap: () {
////                              Navigator.push(
////                                context,
////                                MaterialPageRoute(
////                                  builder: (context) =>
//////                                            Products("1","1",2.0, "1","1"),
////                                  PopularProducts(popularList, index,
////                                      popularList.items[index].sku, popularList.items[index].price, "normal", popularListImage[index]),
////                                ),
////                              );
//                            },
//                            child: Card(
//                              color: Colors.white,
////                                color: Color(0xFFFAFAFA),
//                              semanticContainer: true,
//                              clipBehavior: Clip.antiAliasWithSaveLayer,
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(5.0),
//                              ),
//                              elevation: 5,
////                                margin: EdgeInsets.all(10),
//                              child: Column(
//                                children: [
//                                  Stack(
//                                    children: [
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
//                                      Container(
//                                        width: 160,
//                                        height: 120,
//                                        child: CachedNetworkImage(
////                                          width: 200,
//                                          fit: BoxFit.contain,
//                                          imageUrl:  "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
//
////
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                  SizedBox(
//                                    height: 2,
//                                  ),
//                                  Row(
//                                    children: [
//                                      Text(
//                                        'AED '
//                                        ,
//                                        style: GoogleFonts.openSans(
//                                          textStyle: TextStyle( fontFamily: 'montserrat',
//                                              fontSize: 14,
//                                              color: Colors.black87,
//                                              fontWeight: FontWeight.bold),
//                                        ),
//                                      ),
////                                        Text(
////                                          '/kg',
////                                          style: GoogleFonts.openSans(
////                                            textStyle: TextStyle( fontFamily: 'montserrat',
////                                              fontSize: 12,
////                                              color: Colors.black87,
////                                            ),
////                                          ),
////                                        ),
//                                    ],
//                                  ),
////                                    Padding(
////                                      padding: EdgeInsets.only(left: 10,right: 10),
////                                      child:
////                                    ),
////                                    Flexible(
////                                      child: Container(
////                                        width: 100,
////                                        padding: EdgeInsets.only(
////                                            left: 5,
////                                            right: 5,
////                                            top: 5,
////                                            bottom: 5),
////                                        child:
//                                  SizedBox(
//                                    width: 160,
//                                    height: 44,
//                                    child:  Text(
//                                      'popularList.items[index].name',
//                                      maxLines: 2,
//                                      textAlign: TextAlign.center,
//                                      overflow: TextOverflow.clip,
//                                    ),
//                                  ),
//
////                                      ),
////                                    ),
//                                  Align(
//                                    alignment: Alignment.center,
//                                    child: Container(
//                                      padding: EdgeInsets.only(left: 5),
//                                      height: 25.0,
//                                      width: MediaQuery.of(context)
//                                          .size
//                                          .width *
//                                          .4,
//                                      // fixed width and height
////                                      child:
//
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  Container(
//                                    height: 27,
//                                    width:
//                                    MediaQuery.of(context).size.width *
//                                        .37,
//                                    decoration: BoxDecoration(
//                                      color: HexColor("302c98"),
//                                      borderRadius:
//                                      BorderRadius.circular(3),
//                                      border: Border.all(
//                                          width: 0.5, color: HexColor("9ba905")),
//                                    ),
//                                    child: FlatButton(
//                                        onPressed: () async {
//
//                                        },
//                                        child: Text(
//                                          'Add to Cart',
//                                          style: TextStyle( fontFamily: 'montserrat',
//                                              color: Colors.white,
//                                              fontWeight: FontWeight.bold,
//                                              fontSize: 12),
//                                        )),
//                                  ),
//                                  SizedBox(
//                                    height: 10,
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ],
//                      );
//                    },
//                  ),
//                ),
//
//
//
//                Container(
////                      height: MediaQuery.of(context).size.height * .3,
//                  height: 260,
////                      width: 100,
//
//                  child: ListView.builder(
//                    padding: const EdgeInsets.only(right: 10,bottom: 20),
//                    shrinkWrap: true,
//                    scrollDirection: Axis.horizontal,
//                    itemCount: 10,
////                        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
////                          crossAxisCount: 3,
//////                  childAspectRatio: 16 / 20,
////                          childAspectRatio: 14/20,
////                          crossAxisSpacing: 1,
////                          mainAxisSpacing: 1,
////
////                        ),
//                    itemBuilder: (context, index) {
////                          return Container(
////                            height: 50,
////                            width: 200,
////                            color: Colors.amber[colorCodes[index]],
////                            child:
////                                Center(child: Text('Entry ${entries[index]}')),
////                          );
//                      return Row(
//                        children: [
//                          InkWell(
//                            onTap: () {
////                              Navigator.push(
////                                context,
////                                MaterialPageRoute(
////                                  builder: (context) =>
//////                                            Products("1","1",2.0, "1","1"),
////                                  Products(bestSellingList, index,
////                                      bestSellingList.items[index].sku, bestSellingList.items[index].price, "normal"),
////                                ),
////                              );
//                            },
//                            child: Card(
//                              color: Colors.white,
////                                color: Color(0xFFFAFAFA),
//                              semanticContainer: true,
//                              clipBehavior: Clip.antiAliasWithSaveLayer,
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(5.0),
//                              ),
//                              elevation: 5,
////                                margin: EdgeInsets.all(10),
//                              child: Column(
//                                children: [
//                                  Stack(
//                                    children: [
////
//                                      Container(
////                                    width: 100,
//                                        height: 100,
//                                        child: CachedNetworkImage(
////                                          width: 200,
//                                          width: 120,
//                                          height: 100,
//                                          fit: BoxFit.contain,
//                                          imageUrl:
//                                                   "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
//                                          placeholder: (context, url) => Center(
//                                            child:
////                                                Image.asset(
////                                                  'assets/images/logo.png',
////                                                  height: 35,
////                                                ),),
////                                            errorWidget:
////                                                (context, url, error) =>
////                                                    new Icon(Icons.error),
//                                            SpinKitPulse(
//                                              color: Colors.red,
//                                              size: 50.0,
//                                            ),
//                                          ),
//                                        ),
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
////                                        Positioned(
////                                          top: 10.0,
////                                          left: 5.0,
////                                          child: Image.asset(
////                                            'assets/images/icons/save.png',
////                                            height: 15,
////                                            fit: BoxFit.contain,
////                                          ),
////                                        ),
////                                        Positioned(
////                                          top: 10.0,
////                                          right: 5.0,
////                                          child: Image.asset(
////                                            'assets/images/icons/love.png',
////                                            height: 15,
//////                                        color: Colors.white,
////                                          ),
//                                      ),
//                                    ],
//                                  ),
//                                  SizedBox(
//                                    height: 2,
//                                  ),
//                                  Row(
//                                    children: [
//                                      Text(
//                                        'AED '
//                                          ,
//                                        style: GoogleFonts.openSans(
//                                          textStyle: TextStyle( fontFamily: 'montserrat',
//                                              fontSize: 14,
//                                              color: Colors.black87,
//                                              fontWeight: FontWeight.bold),
//                                        ),
//                                      ),
////                                        Text(
////                                          '/kg',
////                                          style: GoogleFonts.openSans(
////                                            textStyle: TextStyle( fontFamily: 'montserrat',
////                                              fontSize: 12,
////                                              color: Colors.black87,
////                                            ),
////                                          ),
////                                        ),
//                                    ],
//                                  ),
////                                    Padding(
////                                      padding: EdgeInsets.only(left: 10,right: 10),
////                                      child:
////                                    ),
//                                  SizedBox(
//                                    width: 160,
//                                    height: 44,
//                                    child:   Text(
//                                      'bestSellingList.items[index].name',
//                                      maxLines: 2,
//                                      textAlign: TextAlign.center,
////                                      overflow: TextOverflow.clip,
//                                    ),
//                                  ),
//
//                                  Align(
//                                    alignment: Alignment.center,
//                                    child: Container(
//                                      padding: EdgeInsets.only(left: 5),
//                                      height: 25.0,
//                                      width: MediaQuery.of(context)
//                                          .size
//                                          .width *
//                                          .4,
//                                      // fixed width and height
//                                      child:
//                                      NumberInputWithIncrementDecrement(
//                                        controller: TextEditingController(),
//                                        initialValue: 1,
//                                        min: 1,
//                                        max: 100,
//                                        onIncrement: (num newVal) {
//
//                                        },
//                                        onDecrement:
//                                            (num newlyDecrementedValue) {
//
//                                        },
//                                        numberFieldDecoration:
//                                        InputDecoration(
//                                          border: InputBorder.none,
//                                        ),
//                                        decIconColor: HexColor("e25814"),
//                                        widgetContainerDecoration:
//                                        BoxDecoration(
//                                            borderRadius:
//                                            BorderRadius.all(
//                                                Radius.circular(1)),
//                                            border: Border.all(
//                                              color: Colors.black26,
//                                              width: 0.5,
//                                            )),
//                                        incIconDecoration: BoxDecoration(
//                                          color: Colors.white,
//                                          borderRadius: BorderRadius.only(
//                                            bottomLeft: Radius.circular(0),
//                                          ),
//                                        ),
//                                        separateIcons: false,
//                                        decIconDecoration: BoxDecoration(
//                                          color: Colors.white,
//                                          borderRadius: BorderRadius.only(
//                                            topLeft: Radius.circular(0),
//                                          ),
//                                        ),
//                                        incIconSize: 15,
//                                        decIconSize: 15,
//                                        style: TextStyle( fontFamily: 'montserrat', fontSize: 15),
//                                        incIcon: Icons.add,incIconColor: HexColor("302c98"),
//                                        decIcon: Icons.remove,
//                                      ),
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  Container(
//                                    height: 27,
//                                    width:
//                                    MediaQuery.of(context).size.width *
//                                        .37,
//                                    decoration: BoxDecoration(
//                                      color: HexColor("302c98"),
//                                      borderRadius:
//                                      BorderRadius.circular(3),
//                                      border: Border.all(
//                                          width: 0.5, color: HexColor("302c98")),
//                                    ),
//                                    child: FlatButton(
//                                        onPressed: () async {
//
//                                        },
//                                        child: Text(
//                                          'Add to Cart',
//                                          style: TextStyle( fontFamily: 'montserrat',
//                                              color:Colors.white,
//                                              fontWeight: FontWeight.bold,
//                                              fontSize: 12),
//                                        )),
//                                  ),
//                                  SizedBox(
//                                    height: 10,
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ],
//                      );
//                    },
//                  ),
//                ),
////                  Container(
//////                    height: MediaQuery.of(context).size.height*.4,
////                    height: 242,
//////                      width: 100,
////
////
////                    child: ListView.builder(
////                      padding: const EdgeInsets.all(1),
////                      shrinkWrap: true,
////                      scrollDirection: Axis.horizontal,
////                      itemCount: productList.items.length,
////                      itemBuilder: (context, index) {
//////                          return Container(
//////                            height: 50,
//////                            width: 200,
//////                            color: Colors.amber[colorCodes[index]],
//////                            child:
//////                                Center(child: Text('Entry ${entries[index]}')),
//////                          );
////                        return Row(
////                          children: [
////                            InkWell(
////                              onTap: () {
////                                Navigator.push(
////                                  context,
////                                  MaterialPageRoute(
////                                    builder: (context) =>
//////                                            Products("1","1",2.0, "1","1"),
////                                    Products(productList, index,
////                                        productList.items[0].sku),
////                                  ),
////                                );
////                              },
////                              child: Card(
////                                color: Colors.white,
//////                                color: Color(0xFFFAFAFA),
////                                semanticContainer: true,
////                                clipBehavior: Clip.antiAliasWithSaveLayer,
////                                shape: RoundedRectangleBorder(
////                                  borderRadius: BorderRadius.circular(5.0),
////                                ),
////                                elevation: 5,
//////                                margin: EdgeInsets.all(10),
////                                child: Column(
////                                  children: [
////                                    Stack(
////                                      children: [
//////                                        Container(
//////                                          height: 200,
//////                                          width: 200,
//////                                          child: CachedNetworkImage(
//////                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
//////                                                productList
//////                                                    .items[index]
//////                                                    .mediaGalleryEntries[0]
//////                                                    .file,
//////                                            fit: BoxFit.fill,height: 100,
//////                                            width: 200,
//////                                          ),
//////                                        ),
////                                        Container(
////                                          width: 140,
////                                          height: 120,
////                                          child: CachedNetworkImage(
//////                                          width: 200,
////                                            fit: BoxFit.fill,
////                                            imageUrl:
////                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
////                                                productList
////                                                    .items[index]
////                                                    .mediaGalleryEntries[0]
////                                                    .file,
////                                            placeholder: (context, url) => Center(
////                                                child:
////                                                CircularProgressIndicator()),
////                                            errorWidget:
////                                                (context, url, error) =>
////                                            new Icon(Icons.error),
////                                          ),
////                                        ),
//////                                        Container(
//////                                          height: 200,
////////                                            decoration: BoxDecoration(
////////                                            ),
//////                                          child: Image.network(
//////                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475"
//////                                                +
//////                                                widget.productList
//////                                                    .items[index]
//////                                                    .mediaGalleryEntries[0]
//////                                                    .file,fit: BoxFit.fill,
//////                                          ),
//////                                        ),
////                                        Positioned(
////                                          top: 10.0,
////                                          left: 5.0,
////                                          child: Image.asset(
////                                            'assets/images/icons/save.png',
////                                            height: 15,
////                                            fit: BoxFit.contain,
////                                          ),
////                                        ),
////                                        Positioned(
////                                          top: 10.0,
////                                          right: 5.0,
////                                          child: Image.asset(
////                                            'assets/images/icons/love.png',
////                                            height: 15,
//////                                        color: Colors.white,
////                                          ),
////                                        ),
////                                      ],
////                                    ),
////                                    SizedBox(height: 2,),
////                                    Row(
////                                      children: [
////                                        Text(
////                                          'AED ' +
////                                              productList.items[index].price
////                                                  .toString(),
////                                          style: GoogleFonts.openSans(
////                                            textStyle: TextStyle( fontFamily: 'montserrat',
////                                                fontSize: 14,
////                                                color: Colors.black87,
////                                                fontWeight: FontWeight.bold),
////                                          ),
////                                        ),
////                                        Text('/kg',style: GoogleFonts.openSans(
////                                          textStyle: TextStyle( fontFamily: 'montserrat',
////                                            fontSize: 12,
////                                            color: Colors.black87,
////                                          ),
////                                        ),),
////                                      ],
////                                    ),
//////                                    Padding(
//////                                      padding: EdgeInsets.only(left: 10,right: 10),
//////                                      child:
//////                                    ),
////                                    Flexible(
////                                      child: Container(
////                                        width: 100,
////                                        padding: EdgeInsets.only(
////                                            left: 5, right: 5,top: 5,bottom: 5),
////                                        child: Text(
////                                          productList.items[index].name
////                                              .toString().substring(0,9),
////                                          textAlign: TextAlign.center,
////                                          overflow: TextOverflow.clip,
////                                        ),
////                                      ),
////                                    ),
////                                    Align(
////                                      alignment: Alignment.center,
////                                      child:  Container(
////                                        padding: EdgeInsets.only(left: 5),
////                                        height: 25.0,
////                                        width: MediaQuery.of(context).size.width *
////                                            .4,
////                                        // fixed width and height
////                                        child: NumberInputWithIncrementDecrement(
////                                          controller: TextEditingController(),
////                                          min: 0,
////                                          max: 100,
////                                          onIncrement: (num newVal) {
////                                            setState(() {
////                                              productqty[index] = newVal;
////                                            });
////                                          },
////                                          onDecrement:
////                                              (num newlyDecrementedValue) {
////                                            setState(() {
////                                              productqty[index] =
////                                                  newlyDecrementedValue;
////                                            });
////                                          },
////                                          numberFieldDecoration: InputDecoration(
////                                            border: InputBorder.none,
////                                          ),
////                                          decIconColor: Colors.orange,
////                                          widgetContainerDecoration:
////                                          BoxDecoration(
////                                              borderRadius: BorderRadius.all(
////                                                  Radius.circular(1)),
////                                              border: Border.all(
////                                                color: Colors.black26,
////                                                width: 0.5,
////                                              )),
////                                          incIconDecoration: BoxDecoration(
////                                            color: Colors.white,
////                                            borderRadius: BorderRadius.only(
////                                              bottomLeft: Radius.circular(0),
////                                            ),
////                                          ),
////                                          separateIcons: false,
////                                          decIconDecoration: BoxDecoration(
////                                            color: Colors.white,
////                                            borderRadius: BorderRadius.only(
////                                              topLeft: Radius.circular(0),
////                                            ),
////                                          ),
////                                          incIconSize: 15,
////                                          decIconSize: 15,
////                                          style: TextStyle( fontFamily: 'montserrat', fontSize: 15),
////                                          incIcon: Icons.add,
////                                          decIcon: Icons.remove,
////                                        ),
////                                      ),),
////                                    SizedBox(
////                                      height: 5,
////                                    ),
////                                    Container(
////                                      height: 27,
////                                      width: MediaQuery.of(context).size.width *
////                                          .37,
////                                      decoration: BoxDecoration(
//////                                            color: Colors.lightGreen,
////                                        borderRadius: BorderRadius.circular(1),
////                                        border: Border.all(
////                                            width: 0.5, color: HexColor("9ba905")),
////                                      ),
////                                      child: FlatButton(
////                                          onPressed: () async {
////                                            if (!isLogin) {
////                                              await addCartGuest(
////                                                  productList.items[index].sku,
////                                                  productqty[index]);
//////
//////                                                      Navigator.push(
//////                                                        context,
//////                                                        MaterialPageRoute(builder: (context) => CartList()),
//////                                                      );
////                                            } else {
////                                              await addCartUser(
////                                                  productList.items[index].sku,
////                                                  productqty[index]);
//////                                                      Navigator.push(
//////                                                        context,
//////                                                        MaterialPageRoute(builder: (context) => CartList()),
//////                                                      );
////                                            }
//////                                                    await addCartUser(productList.items[index].sku);
//////                                                    Navigator.push(
//////                                                      context,
//////                                                      MaterialPageRoute(builder: (context) => CartList()),
//////                                                    );
////                                          },
////                                          child: Text(
////                                            'Add to Cart',
////                                            style: TextStyle( fontFamily: 'montserrat',
////                                                color: HexColor("9ba905"),
//////                                                fontWeight: FontWeight.bold,
////                                                fontSize: 12),
////                                          )),
////                                    ),
////                                    SizedBox(
////                                      height: 10,
////                                    ),
////                                  ],
////                                ),
////                              ),
////                            ),
////                          ],
////                        );
////                      },
////                    ),
////                  ),
//                verticalSpace(),
//
//                verticalSpace(),
//                verticalSpace(),
              ),
            ],
          ),
        ],
      )),
    );
  }

  bool isloggedIn = false;

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
//      HomePage.cartListModel =  cartListModel.fromJson(responseJson);
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
//    HomePage.cartListModel =  cartListModel.fromJson(responseJson);
  }

  Future getCategoryList() async {
    ApiRepository.loadCategoryList().then((userDataFromServer) async {
      if (userDataFromServer != null) {
        _progressController = false;
        setState(() {
          categoryList = userDataFromServer;
          for (var i = 0; i < categoryList.childrenData.length; i++) {
            if (categoryList.childrenData[i].name != "On Sale" &&
                categoryList.childrenData[i].name != "Featured" &&
                categoryList.childrenData[i].name != "All Products") {
              setState(() {
                catName.add(categoryList.childrenData[i].name);
                level1CatId.add(categoryList.childrenData[i].id);
              });
            }
          }
        });
        await getLevel2List(3);
        getLevel3List(3, 0);
      } else {
        print("Somithing went wrong...!");
      }
    });
  }

  Future getLevel2List(int index) async {
    setState(() {
      catLevel2 = [];
      catLevel3 = [];
    });

    for (var i = 0;
        i < categoryList.childrenData[index].childrenData.length;
        i++) {
      setState(() {
        catLevel2.add(categoryList.childrenData[index].childrenData[i].name);
        level2CatId.add(categoryList.childrenData[index].childrenData[i].id);
      });
      setState(() {});
    }
  }

  Future getLevel3List(int index1, int index2) async {
    print(index1);
    print(index2);
    setState(() {
      catLevel3 = [];
    });
    for (var i = 0;
        i <
            categoryList
                .childrenData[index1].childrenData[index2].childrenData.length;
        i++) {
      setState(() {
        catLevel3.add(categoryList
            .childrenData[index1].childrenData[index2].childrenData[i].name);
        level3CatId.add(categoryList
            .childrenData[index1].childrenData[index2].childrenData[i].id);
      });
    }

    return catLevel3;
  }
}
