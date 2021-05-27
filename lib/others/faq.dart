import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQ createState() => _FAQ();
}

class _FAQ extends State<FAQ> {
  String text1 ='''
General Questions

1. What is Aswaqrak.ae?
  -Aswaqrak.ae is an e-commerce website or an online store maintained and owned by a registered establishment named Al Aswaq RAK National Markets.
2. Where is Al Aswaq RAK National Markets located?
  -Al Aswaq RAK National Markets’ main branch is in Al Jazeera and other stores are located in Al Dhait, Al Kharan, Ghalilah, South Al Dhait, Masafi, Wadi Al Qor, Al Shaghie, Ras Al Khaimah, United Arab Emirates.
3.How we can shop online?
  -To shop online, please visit our website at www.aswaqrak.ae using a browser on your laptop or desktop or via mobile browser on your smartphone.
4. What type of items do you carry?
  -We currently make top selling grocery items available for online shopping yet we are taking steps to add more items in the future.
5. Who should we ask if we have further questions about your product?
  -Our website does contain few things about the product such as the name, photo and description.You may reach out to the item's manufacturer or brand to check more details about the product.

Ordering

1.  Can I do bulk order? Or is there minimum or maximum order?
  -Yes, but there will be minimum or maximum allowed quantity you can order for some items depending on its availability and difficulty in delivery.

2.  Can I view my previous orders?
  -Your previous orders can be viewed by logging into the website at www.aswaqrak.ae and check it in “My Account” section.

3.  Can I shop items now but checkout later?
  -You can shop items and add it to the list by clicking basket icon or “Add to Cart” button so you can order it later but remember that the availability of the items or price may change anytime; however, you can verify it before checkout of the order.

4.  How can I search a product?
  -You can search a product by entering the name or keywords on the search bar located on the top of the website next to the logo. Once entered, click the search icon then you will be redirected to the search results.

5.  How can I cancel or change my order?
  -Prior checking out your order, you can change the quantity or remove item/s by entering number of quantity or clicking delete button, respectively.


If you wish to cancel your order, you may contact our customer service at +971 600500202 or send us email at customerservice@aswaqrak.ae


Shipping & Delivery

1.  Is there FREE Delivery? If not, how much is the fee?
  -For orders with total amount of AED50(including VAT) or above, delivery is FREE of charge. But for orders less than AED50(including VAT) in total, a charge of AED15 will be incurred for Delivery.

2.  How soon can I get my order?
  -As soon as we have received the order, we will process it and deliver at the address you’ve specified in the website. We will make our most efforts to deliver within the delivery timing but we cannot guarantee that the delivery time frames will be met as there may be factors outside of our control that may result in early or delayed deliveries.

3.  Can I reorder item/s from my previous orders?
  -To reorder item/s you have previously ordered, please login into the website and check “My Order” section and click “Reorder”.

4.  Can I track my order?
  -Your order/s can be tracked by logging into the website and check it in “My Orders” section and see the status in column “Status”.

5.  Can I change my delivery address?
  -You may change your delivery address before checking out your order. However, you can’t change your delivery address through the website once you have placed your order.


If you wish to change the delivery address after placing the order, please give us a call at +971 600 500202 or email at customerservice@aswaqrak.ae''';

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
          'Frequently Asked Questions (FAQs)',
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

              verticalSpace(),

              Text(
                'General Questions',
                style: TextStyle( fontFamily: 'montserrat',
                  color: HexColor("302c98"),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,),
                textAlign: TextAlign.justify,
              ),
              verticalSpace(),
              Text(
                '''1.   What is Aswaqrak.ae?           
  -Aswaqrak.ae is an e-commerce website or an online store maintained and owned by a registered establishment named Al Aswaq RAK National Markets.

2.   Where is Al Aswaq RAK National Markets located?
  -Al Aswaq RAK National Markets’ main branch is in Al Jazeera and other stores are located in Al Dhait, Al Kharan, Ghalilah, South Al Dhait, Masafi, Wadi Al Qor, Al Shaghie, Al Zahra, Ras Al Khaimah, United Arab Emirates.

3.  How we can shop online?
  -To shop online, please visit our website at www.aswaqrak.ae using a browser on your laptop or desktop or via mobile browser on your smartphone.

4.  What type of items do you carry?
  -We currently make top selling grocery items available for online shopping yet we are taking steps to add more items in the future.

5.  Who should we ask if we have further questions about your product?
  -Our website does contain few things about the product such as the name, photo and description.You may reach out to the item's manufacturer or brand to check more details about the product.
''',
                style: TextStyle( fontFamily: 'montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.justify,),
              verticalSpace(),

              Text(
                'Ordering',
                style: TextStyle( fontFamily: 'montserrat',
                  color: HexColor("302c98"),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,),
                textAlign: TextAlign.justify,
              ),
              verticalSpace(),
              Text(
                '''1.  Can I do bulk order? Or is there minimum or maximum order?
  -Yes, but there will be minimum or maximum allowed quantity you can order for some items depending on its availability and difficulty in delivery.

2.  Can I view my previous orders?
  -Your previous orders can be viewed by logging into the website at www.aswaqrak.ae and check it in “My Account” section.

3.  Can I shop items now but checkout later?
  -You can shop items and add it to the list by clicking basket icon or “Add to Cart” button so you can order it later but remember that the availability of the items or price may change anytime; however, you can verify it before checkout of the order.

4.  How can I search a product?
  -You can search a product by entering the name or keywords on the search bar located on the top of the website next to the logo. Once entered, click the search icon then you will be redirected to the search results.

5.  How can I cancel or change my order?
  -Prior checking out your order, you can change the quantity or remove item/s by entering number of quantity or clicking delete button, respectively.
''',
                style: TextStyle( fontFamily: 'montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.justify,),
              verticalSpace(),
              verticalSpace(),

              Text(
                'Shipping & Delivery',
                style: TextStyle( fontFamily: 'montserrat',
                  color: HexColor("302c98"),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,),
                textAlign: TextAlign.justify,
              ),
              verticalSpace(),
              Text(
                '''1.  Is there FREE Delivery? If not, how much is the fee?
  -For orders with total amount of AED50(including VAT) or above, delivery is FREE of charge. But for orders less than AED50(including VAT) in total, a charge of AED15 will be incurred for Delivery.

2.  How soon can I get my order?
  -As soon as we have received the order, we will process it and deliver at the address you’ve specified in the website. We will make our most efforts to deliver within the delivery timing but we cannot guarantee that the delivery time frames will be met as there may be factors outside of our control that may result in early or delayed deliveries.

3.  Can I reorder item/s from my previous orders?
  -To reorder item/s you have previously ordered, please login into the website and check “My Order” section and click “Reorder”.

4.  Can I track my order?
  -Your order/s can be tracked by logging into the website and check it in “My Orders” section and see the status in column “Status”.

5.  Can I change my delivery address?
  -You may change your delivery address before checking out your order. However, you can’t change your delivery address through the website once you have placed your order.
''',
                style: TextStyle( fontFamily: 'montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.justify,),
              verticalSpace(),
              verticalSpace(),
            ],
          ),
        ),
      ),
    );
  }
}

