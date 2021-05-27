import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:Alaswaq/Model/PreviousOrderModel.dart';
import 'package:Alaswaq/Model/product_by_sku.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PreviousOrder extends StatefulWidget {
  @override
  PreviousOrderState createState() => PreviousOrderState();
}

class PreviousOrderState extends State<PreviousOrder> {
//  static ProductOrdertModel previousorderList;
//  List<ProductOrdertModel> orderListItems = new List<ProductOrdertModel>() ;
  static PeviousOrderModel previousorderList;
  List<PeviousOrderModel> orderListItems = new List<PeviousOrderModel>();
  ProductBySku productSku;
  List<String> previousimageUrls = [];
  List<String> previousnames = [];
  List<double> previousprice = [];
  List<String> previousinvoiceId = [];
  List<String> skuValues = [];
  var isEmpty = false;
  bool _progressController = true;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getPreviousOrderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _progressController
            ? Center(
                child: Image.asset(
                  "assets/images/icons/loadingicon2.gif",
                  height: 60.0,
                  width: 60.0,
                ),
              )
            : isEmpty
                ? Center(
                    child: Text(
                      "\n" +
                          "\n" +
                          "\n" +
                          "\n" +
                          "\n" +
                          "\n" +
                          "Your Previous Order List Empty",
                      style: TextStyle(
                          fontFamily: 'montserrat',
                          color: Colors.black38,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : Column(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 20.0,
                      ),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: previousimageUrls.length,
                          itemBuilder: (context, index) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  width: MediaQuery.of(context).size.width - 30,
                                  height: 120.0,
                                  child: InkWell(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Card(
                                              elevation: 5,
                                              child: CachedNetworkImage(
                                                height: 80,
                                                fit: BoxFit.contain,
                                                imageUrl:
                                                    previousimageUrls[index],
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
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      previousnames[index],
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'montserrat',
                                                          color: Colors.black54,
                                                          fontSize: 14),
                                                    ),
                                                    Row(
//                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: TextSpan(
                                                            text: 'AED ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14),
                                                            /*defining default style is optional */
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                  text: previousprice[
                                                                          index]
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'montserrat',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
//                                  Padding(
//                                    padding: EdgeInsets.only(top: 10.0, left: 15),
//                                    child: Align(
//                                      alignment: Alignment.center,
//                                      child: RichText(
//                                        overflow: TextOverflow.ellipsis,
//                                        text: TextSpan(
//                                          text: 'Pieces: 12 pcs',
//                                          style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontWeight: FontWeight.w400,
//                                              fontSize: 11), /*defining default style is optional */
//                                          children: <TextSpan>[
//                                            TextSpan(
//                                                text: ' | ', style: TextStyle( fontFamily: 'montserrat', fontWeight: FontWeight.bold, fontSize: 11)),
//                                            TextSpan(
//                                                text: 'Net wt: 500 gms', style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontWeight: FontWeight.w400,
//                                                fontSize: 11)),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//
//                                  )
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10.0, left: 5),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Column(
                                                            children: <Widget>[
                                                              Text(
                                                                  'Invoice Number:',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'montserrat',
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          11)),
                                                              Text(
                                                                  previousinvoiceId[
                                                                      index],
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'montserrat',
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          12)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
//                                            Column(
//                                              crossAxisAlignment:
//                                              CrossAxisAlignment.start,
//                                              children: <Widget>[
//                                                Text('Expected Delivery Date:',
//                                                    style: TextStyle( fontFamily: 'montserrat',
//                                                        color: Colors.grey,
//                                                        fontWeight: FontWeight.w400,
//                                                        fontSize: 11)),
//                                                Text('22 July, 2020',
//                                                    style: TextStyle( fontFamily: 'montserrat',
//                                                        color: Colors.black,
//                                                        fontWeight: FontWeight.w400,
//                                                        fontSize: 12)),
//                                              ],
//                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text('Delivered',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 12,
                                                        color: Colors
                                                            .deepOrangeAccent,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            )

//
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ));
  }

  Future getPreviousOrderList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('adminKey');
    print("admin key is");
    print(token);
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;

    String emailId = prefs.getString('email');
    final url = baseUrl +
        'rest/V1/orders?searchCriteria[filterGroups][][filters][][field]=customer_email&searchCriteria[filterGroups][0][filters][0][value]=$emailId';
    print(url);
    //encode Mapto JSON

    var response = await http.get(Uri.parse(
      url),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
    );
    final responseJson = json.decode(response.body);
    print(responseJson);
    setState(() {
      _progressController = false;
      previousorderList = PeviousOrderModel.fromJson(responseJson);
    });

//    int invoiceCount = orderList.totalCount > 10 ? 10 : orderList.totalCount ;
    print(previousorderList.totalCount);
    if (previousorderList.totalCount <= 0) {
      setState(() {
        isEmpty = true;
      });
    }
    for (var i = 0; i < previousorderList.totalCount; i++) {
      print(previousorderList.items[i].status);
      if (previousorderList.items[i].status == 'complete') {
        print("image url");
        // for(var j = 0; j< previousorderList.items[i].items.length; j++){
        await getImageUrl(previousorderList.items[i].items[0].sku);
//          await getInvoiceNumber(orderList.items[i].items[j].orderId, token2);
        previousinvoiceId
            .add(previousorderList.items[i].items[0].orderId.toString());
//          date.add(orderList.items[i].items[j].createdAt);
//          status.add(orderList.items[i].status);
//         }
      }

//      for (var i = 0; i < previousorderList.totalCount; i++) {
//      print(previousorderList.items[i].status);
//      if(previousorderList.items[i].status == 'complete' ) {
//        for(var j = 0; j< previousorderList.items[i].items.length; j++){
//          await getImageUrl(previousorderList.items[i].items[j].sku);
//          await getInvoiceNumber(previousorderList.items[i].items[j].orderId, token2);
//        }
//      }

    }
  }

  Future getImageUrl(String skuVAl) async {
    var url = baseUrl + 'rest/V1/products/$skuVAl';
    var response =
        await http.get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    final responseJson = json.decode(response.body);
    productSku = ProductBySku.fromJson(responseJson);
    print("image url");
    setState(() {
      previousnames.add(productSku.name);
      previousprice.add(productSku.price);
      skuValues.add(productSku.sku);
    });

    for (var j = 0; j < productSku.customAttributes.length; j++) {
      if (productSku.customAttributes[j].attributeCode == "image") {
        setState(() {
          previousimageUrls.add(
              "https://aswaqrak.ae/pub/media/catalog/product" +
                  productSku.customAttributes[j].value);
        });
      }
    }
  }
//  Future getInvoiceNumber(int orderId, String adminKey) async {
//    String headerText = "Bearer " + adminKey;
//
//    Map data = {
//      "capture": true,
//      "notify": true
//    };
//    String orderNumber = orderId.toString();
//    //encode Map to JSON
//    var body = json.encode(data);
//    var response = await http.post(baseUrl + 'rest/V1/order/$orderNumber./invoice',
//        headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText},
//        body: body
//    );
//    print("invouce numbers");
//    print(response.body);
//    print("invouce numberssss");
//    setState(() {
//      previousinvoiceId.add(response.body) ;
//    });
//    return response;
//  }
}
