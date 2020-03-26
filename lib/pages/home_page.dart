import 'dart:async';

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

class _MyHomePageState extends State<MyHomePage> {
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    BlocProvider.of<FavoriteListBloc>(context)
      .add(LoadFavoriteList());
    BlocProvider.of<UserBloc>(context)
      .add(FetchSampleUser());
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
                onDismissed: (DismissDirection direction) {
                  _counter ++;
                  if(direction == DismissDirection.startToEnd) {
                    BlocProvider.of<FavoriteListBloc>(context)
                    .add(SaveFavoriteList(user: user));
                    BlocProvider.of<FavoriteListBloc>(context).listen((state){
                      if( state is FavoriteListError) {
                        ErrorType errorType = state.props[0];
                        if(errorType == ErrorType.Duplicate){
                        Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: new Text("Duplicate User",
                          textAlign: TextAlign.center,),
                          backgroundColor: Colors.red,
                          duration: Duration(milliseconds : 1000),
                          behavior: SnackBarBehavior.floating,),
                          );
                        }
                      }
                    });
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: new Text("Fetch new user",
                        textAlign: TextAlign.center,),
                        backgroundColor: Colors.lightBlue[200],
                        duration: Duration(milliseconds : 1000),
                        behavior: SnackBarBehavior.floating,),
                        );
                  }
                  BlocProvider.of<UserBloc>(context)
                    .add(FetchRandomUser());
                },
                child: Card(
                color: Colors.white,
              
                child: new  Container(
                  color: Colors.grey[100],
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 100),
                child: new Stack(
                  
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Positioned(
                      top: 150.0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          color: Colors.white,
                          boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),]

                        ),
                        height: 290,
                        width: MediaQuery.of(context).size.width-50,
                        child: 
                        BottomAction(user: user)
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child:
                      new Container(
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

  
}