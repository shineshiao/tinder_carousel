import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_bloc.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_state.dart';
import 'package:tinder_carousel/blocs/user/user_bloc.dart';
import 'package:tinder_carousel/pages/favorite_page.dart';

class FavoriteButton extends StatefulWidget {
  
  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
  FavoriteButton();

}

class _FavoriteButtonState extends State<FavoriteButton> {
  Completer<void> _refreshCompleter;
  @override
  Widget build(BuildContext context) {


    // FloatingActionButton.extended(
    //     onPressed: () async {
    //       final user = await Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => FavoritePage()),
    //       );
    //       if (user != null) {
    //         BlocProvider.of<UserBloc>(context)
    //             .add(LoadUser(user: user));
    //       }
    //     },
    //     label: Text(BlocProvider.of<FavoriteListBloc>(context).getListLenght().toString()),
    //     icon: Icon(Icons.favorite),
    //     backgroundColor: Colors.pink,
    //   );

    return BlocConsumer<FavoriteListBloc, FavoriteListState>(
          listener: (context, state) {
            if (state is FavoriteListLoaded) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer<void>();
            }
          },
          builder: (context, state) {
            // if (state is FavoriteListLoading) {
            //   return Center(child: CircularProgressIndicator());
            // }
            if (state is FavoriteListLoaded) { 
              return FloatingActionButton.extended(
                onPressed: () async {
                  final user = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePage()),
                  );
                  if (user != null) {
                    BlocProvider.of<UserBloc>(context)
                        .add(LoadUser(user: user));
                  }
                },
                label: Text(BlocProvider.of<FavoriteListBloc>(context).getListLenght().toString()),
                icon: Icon(Icons.favorite),
                backgroundColor: Colors.pink,
              );     
            } else {
              return FloatingActionButton(
                child:  Icon(Icons.favorite),
                onPressed: () async {
                  final user = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePage()),
                  );
                  if (user != null) {
                    BlocProvider.of<UserBloc>(context)
                        .add(LoadUser(user: user));
                  }
                },
                backgroundColor: Colors.pink,
              ); 
            }

          });
  }
}

