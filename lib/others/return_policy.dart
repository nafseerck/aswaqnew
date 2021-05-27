import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/material.dart';

class ReturnPolicy extends StatefulWidget {
  @override
  _ReturnPolicyState createState() => _ReturnPolicyState();
}

class _ReturnPolicyState extends State<ReturnPolicy> {
  String text1 ='''If you wish to return item/s, please give us a call at at +971 600 500202 or send us email at customerservice@aswaqrak.ae..

For perishable items such as fruits, vegetables, frozen, and fresh products, request for return can be requested on the same day within 3 hours from the delivery time.

Items that are non-perishable must be returned with its complete box or packaging and all accessories. Return request shall be requested up to 7 days from the delivery time for non-perishable items.

Refunds will be made in the same manner in which the purchase of the item was made; items purchased in cash will be refunded by cash while items purchased by credit/debit card will be refunded back in credit/debit card.

Our staff will be designated to collect back the item and refund will be processed. Please allow for up to 45 days for the refund transfer to be completed.''';

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
          'Refund And Return Policy',
          style: TextStyle( fontFamily: 'montserrat',
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(10,20,10,20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              verticalSpace(),

              Text(
                '   If you wish to return item/s, please give us a call at at +971 600 500202 or send us email at customerservice@aswaqrak.ae.',
                style: TextStyle( fontFamily: 'montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.justify,),
              verticalSpace(),
              Text(
                "  All perishable items cannot be returned or exchanged due to current COVID-19 situation. ",
                style: TextStyle( fontFamily: 'montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.justify,),
              verticalSpace(),

              Text(
                '   Items that are non-perishable must be returned with its complete box or packaging and all accessories. Return request shall be requested up to 7 days from the delivery time for non-perishable items.',
                style: TextStyle( fontFamily: 'montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.justify,),
              verticalSpace(),
              Text(
                '   Refunds will be made in the same manner in which the purchase of the item was made; items purchased in cash will be refunded by cash while items purchased by credit/debit card will be refunded back in credit/debit card.',
                style: TextStyle( fontFamily: 'montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.justify,),
              verticalSpace(),
              Text(
                '   Our staff will be designated to collect back the item and refund will be processed. Please allow for up to 45 days for the refund transfer to be completed.',
                style: TextStyle( fontFamily: 'montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.justify,),
              verticalSpace(),
              verticalSpace(),
              Text(
                'Cancellation Policy',
                style: TextStyle( fontFamily: 'montserrat',
                  color: HexColor("302c98"),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,),
                textAlign: TextAlign.justify,
              ),
              verticalSpace(),
              Text(
                '   If you wish to cancel your order, you may contact our customer service at +971 600500202 or send us email at customerservice@aswaqrak.ae.',
                style: TextStyle( fontFamily: 'montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.justify,),
              verticalSpace(),
              verticalSpace(),
              verticalSpace(),
            ],
          ),
        ),
      ),
    );
  }
}

