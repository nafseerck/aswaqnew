import 'dart:convert';

import 'dart:math';
import 'package:Alaswaq/Model/product_list_model.dart';
import 'package:Alaswaq/Network/api_repository.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/product/Categories/categoriesList.dart';
import 'package:Alaswaq/product/search/category_search.dart';
import 'package:Alaswaq/product/search/last_level_search.dart';
import 'package:Alaswaq/product/search/price_search.dart';
import 'package:Alaswaq/product/search/search_from_home.dart';
import 'package:Alaswaq/product/search/show_search_product_page.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatButtonFilters extends StatefulWidget {
  String fromPage;
  String catId;
  List<String> catNAme;
  CatButtonFilters(this.fromPage, this.catId, this.catNAme);

  @override
  _CatButtonFiltersState createState() => _CatButtonFiltersState();
}

class _CatButtonFiltersState extends State<CatButtonFilters> {
  List<String> _checked = [];
  String dropdownValue = 'One';

  var pressed2 = true;
  var heightVal = 530.0;
  var price1Selected = false;
  var price2Selected = false;
  var price3Selected = false;
  var price4Selected = false;
  var price5Selected = false;
  var isLogin = false;
  bool _progressController = false;
  var currentPage = 1;
  var currentProductCount = 24;
  bool isBottom = false;
  bool isloading = false;
  ScrollController _controller = new ScrollController();
  bool _progressPriceController = true;
  var productqty = [];
  var productPrice = [];
  TextEditingController editingController = TextEditingController();
  @override
  RangeValues _values = RangeValues(0.0, 600.0);

  ProductListModel productList;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      isLoggedIn();
    });
  }

  Widget build(BuildContext context) {
    return _progressController
        ? Center(
            child: Image.asset(
              "assets/images/icons/loadingicon2.gif",
              height: 60.0,
              width: 60.0,
            ),
          )
        : Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  color: HexColor("302c98"),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding:
                            const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                        child: Text('Filter By',
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black12,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 130,
                                height: 40,
                                padding: EdgeInsets.only(left: 10),
                                color: pressed2
                                    ? Colors.white
                                    : Colors.transparent,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      pressed2 = !pressed2;
                                    });
                                  },
                                  //padding: EdgeInsets.all(10.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Price",
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        color: pressed2
                                            ? Colors.orange.shade600
                                            : Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )),
//                      Divider(
//                        color: Colors.white,
//                        height: 1,
//                      ),
//                      Container(
//                          width: 130,
//                          height: 40,
//                          color: pressed2 ? Colors.white : Colors.transparent,
//                          padding: EdgeInsets.only(left: 10),
//                          child: GestureDetector(
//                            onTap: () {
//                              setState(() {
//                                pressed1 = false;
//                                pressed2 = !pressed2;
//                                pressed3 = false;
//                                pressed4 = false;
//                              });
////                                  Navigator.push(
////                                    context,
////                                    MaterialPageRoute(builder: (context) => SearchProduct(15, "Beef")),
////                                  );
//                            },
//                            //padding: EdgeInsets.all(10.0),
//                            child: Align(
//                              alignment: Alignment.centerLeft,
//                              child: Text(
//                                "Brand",
//                                style: TextStyle( fontFamily: 'montserrat',
//                                    color: pressed2
//                                        ? Colors.orange.shade600
//                                        : Colors.black,
//                                    fontWeight: FontWeight.w400,
//                                    fontSize: 12,
//                                    ),
//                              ),
//                            ),
//                          )),
                            Divider(
                              color: Colors.black,
                              height: 1,
                            ),
