import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/blocs/information/information_bloc.dart';

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
    return BlocBuilder<InformationBloc, InformationState>(
      builder: (context, state) {
        if (state.informationType == InformationType.personal) {
          return Center(child: new Column(
            children: <Widget>[
              new Text("Personal")
            ],
          ));
        }
        if (state.informationType == InformationType.email) {
          return Center(child: new Column(
            children: <Widget>[
              new Text("Personal")
            ],
          ));
        }
        if (state.informationType == InformationType.location) {
          return Center(child: new Column(
            children: <Widget>[
              new Text("location")
            ],
          ));
        }
        if (state.informationType == InformationType.phone) {
          return Center(child: new Column(
            children: <Widget>[
              new Text("phone")
            ],
          ));
        }
        if (state.informationType == InformationType.lock) {
          return Center(child: new Column(
            children: <Widget>[
              new Text("lock")
            ],
          ));
        }
        if (state.informationType == InformationType.personal) {
          return Center(child: new Column(
            children: <Widget>[
              new Text("Personal")
            ],
          ));
        }
      
        return Center(child: Text('Please Select a Location'));
      },
    );
  }
}