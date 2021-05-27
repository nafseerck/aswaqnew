import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelHandle extends StatefulWidget {
  List<String> data;
  MethodChannelHandle(List<String> data){
    this.data = data;
  }
  @override
  _MethodChannelHandleState createState() => _MethodChannelHandleState();
}

class _MethodChannelHandleState extends State<MethodChannelHandle> {

  static const platform = MethodChannel("host");
  //static const EventChannel eventChannel = EventChannel('samples.flutter.io/charging');
  String text;
  @override
  void initState() {
    super.initState();
    text="Failed";
    platform.setMethodCallHandler(nativeMethodCallHandler);
    Printy();
  }


  void Printy() async
  {
    String tempVal;
    try {
      tempVal = await platform.invokeMethod('invokingfromdart', widget.data);
      print("My Temp : $tempVal");

    } catch (e) {
      print(e);
    }

    //await platform.setMethodCallHandler(nativeMethodCallHandler);
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    print('Native call!');
    switch (methodCall.method) {
      case "invokingfromdart" :
        print("payment success");
       /* Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ThankYouPage(orderID: orderID)));*/
        /*   setState(() {
          HomePage.cartCount = 0 ;
        });
        callAfterPaymentSuccess();
       _showFailureDialog("Payment Success");*/
        setState(() {
          text = "Success";
        });
        return print("success payment");
        break;
      default:
        return print("failed payment");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Text(text,style: TextStyle(color: Colors.black,fontSize: 25.0),)
        ],
      ),
    );
  }
}