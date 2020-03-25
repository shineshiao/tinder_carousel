import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/blocs/information/information_bloc.dart';
import 'package:tinder_carousel/widgets/location.dart';

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
    TextStyle title = new TextStyle(fontSize: 22,color: Colors.grey);
    TextStyle content = new TextStyle(fontSize: 30,color: Colors.black);
    return BlocBuilder<InformationBloc, InformationState>(
      builder: (context, state) {
        if(state is InformationLoading) {
          return Center(child: CircularProgressIndicator());
        }
        else if(state is InformationLoaded) {
          if (state.informationType == InformationType.personal) {
            return Container(child: new Column(
              children: <Widget>[
                new Text("Personal",style: title,),
                new Text(widget.user.name.first + " " + widget.user.name.last,style: content,)
              ],
            ));
          }
          if (state.informationType == InformationType.email) {
            return Container(child: new Column(
              children: <Widget>[
                new Text("Email",style: title),
                new Text(widget.user.email,style: content, textAlign: TextAlign.center,)
              ],
            ));
          }
          if (state.informationType == InformationType.location) {
            return Container(child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Text("My Address is",style: title),
                new LocationWidget(location: widget.user.location)
              ],
            ));
          }
          if (state.informationType == InformationType.phone) {
            return Container(child: new Column(
              children: <Widget>[
                new Text("Phone",style: title),
                new Text(widget.user.phone , style: content,),
                new Text(widget.user.cell , style: content,),
              ],
            ));
          }
          if (state.informationType == InformationType.lock) {
            return Container(child: new Column(
              children: <Widget>[
                new Text("lock",style: title)
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