import 'package:circular_profile_avatar/circular_profile_avatar.dart';
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
    return CircularProfileAvatar(
          widget.url, //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
          radius: 100, // sets radius, default 50.0              
          backgroundColor: Colors.transparent, // sets background color, default Colors.white
          borderWidth: 10,  // sets border, default 0.0
          borderColor: Colors.white, // sets border color, default Colors.white
          elevation: 5.0, // sets elevation (shadow of the profile picture), default value is 0.0
          foregroundColor: Colors.white.withOpacity(0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
          cacheImage: true, // allow widget to cache image against provided url
          );
  }
}