import 'dart:convert';
import 'dart:io';

import 'package:Alaswaq/Model/register_model.dart';
import 'package:Alaswaq/account/profile/my_account.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/payment/review_and_payments.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditMyAccount extends StatefulWidget {
  @override
  _EditMyAccountState createState() => _EditMyAccountState();
}

class _EditMyAccountState extends State<EditMyAccount> {
  GlobalKey<FormState> _formKey = GlobalKey();
  static var userName = "";
  static var phoneNum = "";
  static var isloggedIn = false;
  List<String> street = new List<String>();
  var city = "";

  static var password = "";

  static var emailid = "";

  UserRegistration userreg_model;

  TextEditingController lastNameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController(text: userName);
  TextEditingController emailController = new TextEditingController(text: emailid);
  TextEditingController passwordController = new TextEditingController(text: password);
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();


  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getUserInfo();
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
          'Edit My Account',
          style: TextStyle( fontFamily: 'montserrat', 
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                editMyAccount(emailController.text, firstNameController.text, lastNameController.text, passwordController.text, phoneController.text);

              })
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 15, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Name',
                      style: TextStyle( fontFamily: 'montserrat', 
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .65,
                      decoration: BoxDecoration(),
                      child: TextFormField(
//                        initialValue: userName,
//                        style: TextStyle( fontFamily: 'montserrat', color: Colors.black),
                        keyboardType: TextInputType.text,
                                controller: firstNameController,
//                                validator: validateEmail,
                        decoration: InputDecoration(
//                          hintText: 'Name',
                          contentPadding: EdgeInsets.only(top: 5, left: 10),
                          hintStyle: TextStyle( fontFamily: 'montserrat', 
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
//                    SizedBox(
//                      child: FlatButton(
//                        onPressed: () async {
////                        Navigator.pushReplacement(
////                          context,
////                          MaterialPageRoute(
////                            builder: (context) => EditName(),
////                          ),
////                        );
//                        },
//
//                        child: Row(
//                          children: [
//                            Text(userName,
//                                style: TextStyle( fontFamily: 'montserrat', 
//                                    color: Colors.black,
//                                    fontSize: 16,
//                                    fontWeight: FontWeight.w400,
//                                    )),
////                          Icon(Icons.chevron_right)
//                          ],f
//                        ),
////                              textColor: MyColors.white,
//                        shape: RoundedRectangleBorder(
//                            side: BorderSide(
//                                color: Colors.white,
//                                width: 0.5,
//                                style: BorderStyle.solid),
//                            borderRadius: BorderRadius.circular(5)),
//                      ),
//                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Email',
                      style: TextStyle( fontFamily: 'montserrat', 
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          ),
                    ),

//                    SizedBox(
//                      child: FlatButton(
//                        onPressed: () async {
////                        Navigator.pushReplacement(
////                          context,
////                          MaterialPageRoute(builder: (context) => EditProfileField("Change Email")),
////
////                        );
//                        },
//                        child: Row(
//                          children: [
//                            Text(emailid,
//                                style: TextStyle( fontFamily: 'montserrat', 
//                                    color: Colors.black,
//                                    fontSize: 16,
//                                    fontWeight: FontWeight.w400,
//                                    )),
////                          Icon(Icons.chevron_right)
//                          ],
//                        ),
////                              textColor: MyColors.white,
//                        shape: RoundedRectangleBorder(
//                            side: BorderSide(
//                                color: Colors.white,
//                                width: 0.5,
//                                style: BorderStyle.solid),
//                            borderRadius: BorderRadius.circular(5)),
//                      ),
//                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .65,
                      decoration: BoxDecoration(),
                      child: TextFormField(
//                        initialValue: emailid,style: TextStyle( fontFamily: 'montserrat', color: Colors.black),
//                        keyboardType: TextInputType.emailAddress,
                                controller: emailController,
//                                validator: validateEmail,
                        decoration: InputDecoration(
//                          hintText: 'Name',
                          contentPadding: EdgeInsets.only(top: 5, left: 10),
                          hintStyle: TextStyle( fontFamily: 'montserrat', 
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Password',
                      style: TextStyle( fontFamily: 'montserrat', 
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .65,
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                          obscureText: true,
//                        initialValue: "..........",style: TextStyle( fontFamily: 'montserrat', color: Colors.black),
                                controller: passwordController,
//                                validator: validateEmail,
                        decoration: InputDecoration(
//                          hintText: '***********',
                          contentPadding: EdgeInsets.only(top: 5, left: 10),
                          hintStyle: TextStyle( fontFamily: 'montserrat', 
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

//                    SizedBox(
//                      child: FlatButton(
//                        onPressed: () async {
////                        Navigator.push(
////                          context,
////                          MaterialPageRoute(builder: (context) => EditPassword(password)),
////                        );
//                        },
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                            Text('............',
//                                style: TextStyle( fontFamily: 'montserrat', 
//                                    color: Colors.black,
//                                    fontSize: 16,
//                                    fontWeight: FontWeight.w400,
//                                    )),
////                          Icon(Icons.chevron_right)
//                          ],
//                        ),
////                              textColor: MyColors.white,
//                        shape: RoundedRectangleBorder(
//                            side: BorderSide(
//                                color: Colors.white,
//                                width: 0.5,
//                                style: BorderStyle.solid),
//                            borderRadius: BorderRadius.circular(5)),
//                      ),
//                    ),
                  ],
                ),
                SizedBox(height: 10,),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text(
//                      'Mobile',
//                      style: TextStyle( fontFamily: 'montserrat',
//                          color: Colors.grey,
//                          fontSize: 16,
//                          fontWeight: FontWeight.w400,
//                          ),
//                    ),
//                    Container(
//                      height: 40,
//                      width: MediaQuery.of(context).size.width * .65,
//                      decoration: BoxDecoration(),
//                      child: TextFormField(
//                        keyboardType: TextInputType.number,
////                        initialValue: "..........",style: TextStyle( fontFamily: 'montserrat', color: Colors.black),
//                                controller: phoneController,
////                                validator: validateEmail,
//                        decoration: InputDecoration(
//                          hintText: 'Phone Number',
//                          contentPadding: EdgeInsets.only(top: 5, left: 10),
//                          hintStyle: TextStyle( fontFamily: 'montserrat',
//                            color: Colors.black,
//                          ),
//                          border: OutlineInputBorder(),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
                verticalSpace(),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Text(
//                      'Address',
//                      style: TextStyle( fontFamily: 'montserrat',
//                          color: Colors.grey,
//                          fontSize: 16,
//                          fontWeight: FontWeight.w400,
//                          ),
//                    ),
//
//                    Container(
//                      height: 40,
//                      width: MediaQuery.of(context).size.width * .65,
//                      decoration: BoxDecoration(),
//                      child: TextFormField(
//                        keyboardType: TextInputType.text,
////                        initialValue: "..........",style: TextStyle( fontFamily: 'montserrat', color: Colors.black),
//                                controller: addressController,
////                                validator: validateEmail,
//                        decoration: InputDecoration(
//                          hintText: 'Address',
//                          contentPadding: EdgeInsets.only(top: 5, left: 10),
//                          hintStyle: TextStyle( fontFamily: 'montserrat',
//                            color: Colors.black,
//                          ),
//                          border: OutlineInputBorder(),
//                        ),
//                      ),
//                    ),
////                  SizedBox(
////                    child: FlatButton(
////                      onPressed: () async {
//////                        Navigator.push(
//////                          context,
//////                          MaterialPageRoute(builder: (context) => EditProfileField("Change Address")),
//////                        );
////                      },
////                      child: Row(
////                        children: [
////                          Text("city",
////                              style: TextStyle( fontFamily: 'montserrat',
////                                  color: Colors.black,
////                                  fontSize: 16,
////                                  fontWeight: FontWeight.w400,
////                                  )),
//////                          Icon(Icons.chevron_right)
////                        ],
////                      ),
//////                              textColor: MyColors.white,
////                      shape: RoundedRectangleBorder(
////                          side: BorderSide(
////                              color: Colors.white,
////                              width: 0.5,
////                              style: BorderStyle.solid),
////                          borderRadius: BorderRadius.circular(5)),
////                    ),
////                  ),
//                  ],
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future editMyAccount(
      String email, String firstName, String lstName, String password, String phone) async {


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
        "firstname": firstName,
        "lastname": firstName,
        "password": password,
//        "addresses": [
//          {
//            "region_id": userreg_model.addresses[0].region.regionId,
//            "country_id": userreg_model.addresses[0].countryId,
//            "street": userreg_model.addresses[0].street,
//            "telephone": phone,
//            "postcode": userreg_model.addresses[0].postcode,
//            "city": userreg_model.addresses[0].postcode,
//            "firstname": firstName,
//            "lastname": userreg_model.lastname,
//          }
//        ],
        "email": email,
        "store_id": 1,
        "website_id": 1
      }
    };

    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.put(Uri.parse(baseUrl + 'rest/V1/customers/me'),
        headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText},
        body: body
    );


    final responseJson = json.decode(response.body);
    print(responseJson);

    print("name chandeg");
    prefs.setString('firstname', firstName);
    setState(() {
      _EditMyAccountState.userName = firstName;
      _EditMyAccountState.phoneNum = phone;
      _EditMyAccountState.emailid = email;
      prefs.setString('email', email);
      prefs.setString('password', password);
      prefs.setString('firstname', firstName);
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyAccount("From Home"),
      ),
    );


    return response;

//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('userKey');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//
//    var url = baseUrl + 'rest/V1/customers';
//    try {
//      Map data = {
//        "customer": {
//          "email": email,
//          "firstname": firstName,
//          "lastname": firstName,
//          "store_id": 1,
//          "website_id": 1,
//          "addresses": [
//            {
//              "region_id": userreg_model.addresses[0].region.regionId,
//              "country_id": userreg_model.addresses[0].countryId,
//              "street": userreg_model.addresses[0].street,
//              "telephone": phone,
//              "postcode": userreg_model.addresses[0].postcode,
//              "city": userreg_model.addresses[0].postcode,
//              "firstname": firstName,
//              "lastname": firstName,
//            }
//          ]
//        },
//        "password": password
//      };
//      print(data);
//      //encode Map to JSON
//      var body = json.encode(data);
//
//      var response = await http.put(url,
//          headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText}, body: body);
//      if (response.statusCode == 200) {
//        final responseJson = json.decode(response.body);
//        print("registration response");
//        print(responseJson);
//
//        UserRegistration userData = UserRegistration.fromJson(responseJson);
//        debugPrint('after parsing');
//        final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//        String user = jsonEncode(UserRegistration.fromJson(responseJson));
//        prefs.setString('userData', user);
//
//        prefs.setBool('isLoggedIn', true);
//        prefs.setString('email', userData.email);
//        prefs.setString('password', passwordController.text);
//        prefs.setInt('customer_id', userData.id);
//        prefs.setString('firstname', userData.firstname);
//        prefs.setString('lastname', userData.lastname);
////        var address =   userData.addresses;
////        HomePage.addressValue = address ;
////        prefs.setString('phone', address[0].telephone);
////        prefs.setStringList('street', address[0].street);
////        prefs.setString('city', address[0].city);
//        setState(() {
//          HomePageState.isLogin = true;
//        });
//        Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(
//            builder: (context) => EditMyAccount(),
//          ),
//        );
////        Navigator.push(
////            context,
////            MaterialPageRoute(
////              builder: (context) => ReviewAndPayments(),
////            ));
////        if (widget.toPageId == 1) {
////          Navigator.push(
////              context,
////              MaterialPageRoute(
////                builder: (context) => HomePage(),
////              ));
////        } else if (widget.toPageId == 2) {
////          Navigator.push(
////              context,
////              MaterialPageRoute(
////                builder: (context) => OrdersList(),
////              ));
////        } else if (widget.toPageId == 3) {
////          setState(() {
////            HomePage.isGuestManagement = true;
////          });
////          Navigator.push(
////              context,
////              MaterialPageRoute(
////                builder: (context) => ReviewAndPayments(),
////              ));
////        }
//        return userData;
//      } else {
//        debugPrint('list ERROR');
//        return null;
//        throw Exception("Error");
//      }
//    } catch (e) {
//      throw Exception(e.toString());
//    }
  }

  Future<bool> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString('firstname');
      phoneNum = prefs.getString('phone');
      street = prefs.getStringList('street');
      city = prefs.getString('city');
      password = prefs.getString('password');
      emailid = prefs.getString('email');
      Map json = jsonDecode(prefs.getString('userData'));
      userreg_model = UserRegistration.fromJson(json);
    });
  }
}
