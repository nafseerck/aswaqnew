
import 'dart:convert';
import 'dart:io';
import 'package:Alaswaq/Model/ProductOrderModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:Alaswaq/Model/product_by_sku.dart';
import 'package:Alaswaq/common/drawer.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications2 extends StatefulWidget {
  @override
  NotificationsState2 createState() => NotificationsState2();
}

class NotificationsState2 extends State<Notifications2> {
  ProductOrdertModel orderList;
  List<ProductOrdertModel> orderListItems = new List<ProductOrdertModel>() ;
  ProductBySku productSku;
  List<String> imageUrls = [];
  List<String> names = [];
  List<double> price = [];
  List<String> invoiceId = [];
  List<DateTime> date = [];
  List<String> status = [];
  var isEmpty = false;
  bool _progressController = true;
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getCurrentOrderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          // hides leading widget
//        flexibleSpace: Container(),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
              size: 30,
            ),
          ),
          title: Text(
            'Notifications',
            style: TextStyle(fontFamily: 'montserrat',
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),

        ),
        body: _progressController
            ?  Center(
          child: SpinKitPulse(
            color: Colors.red,
            size: 50.0,
          ),
        )

            : isEmpty  ? Center(
          child: Text(
            "\n" + "\n" + "\n" + "\n" + "\n" + "\n" + "Your Notification List Empty",
            style: TextStyle(fontFamily: 'montserrat',
                color: Colors.black38,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ) : Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: 20.0,
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: orderList.items.length,
                itemBuilder: (context, index) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                        width: MediaQuery.of(context).size.width - 30,
                        height: 155.0,
                        child: InkWell(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Card(
                                    elevation: 5,

                                    child: CachedNetworkImage(
                                      width: 110,
                                      height: 100,
                                      fit: BoxFit.fill,
                                      imageUrl: imageUrls[index],
                                      placeholder: (context, url) => Center(
                                        child:  SpinKitPulse(
                                          color: Colors.red,
                                          size: 50.0,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => new Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          text: '',
                                          style: TextStyle( fontFamily: 'montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                          /*defining default style is optional */
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Your order is " +  orderList.items[index].status,
                                                style: TextStyle( fontFamily: 'montserrat',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width - 200,
                                        height: 35,
                                        child: Text(
                                          names[index],
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle( fontFamily: 'montserrat',
                                              color: Colors.black54, fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
//                                       Row(
// //                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           RichText(
//                                             overflow: TextOverflow.ellipsis,
//                                             text: TextSpan(
//                                               text: 'AED ',
//                                               style: TextStyle( fontFamily: 'montserrat',
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.w500,
//                                                   fontSize: 14),
//                                               /*defining default style is optional */
//                                               children: <TextSpan>[
//                                                 TextSpan(
//                                                     text:  price[index].toString(),
//                                                     style: TextStyle( fontFamily: 'montserrat',
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 16)),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
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
                                      Container(
                                        width: MediaQuery.of(context).size.width - 150,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text('Invoice Number:',
                                                    style: TextStyle( fontFamily: 'montserrat',
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 11)),
                                                Text(invoiceId[index],
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle( fontFamily: 'montserrat',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12)),
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                // Text('Order Placed Date:',
                                                //     style: TextStyle( fontFamily: 'montserrat',
                                                //         color: Colors.grey,
                                                //         fontWeight: FontWeight.w400,
                                                //         fontSize: 11)),
                                                Text(Jiffy(date[index]).yMMMMd,
                                                    style: TextStyle( fontFamily: 'montserrat',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ],
                                        ),

                                      ),
//                                       Padding(
//                                         padding:
//                                         EdgeInsets.symmetric(vertical: 1, horizontal: 40),
//                                         child:  FlatButton(
//                                           onPressed: () async {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(builder: (context) => TrackOrder(invoiceId[index])),
//                                             );
//                                           },
//                                           child: Text('Track Order', style: TextStyle(
//                                               color:  HexColor("9ba905"), fontSize: 12,fontFamily: 'montserrat'
//                                           )
//                                           ),
// //                              textColor: MyColor.white,
//                                           shape: RoundedRectangleBorder(side: BorderSide(
//                                               color: Colors.white,
//                                               width: 0.5,
//                                               style: BorderStyle.solid
//                                           ), borderRadius: BorderRadius.circular(5)),
//                                         ),
//                                       ),
                                    ],
                                  ),


                                ],
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
  Future getCurrentOrderList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('adminKey');
    print("admin key is");
    print(token);
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;

    String emailId = prefs.getString('email');
    final url = 'https://aswaqrak.ae/rest/V1/orders?searchCriteria[filterGroups][][filters][][field]=customer_email&searchCriteria[filterGroups][0][filters][0][value]=$emailId';
    print(url);
    //encode Mapto JSON

    var response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText},

    );
    final responseJson = json.decode(response.body);
    print(responseJson);
    setState(() {
      _progressController = false;
      orderList = ProductOrdertModel.fromJson(responseJson);
    });

//    int invoiceCount = orderList.totalCount > 10 ? 10 : orderList.totalCount ;
    print(orderList.totalCount);

    if(orderList.totalCount <= 0) {
      setState(() {
        isEmpty = true;
      });

    }
    for (var i = 0; i < orderList.totalCount; i++) {
      print(orderList.items[i].status);
      // if(orderList.items[i].status == 'pending' || orderList.items[i].status == 'processing') {
      print("image url");
      for(var j = 0; j< orderList.items[i].items.length; j++){
        await getImageUrl(orderList.items[i].items[j].sku);
//          await getInvoiceNumber(orderList.items[i].items[j].orderId, token2);
        invoiceId.add(orderList.items[i].items[j].orderId.toString());
        date.add(orderList.items[i].items[j].updatedAt);
        status.add(orderList.items[i].status);
      }
      // }

    }
  }
  Future getImageUrl(String skuVAl) async {

    var url = 'https://aswaqrak.ae/rest/V1/products/$skuVAl';
    print(url);
    var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"}
    );
    final responseJson = json.decode(response.body);
    productSku = ProductBySku.fromJson(responseJson);
    print("image url");
    setState(() {
      names.add(productSku.name);
      price.add(productSku.price);

    });
    for (var j = 0; j < productSku.customAttributes.length; j++) {
      if (productSku.customAttributes[j].attributeCode == "image") {
        setState(() {
          imageUrls.add(
              "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                  productSku.customAttributes[j].value);
        });
      }

    }
  }
}



