import 'dart:convert';
import 'dart:io';

import 'package:Alaswaq/Model/register_model.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/payment/review_and_payments.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddressProfileEdit extends StatefulWidget{
  String fromPage = "" ;
  AddressProfileEdit(this.fromPage);

AddressProfileEditState createState()=> AddressProfileEditState();
}


class AddressProfileEditState extends State<AddressProfileEdit> {
  static var userName = "";
  static var phoneNum = "";
  static var isloggedIn = false;
  List<String> street = new List<String>();
  var city = "";

  static var password = "";

  static var emailid = "";
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final phonController = TextEditingController();
  UserRegistration userreg_model;
  List<String> _locations ;
  final globalKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getUserInfo();
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        backgroundColor:  Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: new Center(child: new Text('Add Address',style: TextStyle( fontFamily: 'montserrat',
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ),
        leading: GestureDetector(
          onTap: ()=>Navigator.pop(context),
          child: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                size: 40,
                color: Colors.black,
              ),
              onPressed: () {

                  Navigator.pop(context);

              }),
//          Icon(
//            Icons.keyboard_backspace,
//            color: Colors.black,
//            size: 30,
//          ),
        ),

      ),
      body: Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
          builder: (BuildContext context) {
            return Form(
                key: _key,
                autovalidate: _validate,

//        width: MediaQuery.of(context).size.width,
//        height: MediaQuery.of(context).size.height,
//        color: Colors.white,
                child:
                Padding(
                  padding: EdgeInsets.all(15.0),
                    child: Column(
  children: [
    TextFormField(
      keyboardType: TextInputType.number,
      controller: phonController,
      validator: validateMobile,
//                          enabled: checkedValue ? false : true,
      decoration: InputDecoration(
        hintText: 'Phone Number',
        hintStyle: TextStyle( fontFamily: 'montserrat', color:  Colors.black54, fontSize: 15),
        border: OutlineInputBorder(),
      ),
    ),
    verticalSpace(),
    TextFormField(
      keyboardType: TextInputType.text,
      validator: validateAddress,
      controller: addressController,
//                          enabled:checkedValue && street0  == "" ? false : true,
      decoration: InputDecoration(
        hintText:  ' Address',
        hintStyle: TextStyle( fontFamily: 'montserrat',color:  Colors.black54,  fontSize: 15),
        border: OutlineInputBorder(),
      ),
    ),
    verticalSpace(),
    TextFormField(
      keyboardType: TextInputType.text,
      controller: stateController,
//                          enabled: checkedValue && street1  == "" ? false : true,
      decoration: InputDecoration(
        hintText:' Area Landmark',
        hintStyle: TextStyle( fontFamily: 'montserrat',color:  Colors.black54,  fontSize: 15),
        border: OutlineInputBorder(),
      ),
    ),
    verticalSpace(),
    TextFormField(
      enabled: false,

      keyboardType: TextInputType.text,
      controller: cityController,
      decoration: InputDecoration(
        hintText: 'Ras Al-Khaimah',
        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 15),
        border: OutlineInputBorder(),
      ),
    ),
    verticalSpace(),
    TextFormField(
      enabled: false,
//                          initialValue: 'United Arab Emirates',
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'United Arab Emirates',
        hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.black, fontSize: 15),
        border: OutlineInputBorder(),
      ),
    ),
    verticalSpace(),
    RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: HexColor("302d98"))),
        color: HexColor("302d98"),

        onPressed: () {
            if (_key.currentState
                .validate()) {
              editMyAccount();
            }

          },
        child: Text(
          'SAVE',
          style: TextStyle( fontFamily: 'montserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        )),

  ],
),
                )

            );


          }

      ),
    );









  }
  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }
  String validateAddress(String value) {

    if (value.length == 0) {
      return "Address is Required";
    }
    return null;
  }

  Future editMyAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;

    Map data =
//    {
//      "customer": {"firstname" : newNmae}
//    };
    {
      "customer": {
        "firstname": userName,
        "lastname": "lastname",

        "addresses": [
          {
//            "region": null,
//            "region_id": null,
//            "region_code": null,
            "country_id": "AE",
            "street": [
              addressController.text,
              stateController.text,
            ],
            "telephone": phonController.text,

            "city": "Ras Al-Khaimah",
            "firstname": userName,
            "lastname": userreg_model.lastname,
          }
        ],
        "email": userreg_model.email,
        "store_id": 1,
        "website_id": 1
      }
    };

    //encode Map to JSON
    var body = json.encode(data);
print(body);
    var response = await http.put(Uri.parse(baseUrl + 'rest/V1/customers/me'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        },
        body: body
    );


    final responseJson = json.decode(response.body);
    print(responseJson);

    print("name chandeg");
    prefs.setString('firstname', userName);
    setState(() {
      ReviewAndPaymentsState.userName = userName;
      ReviewAndPaymentsState.phoneNum = phonController.text;
      ReviewAndPaymentsState.street0= addressController.text;
      ReviewAndPaymentsState.street1= stateController.text;
      ReviewAndPaymentsState.city= "Ras Al-Khaimah";
      ReviewAndPaymentsState.street1 = cityController.text;
      ReviewAndPaymentsState.emailid = emailid;
    });
    if(widget.fromPage == "from Review" ) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewAndPayments("from address"),
        ),
      );
    }


    return response;
  }
  Future<bool> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString('firstname');
      emailid = prefs.getString('email');
      print(emailid);
      Map json = jsonDecode(prefs.getString('userData'));
      userreg_model = UserRegistration.fromJson(json);
    });
  }
}