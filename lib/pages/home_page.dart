import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/blocs/user/user_bloc.dart';
import 'package:tinder_carousel/widgets/avatar.dart';
import 'package:tinder_carousel/widgets/bottom_bar.dart';
import 'package:tinder_carousel/widgets/information.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    BlocProvider.of<UserBloc>(context)
                    .add(FetchSampleUser());
  }
  @override
  Widget build(BuildContext context) {
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
      ),
      body:
      Center(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is UserLoaded) {
              final user = state.user;

              return new Card(
                color: Colors.white,
              
                child: new  Container(
                  color: Colors.grey[100],
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 100),
                child: new Stack(
                  
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Positioned(
                      top: 100.0,
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
                        height: 340,
                        width: MediaQuery.of(context).size.width-50,
                        //width: 300,
                        child: 
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children : <Widget>[
                            new Expanded(child: new Container(height: 120,)),
                            new Container(child: Information(user: user,),
                          ),
                          new Expanded(child: new Container()),
                          new Container(
                            height: 50,
                            child:BottomAction(type: InformationType.personal)
                          ),
                        ])
                      
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
              ));
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
      //  Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: new Card(
      //     child: Container(
      //     width: MediaQuery.of(context).size.width -40,
      //     height: MediaQuery.of(context).size.height /2,
      //     child: new Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: <Widget>[
      //         Avatar(url: "https://randomuser.me/api/portraits/women/90.jpg"),
      //         Information(title: "Name",data: "test",),
      //         new Expanded(child: new Container()),
      //         BottomAction(type: InformationType.personal)
      //       ],
      //     )
      //   ),
      //   )
      // ),
    );
  }
}