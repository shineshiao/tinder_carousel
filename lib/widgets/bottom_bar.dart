import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_carousel/blocs/information/information_bloc.dart';
import 'package:tinder_carousel/models/user.dart';
import 'package:tinder_carousel/widgets/information.dart';

class BottomAction extends StatefulWidget {
  //final InformationType type;
  final User user;
  @override
  State<BottomAction> createState() => _BottomActionState();
  BottomAction({Key key, @required this.user})
      : assert(user != null),
        super(key: key);
}

class _BottomActionState extends State<BottomAction> {
  int index = 0;
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: choices.length,
        child: Scaffold(
          body: TabBarView(
            physics: new NeverScrollableScrollPhysics(),
            children: choices.map((Choice choice) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10,100,10,10),
                child: Information(user: widget.user,),
              );
            }).toList(),
          ),
          bottomNavigationBar: TabBar(
              isScrollable: true,
              onTap: (index) {
                if(index == 0) {
                  BlocProvider.of<InformationBloc>(context)
                  .add(InformationChanged(type: InformationType.personal));
                }
                if(index == 1) {
                  BlocProvider.of<InformationBloc>(context)
                  .add(InformationChanged(type: InformationType.email));
                }
                if(index == 2) {
                  BlocProvider.of<InformationBloc>(context)
                  .add(InformationChanged(type: InformationType.location));
                }
                if(index == 3) {
                  BlocProvider.of<InformationBloc>(context)
                  .add(InformationChanged(type: InformationType.phone));
                }
                if(index == 4) {
                  BlocProvider.of<InformationBloc>(context)
                  .add(InformationChanged(type: InformationType.lock));
                }
              },
              unselectedLabelColor: Colors.redAccent,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
                insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
              ),
              tabs: choices.map((Choice choice) {
                return Tab(
                  icon: Icon(choice.icon,size: 35,color: Colors.blue,),
                );
              }).toList(),
            ),
        ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Name', icon: Icons.person),
  const Choice(title: 'Email', icon: Icons.email),
  const Choice(title: 'Address', icon: Icons.map),
  const Choice(title: 'Phone', icon: Icons.phone),
  const Choice(title: 'Lock', icon: Icons.lock),
];