import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_bloc.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_event.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_state.dart';
import 'package:tinder_carousel/models/models.dart';
import 'package:tinder_carousel/widgets/favorite_item.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<User> userList = new List();
  Completer _refreshCompleter;
  @override
  void initState() {
    super.initState();
    //userList = BlocProvider.of<FavoriteListBloc>(context).getUserList();
    _refreshCompleter = Completer<void>();;
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
        actions: <Widget>[
          new IconButton(
          icon: new Icon(Icons.delete, color: Colors.white),
          onPressed: (){ 
            BlocProvider.of<FavoriteListBloc>(context).add(ClearFavoriteList());
            Navigator.of(context).pop();
          }
          )
          ],
      ),
      body: BlocConsumer<FavoriteListBloc, FavoriteListState>(
          listener: (context, state) {
            if (state is FavoriteListLoaded) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer<void>();
            }
          },
          builder: (context, state) {
            if (state is FavoriteListLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is FavoriteListLoaded) { 
              userList = state.userList;
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  return FavoriteItem(user: userList[index]);
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              );    
            }
            if(state is FavoriteListEmpty) {
              return Center(child: new Text("Please swipe right on home page to add friend farvorite list"),);
            } 
            if(state is FavoriteListError) {
              if(state.errorType == ErrorType.Duplicate) {
                userList = state.userList;
                return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FavoriteItem(user: userList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                );    
              }
            } 
               return Center(child: new Text("Something Error"),);
          })
    );
  }
}