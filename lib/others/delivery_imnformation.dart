import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/material.dart';

class DeliveryInformation extends StatefulWidget {
  @override
  _DeliveryInformationState createState() => _DeliveryInformationState();
}

class _DeliveryInformationState extends State<DeliveryInformation> {
  String text1 ='''Delivery
Delivery Charges
Orders above AED50 in total will be FREE delivery, while orders below AED50 will be charged AED15 as delivery fee.

Delivery Policy
All orders will be delivered by our staff using our own vehicles at the address you have specified through the Platform. Orders made after 4:00PM will be processed and delivered the next day starting 8:00AM. For orders placed from 8:00AM to 4:00PM, deliveries will be performed on the same day.

On the event that for any deliveries made outside the expected delivery time frame, you therefore agree that we shall not be liable. We will make our most efforts to deliver within the delivery timing but we cannot guarantee that the delivery time frames will be met as there may be factors outside of our control that may result in early or delayed deliveries.

For some instance which is beyond of our control such as the absence of the recipient on delivery, inaccurate or incomplete instruction of the delivery address, lack of an access permit, bad weather conditions resulting to a great difficulty of delivery, then orders shall be deemed to be cancelled. On the same event, you will not be entitled for compensation or any kind, however; for online payment, we will initiate and process the refund upon cancellation of the order, it is the responsibility of the bank to transfer the amount to your account, which takes approximately 3-5 working days.

All orders through our Platform are available for delivery within Ras Al Khaimah only.

Refund And Return Policy
If you wish to return item/s, please give us a call at at +971 600 500202 or send us email at customerservice@aswaqrak.ae.

For perishable items such as fruits, vegetables, frozen, and fresh products, request for return can be requested on the same day within 3 hours from the delivery time.

Items that are non-perishable must be returned with its complete box or packaging and all accessories. Return request shall be requested up to 7 days from the delivery time for non-perishable items.

Refunds will be made in the same manner in which the purchase of the item was made; items purchased in cash will be refunded by cash while items purchased by credit/debit card will be refunded back in credit/debit card.

Our staff will be designated to collect back the item and refund will be processed. Please allow for up to 45 days for the refund transfer to be completed.

Cancellation Policy
If you wish to cancel your order, you may contact our customer service at +971 600500202 or send us email at customerservice@aswaqrak.ae.''';

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
          'Delivery Information',
          style: TextStyle( fontFamily: 'montserrat',
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
//          height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(10,20,10,20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Charges',
                  style: TextStyle( fontFamily: 'montserrat',
                      color:  HexColor("302c98"),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                verticalSpace(),
                Text(
                  " Orders above AED 50 in total will be FREE delivery, while orders below AED 50 will be charged AED15 as delivery fee.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14), textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  'Delivery Policy',
                  style: TextStyle( fontFamily: 'montserrat',
                    color:  HexColor("302c98"),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
                verticalSpace(),
                Text(
                  "   All orders will be delivered by our staff using our own vehicles at the address you have specified through the Platform. Orders made after 6:30PM onwards will be processed and delivered the next day starting 8:00AM. For orders placed from 8:00AM to 6:30PM, deliveries will be performed on the same day.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),

                verticalSpace(),
                Text(
                  "   On the event that for any deliveries made outside the expected delivery time frame, you therefore agree that we shall not be liable. We will make our most efforts to deliver within the delivery timing but we cannot guarantee that the delivery time frames will be met as there may be factors outside of our control that may result in early or delayed deliveries.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  "   For some instance which is beyond of our control such as the absence of the recipient on delivery, inaccurate or incomplete instruction of the delivery address, lack of an access permit, bad weather conditions resulting to a great difficulty of delivery, then orders shall be deemed to be cancelled. On the same event, you will not be entitled for compensation or any kind, however; for online payment, we will initiate and process the refund upon cancellation of the order, it is the responsibility of the bank to transfer the amount to your account, which takes approximately 3-5 working days.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),textAlign: TextAlign.justify,),
                verticalSpace(),
                verticalSpace(),
                Text(
                  "All orders through our Platform are available for delivery within Ras Al Khaimah only.",
                  style: TextStyle( fontFamily: 'montserrat',
                      color:  HexColor("302c98"),
                      fontWeight: FontWeight.w600,
                      fontSize: 14),textAlign: TextAlign.justify,),

              ],
            )

        ),
      ),
    );
  }
}