//                      Container(
//                          width: 130,
//                          height: 40,
//                          color: pressed4
//                              ? Colors.white
//                              : Colors.transparent,
//                          padding: EdgeInsets.only(left: 10),
//                          child: GestureDetector(
//                            onTap: () {
//                              setState(() {
//                                pressed1 = false;
//                                pressed2 = false;
//                                pressed3 = false;
//                                pressed4 = !pressed4;
//                              });
////                                    Navigator.push(
////                                      context,
////                                      MaterialPageRoute(builder: (context) => SearchProduct(15, "Beef")),
////                                    );
//                            },
//                            //padding: EdgeInsets.all(10.0),
//                            child: Align(
//                              alignment: Alignment.centerLeft,
//                              child: Text(
//                                "Packet Size",
//                                style: TextStyle( fontFamily: 'montserrat',
//                                    color: pressed4 ? Colors.orange.shade600 : Colors.black,
//                                    fontWeight: FontWeight.w400,
//                                    fontSize: 12,
//                                    ),
//                              ),
//                            ),
//                          )),                      Divider(
//                        color: Colors.black,
//                        height: 1,
//                      ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
//                  width: MediaQuery.of(context).size.width * .68,
//                  height: MediaQuery.of(context).size.height * .6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
//                        SizedBox(
//                          height: 10,
//                        ),
//                        SizedBox(
//                          width: MediaQuery.of(context).size.width - 150,
//                          height: 50,
//                          child: TextField(
//                            onChanged: (value) {},
//                            controller: editingController,
//                            decoration: new InputDecoration(
////                              labelText: "Search your products",
////                              labelStyle: TextStyle( fontFamily: 'montserrat',
////                                  color:  Colors.black
////                              ),
//                              suffixIcon: IconButton(
//                                onPressed: () {
//                                  print("search");
////                                  Navigator.push(
////                                    context,
////                                    MaterialPageRoute(builder: (context) => SearchFromHome(editingController.text)),
////                                  );
//                                },
//                                icon: Icon(
//                                  Icons.search,
//                                  color: Colors.grey,
//                                  size: 30,
//                                ),
//                              ),
//
//                              focusedBorder: OutlineInputBorder(
//                                borderRadius:
//                                    BorderRadius.all(Radius.circular(15.0)),
//                                borderSide:
//                                    BorderSide(color: Colors.grey, width: 1.0),
//                              ),
//                              enabledBorder: OutlineInputBorder(
//                                borderRadius:
//                                    BorderRadius.all(Radius.circular(15.0)),
//                                borderSide:
//                                    BorderSide(color: Colors.grey, width: 1.0),
//                              ),
//                              hintText: "Search your products",
//                            ),
////
//                          ),
//                        ),
                              Container(
                                height: 188,
                                child: getCheckBox(),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 50,
                    color: Color(0xFF9AA822),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              pressed2 = false;
                              getCheckBox();
                            });
                          },
                          child: Container(
                            color: Color(0xFFE15925),
                            height: 50,
                            width: 130,
                            padding: EdgeInsets.only(top: 15),
                            child: Text('CLEAR ALL',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'montserrat',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 0.0, right: 0.0),
                              child: FlatButton(
                                  child: Text('APPLY FILTERS',
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  onPressed: () {
//                              setState(() {
//                                _progressController = true;
//                              });
                                    goToSearchResult();
                                  }),
                            )),
                      ],
                    ),
                  ),
                ),

