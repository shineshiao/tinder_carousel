import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/blocs/user/user_bloc.dart';
import 'package:tinder_carousel/models/models.dart';

class FavoriteItem extends StatefulWidget {
  final User user;

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
  FavoriteItem({Key key, @required this.user})
      : assert(user != null),
        super(key: key);
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return new Container (
      color: Colors.white,
      child : new ListTile(
      leading: CircularProfileAvatar(
          widget.user.picture["thumbnail"], //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
          radius: 30, // sets radius, default 50.0              
          backgroundColor: Colors.transparent, // sets background color, default Colors.white
          borderWidth: 5,  // sets border, default 0.0
          borderColor: Colors.white, // sets border color, default Colors.white
          elevation: 5.0, // sets elevation (shadow of the profile picture), default value is 0.0
          foregroundColor: Colors.white.withOpacity(0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
          cacheImage: true, // allow widget to cache image against provided url
          ),
      title: new Text(widget.user.name.first + " " + widget.user.name.last, style: new TextStyle(fontWeight: FontWeight.bold),),
      subtitle: new Text(widget.user.cell),
      onTap: (){
        print("on tap User :" + widget.user.name.last);
        Navigator.of(context).pop(widget.user);
      },
      //subtitle: new Text(user.phone["cell"])
      )
    );
  }
}