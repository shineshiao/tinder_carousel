import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/pages/home_page.dart';
import 'package:tinder_carousel/repositories/user.dart';
import 'package:tinder_carousel/simple_bloc_delegate.dart';

import 'blocs/information/information_bloc.dart';
import 'blocs/user/user_bloc.dart';

void main() {

  final UserRepository userRepository = UserRepository();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  
  runApp(
    //MultiBlocProvider(
      // providers: [
      //   BlocProvider<UserBloc>(
      //     create: (context) => UserBloc(),
      //   ),
        
      // ],
      // child: 
      MyApp(userRepository: userRepository),
    //),
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final UserRepository userRepository;

  MyApp({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'Flutter Tinder',
          home: BlocProvider(
            create: (context) => UserBloc(
              userRepository: userRepository,
            ),
            child: MyHomePage(title: "Flutter Tinder",),
          ),
        );
  }
}
