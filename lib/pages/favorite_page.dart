import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_bloc.dart';
import 'package:tinder_carousel/models/models.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<User> userList = new List();
  @override
  void initState() {
    super.initState();
    userList = BlocProvider.of<FavoriteListBloc>(context).getUserList();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite User"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ), 
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: userList.length,
        itemBuilder: (BuildContext context, int index) {
          return favoriteItem(userList[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )
    );
  }

  Widget favoriteItem(User user) {
    return new Container (
      color: Colors.pink[200],
      child : new ListTile(
      leading: new Image.network(user.picture["thumbnail"]),
      title: new Text(user.name.first + " " + user.name.last),
      subtitle: new Text(user.cell),
      onTap: (){
        print("on tap User :" + user.name.last);
      },
      //subtitle: new Text(user.phone["cell"])
      )
    );
  }
}