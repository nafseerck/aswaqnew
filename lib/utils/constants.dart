import 'package:Alaswaq/utils/strings.dart';
import 'package:flutter/material.dart';



//Background Image of all screen
class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 100,),
        Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Image.asset(Assets.backgroundImage,
              width: size.width*.8,
              height: size.height*.6,
              fit: BoxFit.fill,
              colorBlendMode: BlendMode.modulate),
        )
      ],
    );
  }
}

//Input Decoration for TextFields
InputDecoration kInputDecoration({String labelText, hintText, Widget prefix}) {
  return InputDecoration(
    prefix: prefix,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.blueAccent,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.tealAccent,
        width: 2.0,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: const BorderSide(color: Colors.white, width: 1.0),
    ),
    labelText: labelText,
    hintText: hintText,
    hintStyle: TextStyle( fontFamily: 'montserrat', color: Colors.white70),
    labelStyle: TextStyle( fontFamily: 'montserrat', fontSize: 15.0, color: Colors.white),
  );
}

//Exit App Dialogue
Future<bool> exitApp(BuildContext context) {
  // return showDialog(
  //   context: context,
  //   child: new AlertDialog(
  //     title: new Text('Do you want to exit this application?'),
  //     content: new Text('We hate to see you leave...'),
  //     actions: <Widget>[
  //       new FlatButton(
  //         onPressed: () => Navigator.of(context).pop(false),
  //         child: new Text('No'),
  //       ),
  //       new FlatButton(
  //         onPressed: () => Navigator.of(context).pop(true),
  //         child: new Text('Yes'),
  //       ),
  //     ],
  //   ),
  // ) ??
  //     false;
}







class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.color,
    this.bColor,
    this.tColor,
    this.text,
    this.width,
  }) : super(key: key);
  final String text;
  final Color color;
  final Color bColor;
  final Color tColor;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          height: 45,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border:
            Border.all(width: 1, color: color, style: BorderStyle.solid),
            color: bColor,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle( fontFamily: 'montserrat', 
                color: tColor,
              ),
            ),
          )),
    );
  }
}



class CustomHeader extends StatelessWidget {
  const CustomHeader({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[Text(title), Icon(Icons.unfold_more)],
    );
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({
    Key key,
    this.widget,
    this.width = 125,
  }) : super(key: key);
  final Widget widget;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          border: Border.all(
              width: 1, color: Colors.grey, style: BorderStyle.solid)),
      child: widget,
    );
  }
}


class CustomDetailsTile extends StatelessWidget {
  const CustomDetailsTile({
    Key key,
    this.color,
    this.name,
    this.status,
    this.statusName,
  }) : super(key: key);
  final String name;
  final String status;
  final String statusName;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 125,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
            /* border: Border.all(
        width: 0, color: Colors.grey.shade400, style: BorderStyle.solid), */
            color: Colors.grey.shade200,
          ),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 12,
                child: Icon(Icons.person, size: 12),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                name,
                softWrap: true,
                style: TextStyle( fontFamily: 'montserrat', fontSize: 12),
              ),

              /*    Spacer(),
                Center(
        child: FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.radio_button_checked, color: color),
            label: Column(
              children: <Widget>[
                Text(
                  status,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                Text(
                  statusName != null ? statusName : '',
                  softWrap: true,
                ),
              ],
            )),
                ),
                Spacer(),
                IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}), */
            ],
          ),
        ),
        Container(
          width: 50,
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              //bottomRight: Radius.circular(5),
              //topRight: Radius.circular(5),
            ),
            /* border: Border.all(
                  width: 0, color: Colors.grey.shade400, style: BorderStyle.solid), */
            color: Colors.grey.shade200,
          ),
          child: Row(
            children: <Widget>[
              /*   CircleAvatar(
                  child: Icon(Icons.person),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(name), */

              Center(
                child: Icon(Icons.radio_button_checked, color: color, size: 12),
              ),

              /* Spacer(),
                IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),  */
            ],
          ),
        ),
        Container(
          width: 120,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              //bottomRight: Radius.circular(5),
              //topRight: Radius.circular(5),
            ),
            /* border: Border.all(
                  width: 0, color: Colors.grey.shade400, style: BorderStyle.solid), */
            color: Colors.grey.shade200,
          ),
          child: Row(
            children: <Widget>[
              /*   CircleAvatar(
                  child: Icon(Icons.person),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(name), */

              Column(
                children: <Widget>[
                  Text(status, style: TextStyle( fontFamily: 'montserrat', fontSize: 10)),
                  Text(statusName != null ? statusName : '',
                      style: TextStyle( fontFamily: 'montserrat', fontSize: 10)),
                ],
              ),

              /* Spacer(),
                IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),  */
            ],
          ),
        ),
        Expanded(
          child: Container(
            //padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              /* border: Border.all(
                  width: 0, color: Colors.grey.shade400, style: BorderStyle.solid), */
              color: Colors.grey.shade200,
            ),
            child: Row(
              children: <Widget>[
                /*   CircleAvatar(
                  child: Icon(Icons.person),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(name), */

                Spacer(),
                IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 12,
                    ),
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

verticalSpace() {
  return SizedBox(
    height: 10,
  );
}
horizontalSpace() {
  return SizedBox(
    width: 10,
  );
}