import 'package:Alaswaq/account/profile/edit_my_account.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  String fromPage = "" ;
  MyAccount( this.fromPage);
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  static var userName =  "";
  static var phoneNum =  "";
  static var isloggedIn = false;
  List<String >street = new List<String>();
  var city = "" ;
  var password = "" ;
  var emailid = "" ;
  void initState()  {
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

        // hides leading widget
//        flexibleSpace: Container(),
        leading: widget.fromPage != "from Bottom" ?  IconButton(
            icon:  Icon( Icons.keyboard_backspace, color: Colors.black, size: 40,),
            onPressed: () {
              if(widget.fromPage == "from Login") {
                print( widget.fromPage);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              } else {
                print( widget.fromPage);
                Navigator.of(context).pop();

              }
            }



        ) : Container(),

        title: Text(
          'My Account',
          style: TextStyle( fontFamily: 'montserrat',
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: Icon(Icons.border_color,color: Colors.black,size: 20,), onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditMyAccount()));
          })
        ],
      ),
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15,bottom: 15, right: 20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Name',
                    style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,),
                  ),
                  SizedBox(

                    child:
                    FlatButton(

                      onPressed: () async {
//                        Navigator.pushReplacement(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) => EditName(),
//                          ),
//                        );
                      },

                      child:
                      Row(
                        children: [
                          Text(userName, style: TextStyle( fontFamily: 'montserrat', 
                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,
                          )
                          ),
//                          Icon(Icons.chevron_right)
                        ],
                      ),
//                              textColor: MyColors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                          style: BorderStyle.solid
                      ), borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Email',
                    style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,),
                  ),
                  SizedBox(

                    child:
                    FlatButton(
                      onPressed: () async {
//                        Navigator.pushReplacement(
//                          context,
//                          MaterialPageRoute(builder: (context) => EditProfileField("Change Email")),
//
//                        );
                      },
                      child:
                      Row(
                        children: [
                          Text(emailid, style: TextStyle( fontFamily: 'montserrat', 
                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,
                          )
                          ),
//                          Icon(Icons.chevron_right)
                        ],
                      ),
//                              textColor: MyColors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                          style: BorderStyle.solid
                      ), borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
//                  Text(
//                    'Mobile',
//                    style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,),
//                  ),
//                  SizedBox(
//
//                    child:
//                    FlatButton(
//                      onPressed: () async {
////                        Navigator.pushReplacement(
////                          context,
////                          MaterialPageRoute(builder: (context) => EditMobile()),
////                        );
//                      },
//                      child:
//                      Row(
//                        children: [
//                        ],
//                      ),
////                              textColor: MyColors.white,
//                      shape: RoundedRectangleBorder(side: BorderSide(
//                          color: Colors.white,
//                          width: 0.5,
//                          style: BorderStyle.solid
//                      ), borderRadius: BorderRadius.circular(5)),
//                    ),
//                  ),
                ],
              ),
              Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Password',
                    style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,),
                  ),
                  SizedBox(

                    child:
                    FlatButton(
                      onPressed: () async {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => EditPassword(password)),
//                        );
                      },
                      child:
                      Row(
                        children: [
                          Text('............', style: TextStyle( fontFamily: 'montserrat',
                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,
                          )
                          ),
//                          Icon(Icons.chevron_right)
                        ],
                      ),
//                              textColor: MyColors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                          style: BorderStyle.solid
                      ), borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 1,
              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    'Address',
//                    style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,),
//                  ),
//                  SizedBox(
//
//                    child:
//                    FlatButton(
//                      onPressed: () async {
////                        Navigator.push(
////                          context,
////                          MaterialPageRoute(builder: (context) => EditProfileField("Change Address")),
////                        );
//                      },
//                      child:
//                      Row(
//                        children: [
//                          Text("city", style: TextStyle( fontFamily: 'montserrat',
//                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,
//                          )
//                          ),
////                          Icon(Icons.chevron_right)
//                        ],
//                      ),
////                              textColor: MyColors.white,
//                      shape: RoundedRectangleBorder(side: BorderSide(
//                          color: Colors.white,
//                          width: 0.5,
//                          style: BorderStyle.solid
//                      ), borderRadius: BorderRadius.circular(5)),
//                    ),
//                  ),
//                ],
//              ),
              Divider(
                height: 1,
              ),

            ],
          ),
        ),
      ),

    );
  }

  Future<bool> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();


  setState(() {
    userName =   prefs.getString('firstname');
    phoneNum =  prefs.getString('phone');
    street =   prefs.getStringList('street');
    city =  prefs.getString('city');
    password =  prefs.getString('password');
    emailid = prefs.getString('email');
  }

  );



  }
}
