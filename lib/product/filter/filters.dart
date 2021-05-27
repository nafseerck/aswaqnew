import 'dart:convert';

import 'dart:math';
import 'package:Alaswaq/Model/product_list_model.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/product/Categories/categoriesList.dart';
import 'package:Alaswaq/product/search/category_search.dart';
import 'package:Alaswaq/product/search/last_level_search.dart';
import 'package:Alaswaq/product/search/price_search.dart';
import 'package:Alaswaq/product/search/search_from_home.dart';
import 'package:Alaswaq/product/search/show_search_product_page.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  String fromPage;
  String catId;
  List<String> catNAme;
  List<int> level1catId;
  Filters(this.fromPage, this.catId, this.catNAme, this.level1catId);

  @override
  _FiltersState createState() => _FiltersState();
}

//enum filterCategory { beef, lamb, poultry, seafod, frenchfries, diary, coldcut }
//enum filterCategory {
//  all,
//  fruits,
//  vegetables,
//  seafod,
//  meat,
//  bakery,
//  diary,
//  drinks
//}

class _FiltersState extends State<Filters> {
  List<String> _checked = [];
  String dropdownValue = 'One';
  var pressed1 = true;

  var pressed2 = false;

  var heightVal = 530.0;
  var price1Selected = false;
  var price2Selected = false;
  var price3Selected = false;
  var price4Selected = false;
  var price5Selected = false;

  var temp1Selected = false;
  var temp2Selected = false;
  var temp3Selected = false;
  var temp4Selected = false;
  var temp5Selected = false;

  var cat1Selected = false;
  var cat2Selected = false;
  var cat3Selected = false;
  var cat4Selected = false;
  var cat5Selected = false;
  var cat6Selected = false;
  var cat7Selected = false;
  var cat8Selected = false;
  var cat9Selected = false;

//  filterCategory _character;
  bool _progressController = false;
  TextEditingController editingController = TextEditingController();
  @override
  RangeValues _values = RangeValues(0.0, 600.0);

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
            height: 50.0 * widget.level1catId.length + 150,
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
                            widget.fromPage == "From ShowSearchProduct"
                                ? Container(
                                    width: 130,
                                    height: 40,
                                    padding: EdgeInsets.only(left: 10),
                                    color: pressed1
                                        ? Colors.white
                                        : Colors.transparent,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          pressed1 = !pressed1;
                                          pressed2 = false;
                                        });
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(builder: (context) => ShowSearchProductPage(categoryId: 15, name:'All')),
//                                  );
                                      },
                                      //padding: EdgeInsets.all(10.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Category",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: 'montserrat',
                                            color: pressed1
                                                ? Colors.orange.shade600
                                                : Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Divider(
                              color: Colors.white,
                              height: 1,
                            ),
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
                                      pressed1 = false;
                                    });
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(builder: (context) => SearchProduct(15, "Beef")),
//                                  );
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
                                height: 50.0 * widget.level1catId.length + 39,
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
                              pressed1 = false;
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

    else if (widget.fromPage == "From ShowSearchProduct") {
      if (pressed1) {
        return CheckboxGroup(
//          labels: <String>[
//            "All",
//            "Fruits",
//            "Vegetables",
//            "Seafood",
//            "Meat",
//            "Bakery",
//            "Diary",
//            "Drinks",
//          ],
            labels: widget.catNAme,
            disabled: ["Wednesday", "Friday"],
//        onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
            onChange: (bool isChecked, String label, int index) {
              print("isChecked: $isChecked   label: $label  index: $index");
              setState(() {
                print("inside");
                print(index);
                if (index == 0) {
                  if (isChecked) {
                    print("inside");
                    cat1Selected = true;
                  } else {
                    cat1Selected = false;
                  }
                }
                if (index == 1) {
                  if (isChecked) {
                    print("inside");
                    cat2Selected = true;
                  } else {
                    cat2Selected = false;
                  }
                }
                if (index == 2) {
                  if (isChecked) {
                    print("inside");
                    cat3Selected = true;
                  } else {
                    cat3Selected = false;
                  }
                }
                if (index == 3) {
                  if (isChecked) {
                    print("inside");
                    cat4Selected = true;
                  } else {
                    cat4Selected = false;
                  }
                }
                if (index == 4) {
                  if (isChecked) {
                    print("inside");
                    cat5Selected = true;
                  } else {
                    cat5Selected = false;
                  }
                }
                if (index == 5) {
                  if (isChecked) {
                    print("inside");
                    cat6Selected = true;
                  } else {
                    cat6Selected = false;
                  }
                }
                if (index == 6) {
                  if (isChecked) {
                    print("inside");
                    cat7Selected = true;
                  } else {
                    cat7Selected = false;
                  }
                }
                if (index == 7) {
                  if (isChecked) {
                    print("inside");
                    cat8Selected = true;
                  } else {
                    cat8Selected = false;
                  }
                }
                if (index == 8) {
                  if (isChecked) {
                    print("inside");
                    cat9Selected = true;
                  } else {
                    cat9Selected = false;
                  }
                }
              });
            },
            onSelected: (List selected) => setState(() {
                  print("checked: ${selected.toString()}");
                  _checked = selected;
                }));
//        onSelected: (List<String> checked) =>
//            print("checked: ${checked.toString()}"),
//      );
      }
    }
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
    if (widget.fromPage == "From ShowSearchProduct") {
      if (pressed1) {
        var id;
        for (int i = 0; i < widget.level1catId.length; i++) {
          if (cat1Selected) {
            id = widget.level1catId[0];
          }
          if (cat2Selected) {
            id = widget.level1catId[1];
          }
          if (cat3Selected) {
            id = widget.level1catId[2];
          }
          if (cat4Selected) {
            id = widget.level1catId[3];
          }
          if (cat5Selected) {
            id = widget.level1catId[4];
          }
          if (cat6Selected) {
            id = widget.level1catId[5];
          }
          if (cat7Selected) {
            id = widget.level1catId[5];
          }
          if (cat8Selected) {
            id = widget.level1catId[6];
          }
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LastLevelSearchProductPage(
                    categoryId: id,
                  )),
        );
      } else if (pressed2) {
        var string1 = "";
        var string2 = "";
        var string3 = "";
        var id = widget.catId;
        if (widget.fromPage == "From ShowSearchProduct") {
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
                "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=20&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][2][filters][0][conditionType]=eq&searchCriteria[filterGroups][2][filters][0][field]=category_id&searchCriteria[filterGroups][2][filters][0][value]=$id&searchCriteria[filterGroups][2][filters][0][conditionType]=eq";
          }
        }

        var url = baseUrl + 'rest/V1/products?&' + string1 + string2 + string3;
        print(url);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PriceSearch(url)),
        );
