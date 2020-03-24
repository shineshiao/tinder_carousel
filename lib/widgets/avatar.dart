import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  final String url;

  @override
  State<Avatar> createState() => _AvatarState();
  Avatar({Key key, @required this.url})
      : assert(url != null),
        super(key: key);
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 150.0,
      height: 150.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          //borderRadius: BorderRadius.all(Radius.circular(8.0)),
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(widget.url)
          )
      ));
  }
}