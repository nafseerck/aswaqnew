import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  GlobalKey<FormState> _key = new GlobalKey();
 static TextEditingController messageController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  static TextEditingController emailController = new TextEditingController();
  static TextEditingController phoneController = new TextEditingController();
  bool _validate = false;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  Email email = Email(
      to: ['customerservice@aswaqrak.ae']
  );
  Email submitEmail = Email(
      to: ['customerservice@aswaqrak.ae'],
      body:  'mail id = ' + emailController.text + '\n ' +  'phone number:' + phoneController.text + '\n ' + 'Message = ' + messageController.text
  );
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: AppColor.whiteColor,
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
          'Contact Us',
          style: TextStyle(fontFamily: 'montserrat',
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ListTile(
                  title: Text(
                    'Hotlline',
                    style: new TextStyle( fontFamily: 'montserrat',
                      fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                    ),
                  ),
                  subtitle: Text(
                    '600500202',
                    style: new TextStyle( fontFamily: 'montserrat',
                      fontSize: 13.0,
                      //                                  color: UniversalVariables.blackColor
                    ),
                  ),
                  trailing:  Icon(Icons.phone, color: HexColor("302c98"),size: 20,),
                  onTap: () async{
                    FlutterPhoneDirectCaller.callNumber("600-500-202");
                  },
                  ),

            ),
            Divider(
              height: 2,
              thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
              indent: 25,
              endIndent: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: ListTile(
                  title: Text(
                    'Email',
                    style: new TextStyle( fontFamily: 'montserrat',
                      fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                    ),
                  ),
                  subtitle: Text(
                    'customerservice@aswaqrak.ae',
                    style: new TextStyle( fontFamily: 'montserrat',
                      fontSize: 13.0,
                      //                                  color: UniversalVariables.blackColor
                    ),
                  ),
                  trailing:  Icon(Icons.email, color: HexColor("302c98"),size: 20,),
                  onTap: () async {
//
                    await EmailLauncher.launch(email);
                  }),
            ),
            Divider(
              height: 2,
              thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
              indent: 25,
              endIndent: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: ListTile(
                  title: Text(
                    'Social Media',
                    style: new TextStyle( fontFamily: 'montserrat',
                      fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                    ),
                  ),

                  trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('assets/images/icons/facebook.png', height: 20,color: HexColor("302c98")),

                      onPressed:  () async {
                        const url = 'https://www.facebook.com/rak.nationalmarkets/';

                        if (await canLaunch(url)) {
                          await launch(url, forceWebView: true);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }, // null disables the button
                    ),

                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/icons/instagram.png', height: 20,color: HexColor("302c98")),

                      onPressed:  () async {
                        const url = 'https://www.instagram.com/rak.nationalmarkets/';

                        if (await canLaunch(url)) {
                          await launch(url, forceWebView: true);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }, // null disables the button
                    ),

                    SizedBox(
                      width: 10,
                    ),

                  ],
              ),


              ),
            ),
            Divider(
              height: 2,
              thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
              indent: 25,
              endIndent: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text('Get in Touch',style: TextStyle( fontFamily: 'montserrat', fontSize: 18, fontWeight: FontWeight.w500),),
            ),
            Padding(
               padding: const EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 10),
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
                        style: TextStyle( fontFamily: 'montserrat',
                          color: Colors.black87,
                          // fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Name',
                          contentPadding: EdgeInsets.only(top: 5, left: 10,),
                          hintStyle: TextStyle( fontFamily: 'montserrat',
                           fontSize: 14,
                          ),
                          border: OutlineInputBorder(),
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
                        style: TextStyle( fontFamily: 'montserrat',
                          color: Colors.black87,
                          // fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5, left: 10,),
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          hintStyle: TextStyle( fontFamily: 'montserrat', ),
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
                        controller: phoneController,
                        validator: validateMobile,
                        keyboardType: TextInputType.text,
                        style: TextStyle( fontFamily: 'montserrat',
                          color: Colors.black87,
                          // fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5, left: 10,),
                          border: OutlineInputBorder(),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle( fontFamily: 'montserrat', ),
                        ),
                      ),
                    ),
                    Container(
                      height: 140,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: messageController,
                        validator: validateMessage,
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        style: TextStyle( fontFamily: 'montserrat',
                          color: Colors.black87,
                          // fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5, left: 10,),
                          border: OutlineInputBorder(),
                          hintText: 'Message',
                          hintStyle: TextStyle( fontFamily: 'montserrat', ),
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
                          if (_key.currentState
                              .validate()) {
                            await EmailLauncher.launch(submitEmail);
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
                        color: HexColor("302c98"),
                        child: Text(
                          'SUBMIT',
                          style: TextStyle( fontFamily: 'montserrat',
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

          ],
    ),
      )

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
  String validateMessage(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Message is Required";
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

    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
  }
}