//         try {
//           var response = await http.get(
//             url,
//             headers: {"Content-Type": "application/json"},
//           );
//
//           if (response.statusCode == 200) {
//             _progressController = false;
//             final responseJson = json.decode(response.body);
//             print("meat listing response");
//             print(responseJson);
//
//             ProductListModel productList =
//             ProductListModel.fromJson(responseJson);
//
//             debugPrint('after parsing');
// //
//           }
//         } catch (e) {
//           throw Exception(e.toString());
//         }
      }
    } else if (pressed1) {
      var string1 = "";
      var string2 = "";
      var string3 = "";
      var id = widget.catId;
      if (widget.fromPage == "From ShowSearchProduct") {
        if (price1Selected) {
          string1 =
              "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=10&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][value]=20&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[filter_groups][2][filters][0][field]=name&searchCriteria[filter_groups][2][filters][0][condition_type]=like&searchCriteria[filter_groups][2][filters][0][value]=$id%&";
        }
        if (price2Selected) {
          string2 =
              "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=10&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][value]=20&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[filter_groups][2][filters][0][field]=name&searchCriteria[filter_groups][2][filters][0][condition_type]=like&searchCriteria[filter_groups][2][filters][0][value]=$id%&";
        }

        if (price3Selected) {
          string3 =
              "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=10&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][value]=20&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[filter_groups][2][filters][0][field]=name&searchCriteria[filter_groups][2][filters][0][condition_type]=like&searchCriteria[filter_groups][2][filters][0][value]=$id%&";
        }
      } else {
        if (price1Selected) {
          string1 =
              "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=0&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][value]=5&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[sortOrders][0][field]=price&searchCriteria[filterGroups][2][filters][0][field]=category_id&searchCriteria[filterGroups][2][filters][0][value]=$id&searchCriteria[filterGroups][2][filters][0][conditionType]=eq&";
        }
        if (price2Selected) {
          string2 =
              "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=10&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&searchCriteria[filterGroups][1][filters][0][field]=price&searchCriteria[filterGroups][1][filters][0][value]=5&searchCriteria[filterGroups][1][filters][0][condition_type]=lteq&searchCriteria[sortOrders][0][field]=price&searchCriteria[filterGroups][2][filters][0][field]=category_id&searchCriteria[filterGroups][2][filters][0][value]=$id&searchCriteria[filterGroups][2][filters][0][conditionType]=eq&";
        }

        if (price3Selected) {
          string3 =
              "searchCriteria[filterGroups][0][filters][0][field]=price&searchCriteria[filterGroups][0][filters][0][value]=20&searchCriteria[filterGroups][0][filters][0][condition_type]=gteq&&searchCriteria[filter_groups][0][filters][0][value]=$id&";
        }
      }

      var url = baseUrl + 'rest/V1/products?&' + string1 + string2 + string3;
      print(url);
      try {
        var response = await http.get(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          _progressController = false;
          final responseJson = json.decode(response.body);
          print("meat listing response");
          print(responseJson);

          ProductListModel productList =
              ProductListModel.fromJson(responseJson);

          debugPrint('after parsing');
//          if(widget.fromPage == "From Category List"){
//            setState(() {
//              CategoryProductPageState.productList = productList;
//            });
//
//          } else
//            if (widget.fromPage == "From Price Search"){
//            setState(() {
//
//              PriceSearchState.productList = productList;
//            });
//
//          } else
          if (widget.fromPage == "From ShowSearchProduct") {
            setState(() {
              productList = productList;
            });
          } else if (widget.fromPage == "From First Level Search") {
            setState(() {
              LastLevelSearchProductPageState.productList = productList;
            });
          }
          Navigator.pop(context);
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => PriceSearch(productList)),
//          );
          return productList;
        } else {
          debugPrint('list ERROR');
          return null;
          throw Exception("Error");
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }
  }
}
