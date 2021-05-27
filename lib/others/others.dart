// ignore: must_be_immutable
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Alaswaq/others/delivery_imnformation.dart';
import 'package:Alaswaq/others/faq.dart';
import 'package:Alaswaq/others/notification2.dart';
import 'package:Alaswaq/others/terms_conditions.dart';
import 'package:Alaswaq/others/privacy_policy.dart';
import 'package:Alaswaq/others/return_policy.dart';

class Others extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Others',
      theme: ThemeData(
          // primarySwatch: AppColor.brandColor,
          ),
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Others')),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

// replace this function with the code in the examples
Widget _myListView(BuildContext context) {
  return ListView(
    children: <Widget>[
      ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FAQ()));
        },
        title: Text(
          'FAQ',
          style: TextStyle(
              fontFamily: 'montserrat', fontSize: 12, color: Colors.black),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DeliveryInformation()));
        },
        title: Text(
          'Delivery Information',
          style: TextStyle(
              fontFamily: 'montserrat', fontSize: 12, color: Colors.black),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TermsAndConditions()));
        },
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
              fontFamily: 'montserrat', fontSize: 12, color: Colors.black),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PrivacyPolicy()));
        },
        title: Text(
          'Privacy Policy',
          style: TextStyle(
              fontFamily: 'montserrat', fontSize: 12, color: Colors.black),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ReturnPolicy()));
        },
        title: Text(
          'Shipping and Returns',
          style: TextStyle(
              fontFamily: 'montserrat', fontSize: 12, color: Colors.black),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    ],
  );
}
