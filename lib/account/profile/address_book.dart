
// ignore: must_be_immutable
import 'dart:convert';
import 'dart:io';

import 'package:Alaswaq/Model/register_model.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Alaswaq/payment/review_and_payments.dart';
import 'address_profile_edit.dart';
import 'package:http/http.dart' as http;
class AddressBook extends StatefulWidget {
  @override
  AddressBookState createState() => AddressBookState();
}

class AddressBookState extends State<AddressBook> {

static int addressIndex = 0;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  UserRegistration userreg_model ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await addOrderAddressUser();
    });
  }
  @override
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
          'Address Book',
          style: TextStyle(fontFamily: 'montserrat',
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),

      ),
      body:
    SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
    height: 45,
    color: Colors.white,
    child: Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child:  Text('All Address List',
                  style: TextStyle(
              color:  Colors.black, fontSize: 14,fontFamily: 'montserrat', fontWeight: FontWeight.w600
              )
              ),
            ),
      Padding(
        padding: const EdgeInsets.only(right: 15, top: 10),
        child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width * .5,
          decoration: BoxDecoration(
              color: HexColor("302d98"),
              borderRadius: BorderRadius.circular(5)),
          child:FlatButton(

            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddressProfileEdit("from Address")),
              );
            },
            child:
            Text(
              ' + ADD NEW ADDRESS',
              style: TextStyle( fontFamily: 'montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            //
          ),
        ),
      ),

          ],
        ),
    ),
    Container(
    height: MediaQuery.of(context).size.height*.82,
          child: ListView.builder(
//                              shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: userreg_model.addresses.length, itemBuilder: (context, index) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.5 ,
              height: 160.0,

              child:
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child : Card(

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),

                        ),
                        elevation: 5,
                        clipBehavior: Clip.antiAlias,
//                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              ReviewAndPaymentsState.userName = userreg_model.addresses[index].firstname;
                              ReviewAndPaymentsState.phoneNum = userreg_model.addresses[index].telephone;
                              ReviewAndPaymentsState.street0= userreg_model.addresses[index].street[0];
                              if(userreg_model.addresses[index].street.length > 0 ){
                                ReviewAndPaymentsState.street1= userreg_model.addresses[index].street[1];
                              }
                              ReviewAndPaymentsState.city= "Ras Al-Khaimah";
                              ReviewAndPaymentsState.emailid = userreg_model.email;
                              addressIndex = index;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewAndPayments("from address"),
                                ),
                              );
                            });




                          },
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Container(
                                height: 160,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width/ 1.5,
                                alignment: Alignment.center,
                                child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row (
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(userreg_model.addresses[index].firstname + "( " + userreg_model.addresses[index].telephone + ")",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'montserrat',
                                              color: HexColor("302d98")

                                          ),

                                        ),
                                        new GestureDetector(
                                            child: new Icon(
                                              Icons.delete,
                                              size: 20,
                                              color: Colors.red,
                                            ),
//                                              color: Colors.black,
                                            onTap: () {

                                              setState(() {
                                                userreg_model.addresses.removeAt(index);
                                              });

                                            }


                                        ),

                                      ],
                                    ),


                                    userreg_model.addresses[index].street.length >= 0 ? Text(userreg_model.addresses[index].street[0] ,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'montserrat',
                                          color: Colors.black

                                      ),

                                    ) : Container(),
                                    userreg_model.addresses[index].street.length >= 1 ? Text(userreg_model.addresses[index].street[1] ,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'montserrat',
                                          color: Colors.black

                                      ),

                                    ) : Container(),
                                    Text(userreg_model.addresses[index].city ,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'montserrat',
                                          color: Colors.black

                                      ),


                                    ),
                                    Text("United Arab Emirates" ,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'montserrat',
                                          color: Colors.black

                                      ),
                                    ),
                                  ],

                                )


//
                            ),
                          ),
                        )
                    ),
                  ),





            );
          },
        );
      },
      ),
    )
    ],
    ),
    ),
    );
  }
  Future addOrderAddressUser() async {
    print("called address for user");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    print(token);
    String headerText = "Bearer " + token2;

    final response = await http.get(Uri.parse(
      baseUrl + 'rest/V1/customers/me'),
      headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText},
    );
    final responseJson = json.decode(response.body);

    var arr = responseJson['addresses'];
    setState(() {
      userreg_model =   UserRegistration.fromJson(responseJson);
    });

    print(responseJson['addresses']);
    print("address responsee user");
    print(responseJson);

  }
}