import 'dart:convert';
import 'dart:io';
import 'package:Alaswaq/Model/register_model.dart';
import 'package:Alaswaq/Network/api_repository.dart';
import 'package:Alaswaq/account/profile/my_account.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/dashboard.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/account/login/login_page.dart';
import 'package:Alaswaq/main.dart';
import 'package:Alaswaq/orders/orders.dart';
import 'package:Alaswaq/payment/review_and_payments.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/strings.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:Alaswaq/utils/style/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Register extends StatefulWidget {
  int toPageId;

  Register({this.toPageId});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _validate = false;

  GlobalKey<FormState> _key = new GlobalKey();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool rememberMe = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(),
//            Align(
//              alignment: Alignment.bottomLeft,
//              child:
//              IconButton(
//                  icon: Icon(
//                    Icons.keyboard_backspace,
//                    size: 40,
//                    color: Colors.white,
//                  ),
//                  onPressed: () {
//                    Navigator.pop(context);
//                  }),
//            ),
            verticalSpace(),
            Center(
                child: Image.asset(
              'assets/images/logo.png',
              height: 100,
              width: 150,
            )),
            verticalSpace(),
            verticalSpace(),
            Text(
              'NEW CUSTOMERS',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'montserrat',
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Creating an account has many benefits: check out faster, keep more than one address, track orders and more.',
                textAlign: TextAlign.center,
                style: textStyleW16,
              ),
            ),
            verticalSpace(),
            verticalSpace(),
            verticalSpace(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Form(
                key: _key,
                autovalidate: _validate,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        validator: validateName,
                        style: TextStyle(
                          fontFamily: 'montserrat',
                          color: Colors.black87,
                          // fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 15.0,
                          ),
                          hintText: 'First Name',
                          hintStyle: textStyleG16,
                        ),
                      ),
                    ),
                    verticalSpace(),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: lastNameController,
                        validator: validateName,
                        style: TextStyle(
                          fontFamily: 'montserrat',
                          color: Colors.black87,
                          // fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 15.0,
                          ),
                          hintText: 'Last Name',
                          hintStyle: textStyleG16,
                        ),
                      ),
                    ),
                    verticalSpace(),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontFamily: 'montserrat',
                          color: Colors.black87,
                          // fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 15.0,
                          ),
                          hintText: 'Email',
                          hintStyle: textStyleG16,
                        ),
                      ),
                    ),
                    verticalSpace(),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        validator: validatePassword,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        style: TextStyle(
                          fontFamily: 'montserrat',
                          color: Colors.black87,
                          // fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 15.0,
                          ),
                          hintText: 'Password',
                          hintStyle: textStyleG16,
                        ),
                      ),
                    ),
                    verticalSpace(),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
