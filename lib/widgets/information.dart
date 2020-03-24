import 'package:flutter/material.dart';

enum InformationType {
  personal,
  email,
  location,
  phone,
  lock,
}

class Information extends StatefulWidget {
  final String title;
  final String data;

  @override
  State<Information> createState() => _InformationState();
  Information({Key key, @required this.title, @required this.data})
      : assert(title != null || data !=null),
        super(key: key);
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Text(widget.title,
          style: new TextStyle(
            fontSize: 25,
            color: Colors.grey
          ),
          ),
          new Text(widget.data,
          style: new TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),)
        ]
      )
    );
  }
}