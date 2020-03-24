import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/blocs/information/information_bloc.dart';

import '../blocs/information/information_bloc.dart';
import '../blocs/information/information_bloc.dart';
import '../blocs/information/information_bloc.dart';
import '../models/models.dart';

enum InformationType {
  personal,
  email,
  location,
  phone,
  lock,
}

class Information extends StatefulWidget {
  final User user;

  @override
  State<Information> createState() => _InformationState();
  Information({Key key, @required this.user})
      : assert(user != null),
        super(key: key);
}

class _InformationState extends State<Information> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<InformationBloc>(context).add(InformationChanged(type: InformationType.personal));
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InformationBloc, InformationState>(
      builder: (context, state) {
        if(state is InformationLoading) {
          return Center(child: CircularProgressIndicator());
        }
        else if(state is InformationLoaded) {
          if (state.informationType == InformationType.personal) {
            return Center(child: new Column(
              children: <Widget>[
                new Text("Personal"),
                new Text(widget.user.name.first + " " + widget.user.name.last)
              ],
            ));
          }
          if (state.informationType == InformationType.email) {
            return Center(child: new Column(
              children: <Widget>[
                new Text("Email"),
                new Text(widget.user.email)
              ],
            ));
          }
          if (state.informationType == InformationType.location) {
            return Center(child: new Column(
              children: <Widget>[
                new Text("location"),
                new Text(widget.user.location.props.toString())
              ],
            ));
          }
          if (state.informationType == InformationType.phone) {
            return Center(child: new Column(
              children: <Widget>[
                new Text("phone"),
                new Text(widget.user.phone),
                new Text(widget.user.cell),
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
        }
        else if(state is InformationEmpty) {
          return Center(child: Text('Please choose 1 profile'));
        }
        return Center(child: Text('Something error'));
      },
    );
  }
}