//            Container(
//              height: 70,
//              color:  Color(0xFF9AA822),
////              color:  Color(0xFFE15925),
//              child: Column(
//                children: <Widget>[
//                  Row(
//                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Container(
//                       alignment: Alignment.topLeft,
//                        height: 70,
//                        width: 200,
//                        child: FlatButton(
//                            color:  Color(0xFFE15925),
//                            child: Text('Clear All',
//                                style: TextStyle( fontFamily: 'montserrat',
//                                    color: Colors.white,
//                                    fontSize: 16,
//                                    fontWeight: FontWeight.w700, )),
//                            onPressed: () {
//                              setState(() {
//                                pressed1 = false ;
//                                pressed2 = false ;
//                                pressed3 = false ;
//                                pressed4 = false ;
//                                getCheckBox();
//                              });
//
//
//                            }),
//
//                      ),
//                      Container(
//                        padding: const EdgeInsets.only(
//                            top: 0.0, left: 0.0, right: 0.0),
//                        child: FlatButton(
//                            child: Text('Apply Filters',
//                                style: TextStyle( fontFamily: 'montserrat',
//                                    color: Colors.white,
//                                    fontSize: 18,
//                                    fontWeight: FontWeight.w700, )),
//                            onPressed: () {
//                              goToSearchResult();
//
//                            }),
//                      )
//                    ],
//                  ),
//                ],
//              ),
//            ),
              ],
            ),
          );
  }

  Widget getCheckBox() {
    if (pressed2) {
      return CheckboxGroup(
        labels: <String>[
          "AED 0.00 - AED 9.99",
          "AED 10.00 - AED 19.99",
          "AED 20.00 and above"
        ],
        disabled: ["Wednesday", "Friday"],
//        onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
        onChange: (
          bool isChecked,
          String label,
          int index,
        ) {
          print("isChecked: $isChecked   label: $label  index: $index");
          setState(() {
            print("inside");
            print(index);
            if (index == 0) {
              if (isChecked) {
                print("inside");
                price1Selected = true;
              } else {
                price1Selected = false;
              }
            }
            if (index == 1) {
              if (isChecked) {
                print("inside");
                price2Selected = true;
              } else {
                price2Selected = false;
              }
            }
            if (index == 2) {
              if (isChecked) {
                print("inside");
                price3Selected = true;
              } else {
                price3Selected = false;
              }
            }
            if (index == 3) {
              if (isChecked) {
                print("inside");
                price4Selected = true;
              } else {
                price4Selected = false;
              }
            }
            if (index == 4) {
              if (isChecked) {
                print("inside");
                price5Selected = true;
              } else {
                price5Selected = false;
              }
            }
          });
        },
        onSelected: (List selected) => setState(() {
          _checked = selected;
        }),
      );
    }

//    else if (pressed3) {
//      return Column(
//        children: <Widget>[
//          ListTile(
//            title: const Text('Beef'),
//            leading: Radio(
//              value: filterCategory.beef,
//              groupValue: _character,
//              onChanged: (filterCategory value) {
//                setState(() {
//                  _character = value;
//                });
//              },
//            ),
//          ),
//          ListTile(
//            title: const Text('Lamb'),
//            leading: Radio(
//              value: filterCategory.lamb,
//              groupValue: _character,
//              onChanged: (filterCategory value) {
//                setState(() {
//                  _character = value;
//                });
//              },
//            ),
//          ),
//          ListTile(
//            title: const Text('Poultry'),
//            leading: Radio(
//              value: filterCategory.poultry,
//              groupValue: _character,
//              onChanged: (filterCategory value) {
//                setState(() {
//                  _character = value;
//                });
//              },
//            ),
//          ),
//          ListTile(
//            title: const Text('Sea Food'),
//            leading: Radio(
//              value: filterCategory.seafod,
//              groupValue: _character,
//              onChanged: (filterCategory value) {
//                setState(() {
//                  _character = value;
//                });
//              },
//            ),
//          ),
//          ListTile(
//            title: const Text('Diary'),
//            leading: Radio(
//              value: filterCategory.diary,
//              groupValue: _character,
//              onChanged: (filterCategory value) {
//                setState(() {
//                  _character = value;
//                });
//              },
//            ),
//          ),
//          ListTile(
//            title: const Text('Cold Cut'),
//            leading: Radio(
//              value: filterCategory.coldcut,
//              groupValue: _character,
//              onChanged: (filterCategory value) {
//                setState(() {
//                  _character = value;
//                });
//              },
//            ),
//          ),
//        ],
//      );
//    }
  }

