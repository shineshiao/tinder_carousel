import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_bloc.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_event.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_state.dart';
import 'package:tinder_carousel/blocs/information/information_bloc.dart';
import 'package:tinder_carousel/blocs/user/user_bloc.dart';
import 'package:tinder_carousel/widgets/avatar.dart';
import 'package:tinder_carousel/widgets/bottom_bar.dart';
import 'package:tinder_carousel/widgets/favorite_button.dart';
import 'package:tinder_carousel/widgets/information.dart';

import 'favorite_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum NotifyStyle {
    snackbar,
    dialog
  }

class _MyHomePageState extends State<MyHomePage> {
  Completer<void> _refreshCompleter;
  ConnectivityResult _connectivityResult;
  var subscription;
  var favoriteListSubscription;
  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    BlocProvider.of<FavoriteListBloc>(context)
      .add(LoadFavoriteList());
    BlocProvider.of<UserBloc>(context)
      .add(FetchSampleUser());
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      _connectivityResult = result;
      print("_connectivityResult : " + _connectivityResult.toString());
    });

    favoriteListSubscription = BlocProvider.of<FavoriteListBloc>(context).listen((state){
      if(state is FavoriteListSaveError && state.props[0] == ErrorType.Duplicate) {
        showNotify(context,NotifyStyle.dialog, "This user already in favorite list.");
      }
      if(state is FavoriteListSaveSuccess) {
        showNotify(context, NotifyStyle.dialog, "This user is saved to favorite list successfully.");
      }
    });
  }

  @override
  void dispose() {
    subscription.close();
    favoriteListSubscription.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    int _counter = 0;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body:
      Center(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer<void>();
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is UserLoaded) {
              final user = state.user;
              BlocProvider.of<InformationBloc>(context)
                  .add(InformationChanged(type: InformationType.personal));

                return new Dismissible(
                resizeDuration: null,
                confirmDismiss: (DismissDirection direction) async {
                  if(_connectivityResult != ConnectivityResult.none) {
                    if(direction == DismissDirection.startToEnd) {
                      BlocProvider.of<FavoriteListBloc>(context)
                      .add(SaveFavoriteList(user: user));
                      return false;
                    }
                      return true;
                  }
                  else {
                    if(direction == DismissDirection.startToEnd) {
                      BlocProvider.of<FavoriteListBloc>(context)
                      .add(SaveFavoriteList(user: user));
                      return false;
                    } else {
                      showNotify(context,NotifyStyle.snackbar, "Device offline, Can not find new user");
                      return false;
                    }
                  }
                   
                },
                onDismissed: (DismissDirection direction) {
                  _counter ++;
                  if(direction == DismissDirection.endToStart) {
                    showNotify(context,NotifyStyle.snackbar, "Find new friend");
                     BlocProvider.of<UserBloc>(context)
                  .add(FetchRandomUser());  
                  }
                                 
                },
                child: Container(
                //color: Colors.white,
              
                child: new  Card(
                  color:Colors.blue[500],
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 100),
                child: new Stack(
                  
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 150),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]
                      ),
                      child: 
                      BottomAction(user: user)
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child:
                      new Container(
                        color: Colors.transparent,
                        height: 200,
                        width: 200,
                        child: Avatar(url: user.picture["large"]),
                      ),
                    ),
                  ],
                )
              )
              )
              
              , key: new ValueKey(_counter),
              );
            }
            if (state is UserError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            return Center(child: Text('Please Select a User'));
          },
        ),
      ),
      floatingActionButton: FavoriteButton()
    );
  }
  
  void showNotify(BuildContext context,NotifyStyle style, String text){
  
    if(style == NotifyStyle.snackbar) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: new Text(text,
        textAlign: TextAlign.center,),
        backgroundColor: Colors.lightBlue[200],
        duration: Duration(milliseconds : 1000),
        behavior: SnackBarBehavior.floating,
        ),
      );
    }
    if(style == NotifyStyle.dialog) {
      showDialog(
        context: context,
        builder: (BuildContext context){
            return AlertDialog(
              title: Text("Notice"),
              content: Text(text),
            );
        }
      );
    }
  }
  
}