//                controller: passwordController,
//                validator: validatePassword,
//                keyboardType: TextInputType.visiblePassword,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        style: TextStyle(
                          fontFamily: 'montserrat',
                          color: Colors.black87,
                          // fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 15.0,
                          ),
                          hintText: 'Confirm Password',
                          hintStyle: textStyleG16,
                        ),
                      ),
                    ),
                    verticalSpace(),
                    verticalSpace(),
                    Container(
//      padding: EdgeInsets.symmetric(vertical: 25.0),
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () async {
                          if (_key.currentState.validate()) {
                            _globalKey.currentState.showSnackBar(new SnackBar(
                              duration: new Duration(seconds: 4),
                              backgroundColor: Colors.white,
                              content: new Row(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/icons/loadingicon2.gif",
                                    height: 60.0,
                                    width: 60.0,
                                  ),
                                  new Text("  Signing-In...")
                                ],
                              ),
                            ));
                            resgisterUserApi(
                                    emailController.text,
                                    nameController.text,
                                    lastNameController.text,
//                                  phoneController
//                                      .text,
                                    passwordController.text)
                                .then((userDataFromServer) {
                              if (userDataFromServer != null) {
                                /*ToDo*/
                                //            Save UserData
//                                                                saveUserData(userDataFromServer);

                              } else {
                                print("already registerd ");
                                final snackBar = SnackBar(
                                    content: Text('User already Registerd'));
                                _globalKey.currentState.showSnackBar(snackBar);
                              }
                            });
                          } else {
                            // validation error
                            setState(() {
                              _validate = true;
                            });
                          }
                        },
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: Color(0xFF9BA905),
                        child: Text(
                          'CREATE AN ACCOUNT',
                          style: TextStyle(
                            fontFamily: 'montserrat',
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            // fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Text(
                    'Have an Account?',
                    style: TextStyle(
                        fontFamily: 'montserrat', color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LogInPage(1)));
                  },
                  child: Text('Login',
                      style: TextStyle(
                          fontFamily: 'montserrat',
                          decoration: TextDecoration.underline,
                          color: Colors.white)),
                ),
                Checkbox(
                  value: rememberMe,
                  onChanged: _onRememberMeChanged,
                ),
                Text(
                  'Signup for Newsletter',
                  style:
                      TextStyle(fontFamily: 'montserrat', color: Colors.white),
                ),
              ],
            ),
            verticalSpace(),
            verticalSpace(),
            verticalSpace(),
            verticalSpace(),
          ],
        ),
      ),
    );
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
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

  String validatePassword(String value) {
    String patttern =
        r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,15}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "password is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Password should contain Lower Case, Upper Case, Digits, Special Characters.";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  Future saveUserData(UserRegistration userDataFromServer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isLoggedIn', true);
    prefs.setString('email', userDataFromServer.email);
    prefs.setString('password', passwordController.text);
    prefs.setInt('customer_id', userDataFromServer.id);
    prefs.setString('firstname', userDataFromServer.firstname);
    prefs.setString('lastname', userDataFromServer.lastname);
    var address = userDataFromServer.addresses;
    HomePage.addressValue = address;
    prefs.setString('phone', address[0].telephone);
    prefs.setStringList('street', address[0].street);
    prefs.setString('city', address[0].city);
    setState(() {
      HomePageState.isLogin == true;
    });
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) =>
//              ReviewAndPayments(),
//        ));
    if (widget.toPageId == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } else if (widget.toPageId == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrdersList("From Home"),
          ));
    } else if (widget.toPageId == 3) {
//      Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) =>
//                ReviewAndPayments(),
//          ));
    }
  }

  Future resgisterUserApi(
      String email, String firstName, String lstName, String password) async {
    var url = baseUrl + 'rest/V1/customers';
    try {
      Map data = {
        "customer": {
          "email": email,
          "firstname": firstName,
          "lastname": lstName,
          "store_id": 1,
          "website_id": 1,
          // "addresses": [
          //   {
//              "region_id": 0,
//              "firstname": firstName,
//              "lastname": lstName,
//              "postcode": "345553",
//              "city": "Ras al Khaimah",
//              "street": [  "Ras al Khaimah" ],
//              "telephone": "2324",
//              "country_id": "AE"
//             }
//           ]
        },
        "password": password
      };
      print(data);
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        print("registration response");
        print(responseJson);

        debugPrint('after parsing');
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('userData', response.body);

        print(responseJson['email']);

        prefs.setBool('isLoggedIn', true);
        prefs.setString('email', responseJson['email']);
        prefs.setString('password', passwordController.text);
        prefs.setInt('customer_id', responseJson['id']);
        prefs.setString('firstname', responseJson['firstname']);
        var arr = responseJson['addresses'];
        print(responseJson['addresses']);
//        print(arr[0]['telephone']);
        if (arr.length > 0) {
          print("inside");
//          print(arr[0].telephone);
          prefs.setString('phone', arr[0]['telephone']);
          prefs.setString('postalcode', arr[0]['postalcode']);
          prefs.setStringList('street', arr[0]['street']);
        }

//        var address =   userData.addresses;
//        HomePage.addressValue = address ;
//        prefs.setString('phone', address[0].telephone);
//        prefs.setStringList('street', address[0].street);
//        prefs.setString('city', address[0].city);
        setState(() {
          HomePageState.isLogin = true;
        });
        listenForUserKey();
        addCartUserQuote();
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) =>
//                  ReviewAndPayments(),
//            ));
        if (widget.toPageId == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ));
        } else if (widget.toPageId == 6) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrdersList("From Bottom"),
              ));
        } else if (widget.toPageId == 7) {
          setState(() {
            HomePage.isGuestManagement = true;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyAccount("from Login"),
              ));
        } else if (widget.toPageId == 3) {
          print("3");
          setState(() {
            HomePage.isGuestManagement = true;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewAndPayments("from Login"),
              ));
//
        }
      } else {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> listenForUserKey() async {
    var url = baseUrl + 'rest/V1/integration/customer/token';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('email');
    String password = prefs.getString('password');
    print("listen for user key");
    print(username);
    print(password);
    Map data = {"username": username, "password": password};

//    Map data =  {
//      "username": "abc@abc.abc",
//      "password": "Qwerty1@"
//    };

    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    prefs.setString('userKey', response.body);
    String token = prefs.getString('userKey');
    print("user key");
    print("${token}");
    return response;
  }

  Future addCartUserQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;

    final response = await http.post(Uri.parse(
      'http://aswaqrak.ae/rest/V1/carts/mine'),
      headers: {HttpHeaders.authorizationHeader: headerText},
    );
    final responseJson = json.decode(response.body);
    prefs.setString('userQuoteId', response.body);
    return response;
  }
}
