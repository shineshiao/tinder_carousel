import 'package:flutter/material.dart';
import 'package:tinder_carousel/widgets/information.dart';

class BottomAction extends StatefulWidget {
  final InformationType type;

  @override
  State<BottomAction> createState() => _BottomActionState();
  BottomAction({Key key, @required this.type})
      : assert(type != null),
        super(key: key);
}

class _BottomActionState extends State<BottomAction> {
  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(icon: Icon(Icons.person), onPressed: () {},),
          IconButton(icon: Icon(Icons.email), onPressed: () {},),
          IconButton(icon: Icon(Icons.map), onPressed: () {},),
          IconButton(icon: Icon(Icons.phone), onPressed: () {},),
          IconButton(icon: Icon(Icons.lock), onPressed: () {},),
        ],
    );
  }
}

