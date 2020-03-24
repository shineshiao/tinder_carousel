import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/blocs/information/information_bloc.dart';
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
          IconButton(icon: Icon(Icons.person), onPressed: () {
            BlocProvider.of<InformationBloc>(context)
                    .add(InformationChanged(type: InformationType.personal));
          },),
          IconButton(icon: Icon(Icons.email), onPressed: () {
            BlocProvider.of<InformationBloc>(context)
                    .add(InformationChanged(type: InformationType.email));
          },),
          IconButton(icon: Icon(Icons.map), onPressed: () {
            BlocProvider.of<InformationBloc>(context)
                    .add(InformationChanged(type: InformationType.location));
          },),
          IconButton(icon: Icon(Icons.phone), onPressed: () {
            BlocProvider.of<InformationBloc>(context)
                    .add(InformationChanged(type: InformationType.phone));
          },),
          IconButton(icon: Icon(Icons.lock), onPressed: () {
            BlocProvider.of<InformationBloc>(context)
                    .add(InformationChanged(type: InformationType.lock));
          },),
        ],
    );
  }
}

