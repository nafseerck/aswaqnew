import 'dart:convert';
import 'dart:io';
import 'package:Alaswaq/Model/register_model.dart';
import 'package:Alaswaq/Network/api_repository.dart';
import 'package:Alaswaq/account/profile/my_account.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/dashboard.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/main.dart';
import 'package:Alaswaq/orders/orders.dart';
import 'package:Alaswaq/payment/review_and_payments.dart';
import 'package:Alaswaq/account/register/register.dart';
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
class LogInPage extends StatefulWidget {
  int toPageId = 1;
  LogInPage(this.toPageId);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _validate = false;
  GlobalKey<FormState> _key = new GlobalKey();

  GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      key: _globalKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(),
            verticalSpace(),
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.keyboard_backspace,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (widget.toPageId == 7 || widget.toPageId == 6) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(),
                          ));
                    } else {
                      Navigator.pop(context);
                    }
                  }),
            ),
            verticalSpace(),
            verticalSpace(),
            verticalSpace(),
            Center(
                child: Image.asset(
              'assets/images/logo.png',
              height: 100,
              width: 150,
            )),
            verticalSpace(),
            verticalSpace(),
            verticalSpace(),
            Text(
              'LOGIN TO YOUR ACCOUNT',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'montserrat',
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            verticalSpace(),
            verticalSpace(),
            verticalSpace(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Column(
                children: [
                  _buildForm(),
                  verticalSpace(),
                  verticalSpace(),
                  GestureDetector(
                    child: Text(
                      'Forgot Password?',
                      style: textStyleW16,
                    ),
                  ),
                  verticalSpace(),
                  verticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey,
//                          width: MediaQuery.of(context).size.width,
                          height: 1,
                        ),
                      ),
//                      snded(
//                         child: Container(
//                           color: Colors.grey,
// //                          width: MediaQuery.of(context).size.width,
//                           height: 1,
//                         ),
//                       ),
                    ],
                  ),
                  // verticalSpace(),
                  // verticalSpace(),
                  // _buildSignInSocialBtn(
                  //     color: Color(0xFF395898),
                  //     text: 'FACEBOOK',
                  //     icons: FontAwesomeIcons.facebookF),
                  // verticalSpace(),
                  // verticalSpace(),
                  // _buildSignInSocialBtn(
                  //   text: 'TWITTER',
                  //   icons: FontAwesomeIcons.twitter,
                  //   color: Color(0xFF1CCAFF),
                  // ),
                  // verticalSpace(),
                  // verticalSpace(),
                  // _buildSignInSocialBtn(
                  //   text: 'GOOGLE +',
                  //   icons: FontAwesomeIcons.googlePlusG,
                  //   color: Color(0xFFDE4B39),
                  // ),
                  // verticalSpace(),
                  // verticalSpace(),
                  GestureDetector(
                    child: Text(
                      'Don\'t have an Account?',
                      style: textStyleW16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              Register(toPageId: widget.toPageId)));
                    },
                    child: Text(
                      'Register',
                      style: textStyleWU16,
                    ),
                  ),
                  verticalSpace(),
                  verticalSpace(),
                  verticalSpace(),
                  verticalSpace(),
                  verticalSpace(),
                  verticalSpace(),
                  verticalSpace(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _key,
      autovalidate: _validate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
//                 // fontFamily: 'OpenSans',
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
          verticalSpace(),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: passwordController,
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
          verticalSpace(),
          Container(
//      padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () async {
                if (_key.currentState.validate()) {
                  _globalKey.currentState.showSnackBar(new SnackBar(
                    backgroundColor: Colors.white,
                    duration: new Duration(seconds: 2),
                    content: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image.asset(
                          "assets/images/icons/loadingicon2.gif",
                          height: 60.0,
                          width: 60.0,
                        ),
                        new Text(
                          "  Login-In...",
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ));
                  ApiRepository.loginTokenApi(
                          emailController.text, passwordController.text)
                      .then((usertokenFromServer) {
                    if (usertokenFromServer != null) {
                      loginUserApi(usertokenFromServer).then(
                        (userDataFromServer) {
                          if (userDataFromServer != null) {
                            /*ToDo*/
                            //            Save UserData
                            setState(() {
                              HomePageState.isLogin = true;
                            });
                          } else {
                            print("already LoggedIn");
                            final snackBar = SnackBar(
                                content: Text(
                                    'Something went wrong.. Please try again later'));
                            _globalKey.currentState.showSnackBar(snackBar);
                          }
                        },
                      );
                    } else {
                      final snackBar =
                          SnackBar(content: Text("User Dosn't exist"));
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
                'LOGIN',
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
    );
  }

  Widget _buildSignInSocialBtn({String text, IconData icons, Color color}) {
    return Container(
//      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'montserrat',
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'OpenSans',
                ),
              ),
              Icon(
                icons,
                color: Colors.white,
              )
            ],
          )),
    );
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
    prefs.setInt('customer_id', userDataFromServer.id);
    prefs.setString('firstname', userDataFromServer.firstname);
    prefs.setString('lastname', userDataFromServer.lastname);
    prefs.setString('password', passwordController.text);
    var address = userDataFromServer.addresses;
    HomePage.addressValue = address;
    prefs.setString('phone', address[0].telephone);
    prefs.setStringList('street', address[0].street);
    prefs.setString('city', address[0].city);
    setState(() {
      // ignore: unnecessary_statements
      HomePageState.isLogin == true;
    });
  }

  Future loginUserApi(String token) async {
    var url = baseUrl + 'rest/V1/customers/me';
    try {
      String headerText = "Bearer " + token;
      var response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      });
      final responseJson = json.decode(response.body);

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

        if (arr.length > 0) {
          print("inside");
//          print(arr[0].telephone);
          prefs.setString('phone', arr[0]['telephone']);
          prefs.setString('postalcode', arr[0]['postalcode']);
          var street = arr[0]['street'];
          if (street.length > 0) {
            prefs.setString('street0', street[0]);
          }
          if (street.length > 1) {
            prefs.setString('street1', street[0]);
          }
        }
        setState(() {
          HomePageState.isLogin = true;
        });
        listenForUserKey();
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
        } else if (widget.toPageId == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
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

//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) =>
//                    ReviewAndPayments(),
//              ));
        }

//        return userData;
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
    addCartUserQuote();
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
    print("inside saving qut id");
    prefs.setString('userQuoteId', response.body);
    return response;
  }
}
