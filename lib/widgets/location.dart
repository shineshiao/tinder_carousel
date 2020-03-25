import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:tinder_carousel/models/models.dart';

class LocationWidget extends StatefulWidget {
  final Location location;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
  LocationWidget({Key key, @required this.location})
      : assert(location != null),
        super(key: key);
}

class _LocationWidgetState extends State<LocationWidget> {

  TextStyle content = new TextStyle(fontSize: 25,color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Text(widget.location.street,style: content,),
        // new Text(widget.location.city,style: content,),
        // new Text(widget.location.state,style: content,),
      ],
    );
  }
}