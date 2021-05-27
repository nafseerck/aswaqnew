import 'package:Alaswaq/home/dashboard.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackOrder extends StatefulWidget{
  String invoiceId = "";
  TrackOrder( this.invoiceId);

  TrackOrderState createState()=> TrackOrderState();
}
class TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold (
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
          'Order Tracking',
          style: TextStyle( fontFamily: 'montserrat',
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color:AppColor.whiteColor,
        child: Column(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20),
              child: Text(
                'Invoice Number: ' + widget.invoiceId,
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600, decoration: TextDecoration.none,fontFamily: 'montserrat'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
              child: Container(
                height: 400,
                color: Colors.white,
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.check_circle, color: HexColor("9ba905"),size: 30,),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Order Place",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400, decoration: TextDecoration.none,fontFamily: 'montserrat'),)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: .0, left: 8, right: 20),
                        child:  Container(height: 50, child: VerticalDivider(color: HexColor("649FC3"))),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.check_circle_outline, color: HexColor("302c98"),size: 30,),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Order Shipped",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400, decoration: TextDecoration.none,fontFamily: 'montserrat'),)
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: .0, left: 8, right: 20),
                        child:  Container(height: 50, child: VerticalDivider(color: HexColor("649FC3"))),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.check_circle_outline, color: HexColor("302c98"),size: 30,),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Dispached",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400, decoration: TextDecoration.none,fontFamily: 'montserrat'),)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: .0, left: 8, right: 20),
                        child:  Container(height: 50, child: VerticalDivider(color: HexColor("649FC3"))),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.check_circle_outline, color: HexColor("302c98"),size: 30,),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Order Delivered",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400, decoration: TextDecoration.none,fontFamily: 'montserrat'),)
                        ],
                      ),

                    ],
                  ),
                ),



              ),
            ),


//          Padding(
//            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
//            child:  SizedBox(
//              width: double.infinity,
//              height: 50,
//              // match_parent
//              child: RaisedButton(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(15.0),
//                      side: BorderSide(color: HexColor("649FC3"))),
//                  color: HexColor("649FC3"),
//                  child: Text('Confirm Deliverd',
//                      style: TextStyle(color: Colors.white,fontSize: 14.0, fontWeight: FontWeight.bold )),
//                  onPressed: () async {
//
//
//                  }
//              ),
//            ),
//          ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                  color: HexColor("9ba905"),
                  borderRadius: BorderRadius.circular(5)),
              child: FlatButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                  child: Text(
                    'Continue shopping',
                    style: TextStyle( fontFamily: 'montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
            ),




          ],
        ),
      ),
    );

  }
}