//  Future<void> goToSearchResult() async {
//    if (pressed3) {
//      if (_character == filterCategory.beef) {
////        Navigator.push(
////          context,
////          MaterialPageRoute(builder: (context) => SearchProduct(15, "Beef")),
////        );
//      } else if (_character == filterCategory.lamb) {
////        Navigator.push(
////          context,
////          MaterialPageRoute(builder: (context) => SearchProduct(16, "Lamb")),
////        );
//      } else if (_character == filterCategory.poultry) {
////        Navigator.push(
////          context,
////          MaterialPageRoute(builder: (context) => SearchProduct(67, "Poultry")),
////        );
//      } else if (_character == filterCategory.seafod) {
////        Navigator.push(
////          context,
////          MaterialPageRoute(builder: (context) => SearchProduct(58, "Sea Food")),
////        );
//      } else if (_character == filterCategory.diary) {
////        Navigator.push(
////          context,
////          MaterialPageRoute(builder: (context) => SearchProduct(77, "Diary")),
////        );
//      } else if (_character == filterCategory.coldcut) {
////        Navigator.push(
////          context,
////          MaterialPageRoute(builder: (context) => SearchProduct(78, "Cold Cuts")),
////        );
//      }
//    } else if (pressed1) {
//      var string1 = "";
//      var string2 = "";
//      var string3 = "";
//      var string4 = "";
//      var string5 = "";
//      if (price1Selected) {
//        string1 =
//            "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=0&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][value]=50&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[sortOrders][0][field]=price&";
//      }
//      if (price2Selected) {
//        string2 =
//            "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=50&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][value]=100&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[sortOrders][0][field]=price&";
//      }
//      if (price3Selected) {
//        string3 =
//            "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=100&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][value]=150&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[sortOrders][0][field]=price&";
//      }
//      if (price4Selected) {
//        string4 =
//            "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=150&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][value]=200&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[sortOrders][0][field]=price&";
//      }
//      if (price5Selected) {
//        string5 =
//            "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=200&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&";
//      }
//
//      var url = baseUrl + 'rest/V1/products?&' +
//          string1 +
//          string2 +
//          string3 +
//          string4;
//      print(url);
//      try {
//        var response = await http.get(
//          url,
//          headers: {"Content-Type": "application/json"},
//        );
//
//        if (response.statusCode == 200) {
//          final responseJson = json.decode(response.body);
//          print("meat listing response");
//          print(responseJson);
//
//          ProductListModel productList =
//              ProductListModel.fromJson(responseJson);
//          debugPrint('after parsing');
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => PriceSearch(productList)),
//          );
//          return productList;
//        } else {
//          debugPrint('list ERROR');
//          return null;
//          throw Exception("Error");
//        }
//      } catch (e) {
//        throw Exception(e.toString());
//      }
//    } else if (pressed2) {
//      var string1 = "";
//      if (temp1Selected) {
//        string1 =
//            "searchCriteria[filterGroups][0][filters][0][field]=condition_of_temperature&searchCriteria[filterGroups][0][filters][0][value]=5&searchCriteria[filterGroups][0][filters][0][condition_type]=lteq";
//      }
//      if (temp2Selected) {
//        string1 =
//            "searchCriteria[filterGroups][0][filters][0][field]=condition_of_temperature&searchCriteria[filterGroups][0][filters][0][value]=10&searchCriteria[filterGroups][0][filters][0][condition_type]=lteq";
//      }
//      if (temp3Selected) {
//        string1 =
//            "searchCriteria[filterGroups][0][filters][0][field]=condition_of_temperature&searchCriteria[filterGroups][0][filters][0][value]=20&searchCriteria[filterGroups][0][filters][0][condition_type]=lteq";
//      }
//      if (temp4Selected) {
//        string1 =
//            "searchCriteria[filterGroups][0][filters][0][field]=condition_of_temperature&searchCriteria[filterGroups][0][filters][0][value]=25&searchCriteria[filterGroups][0][filters][0][condition_type]=lteq";
//      }
//      if (temp5Selected) {
//        string1 =
//            "searchCriteria[filterGroups][0][filters][0][field]=condition_of_temperature&searchCriteria[filterGroups][0][filters][0][value]=30&searchCriteria[filterGroups][0][filters][0][condition_type]=lteq";
//      }
//
//      var url = baseUrl + 'rest/V1/products?&' + string1;
//      print(url);
//      try {
//        var response = await http.get(
//          url,
//          headers: {"Content-Type": "application/json"},
//        );
//
//        if (response.statusCode == 200) {
//          final responseJson = json.decode(response.body);
//          print("meat listing response");
//          print(responseJson);
//
//          ProductListModel productList =
//              ProductListModel.fromJson(responseJson);
//          debugPrint('after parsing');
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => PriceSearch(productList)),
//          );
//          return productList;
//        } else {
//          debugPrint('list ERROR');
//          return null;
//          throw Exception("Error");
//        }
//      } catch (e) {
//        throw Exception(e.toString());
//      }
//    }
//  }
  Future<void> goToSearchResult() async {
    var string = "";

    var string1 = "";
    var string2 = "";
    var string3 = "";
    var id = widget.catId;
    if (widget.fromPage == "From Cat Button") {
      if (price1Selected) {
        string1 =
            "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=0&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][value]=10&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[filterGroups][2][filters][0][field]=category_id&searchCriteria[filterGroups][2][filters][0][value]=$id&searchCriteria[filterGroups][2][filters][0][conditionType]=eq";
      }
      if (price2Selected) {
        string2 =
            "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][2][filters][0][conditionType]=eq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[filterGroups][2][filters][0][value]=$id&&searchCriteria[filterGroups][1][filters][0][value]=20&searchCriteria[filterGroups][0][filters][0][value]=10&searchCriteria[filterGroups][2][filters][0][field]=category_id";
      }

      if (price3Selected) {
        string3 =
            "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=20&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][2][filters][0][field]=category_id&searchCriteria[filterGroups][2][filters][0][value]=104&searchCriteria[filterGroups][2][filters][0][conditionType]=eq&searchCriteria[filterGroups][2][filters][0][field]=category_id&searchCriteria[filterGroups][2][filters][0][value]=$id&searchCriteria[filterGroups][2][filters][0][conditionType]=eq";
      }
    } else {
      if (price1Selected) {
        string1 =
            "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[filterGroups][1][filters][0][value]=10&searchCriteria[filterGroups][0][filters][0][value]=0&searchCriteria[filter_groups][0][filters][1][field]=name&searchCriteria[filter_groups][0][filters][1][condition_type]=like&searchCriteria[filter_groups][0][filters][1][value]=$id%&searchCriteria[filter_groups][1][filters][0][field]=type_id&searchCriteria[filter_groups][1][filters][0][value]=virtual&searchCriteria[filter_groups][1][filters][0][condition_type]=neq&searchCriteria[sortOrders][1][field]=name&searchCriteria[sortOrders][1][direction]=ASC";
      }
      if (price2Selected) {
        string2 =
            "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[filterGroups][1][filters][0][value]=20&searchCriteria[filterGroups][0][filters][0][value]=10&searchCriteria[filter_groups][0][filters][1][field]=name&searchCriteria[filter_groups][0][filters][1][condition_type]=like&searchCriteria[filter_groups][0][filters][1][value]=$id%&searchCriteria[filter_groups][1][filters][0][field]=type_id&searchCriteria[filter_groups][1][filters][0][value]=virtual&searchCriteria[filter_groups][1][filters][0][condition_type]=neq&searchCriteria[sortOrders][1][field]=name&searchCriteria[sortOrders][1][direction]=ASC&";
      }

      if (price3Selected) {
        string3 =
            "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][0][filters][0][value]=20&searchCriteria[filter_groups][0][filters][1][field]=name&searchCriteria[filter_groups][0][filters][1][condition_type]=like&searchCriteria[filter_groups][0][filters][1][value]=$id%&searchCriteria[filter_groups][1][filters][0][field]=type_id&searchCriteria[filter_groups][1][filters][0][value]=virtual&searchCriteria[filter_groups][1][filters][0][condition_type]=neq&searchCriteria[sortOrders][1][field]=name&searchCriteria[sortOrders][1][direction]=ASC&";
      }
    }
    var url = baseUrl + 'rest/V1/products?&' + string1 + string2 + string3;
    print(url);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PriceSearch(url)),
    );
  }

  // Future getSortbyPosition() async {
  //   setState(() {
  //     _progressController = true;
  //   });
  //   var catId =   int.parse(widget.catId);
  //   ApiRepository.sortOnPostion(catId).then((userDataFromServer) async {
  //     if (userDataFromServer != null) {
  //       setState(() {
  //         _progressController = false;
  //         productList = userDataFromServer;
  //         productqty = new List<int>.generate(productList.items.length, (i) => 1);
  //         productPrice =
  //         new List<double>.generate(productList.items.length, (i) => 0.0);
  //         _progressController = false;
  //         callPrice();
  //       });
  //
  //     } else {
  //       print("Somithing went wrong..s.!");
  //     }
  //   }
  //   );
  // }
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

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint(prefs.getBool('isLoggedIn').toString());
    final loginStatus = prefs.getBool('isLoggedIn');
    if (loginStatus == true) {
      print("for  listen user key  user");
      isLogin = true;
      HomePageState.isLogin = true;
    } else {
      print("for  listen guest user");
      HomePageState.isLogin = false;
    }
    return prefs.getBool('isLoggedIn');
  }
}
