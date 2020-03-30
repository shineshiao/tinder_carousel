// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_bloc.dart';
import 'package:tinder_carousel/blocs/information/information_bloc.dart';
import 'package:tinder_carousel/blocs/user/user_bloc.dart';

import 'package:tinder_carousel/main.dart';
import 'package:tinder_carousel/models/models.dart';
import 'package:tinder_carousel/pages/home_page.dart';
import 'package:tinder_carousel/repositories/favorite_list.dart';
import 'package:tinder_carousel/repositories/user.dart';
class MockFavoriteListRepository extends Mock implements FavoriteListRepository {}
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  const jsonstr = "{\"results\":[{\"gender\":\"female\",\"name\":{\"title\":\"miss\",\"first\":\"ramona\",\"last\":\"carter\"},\"location\":{\"street\":\"2286 frances ct\",\"city\":\"townsville\",\"state\":\"queensland\",\"postcode\":6699},\"email\":\"ramona.carter@example.com\",\"login\":{\"username\":\"bigrabbit281\",\"password\":\"salvador\",\"salt\":\"NgEKDglD\",\"md5\":\"8946b15e0a5411bfdb52df5ac1b90520\",\"sha1\":\"f460f12a714919499d413a69a76ca2f262e9c198\",\"sha256\":\"fbb37b276b0900fcfdcfc47f0584f9859726c3791b9b0e453dbac8178be26412\"},\"dob\":\"1977-05-01 13:29:43\",\"registered\":\"2009-05-12 00:46:03\",\"phone\":\"08-4889-2804\",\"cell\":\"0479-076-830\",\"id\":{\"name\":\"TFN\",\"value\":\"212902602\"},\"picture\":{\"large\":\"https:\/\/randomuser.me\/api\/portraits\/women\/90.jpg\",\"medium\":\"https:\/\/randomuser.me\/api\/portraits\/med\/women\/90.jpg\",\"thumbnail\":\"https:\/\/randomuser.me\/api\/portraits\/thumb\/women\/90.jpg\"},\"nat\":\"AU\"}],\"info\":{\"seed\":\"7d4db9727474515a\",\"results\":1,\"page\":1,\"version\":\"1.1\"}}";
  dynamic json = jsonDecode(jsonstr);
  final User sampleUser = User.fromJson(json["results"][0]);
  final List<User> sampleUserList = new List();
  sampleUserList.add(sampleUser);

  MockUserRepository userRepository = new MockUserRepository();
  MockFavoriteListRepository favoriteListRepository = new MockFavoriteListRepository();
    testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(userRepository: userRepository),
        ),
        BlocProvider<InformationBloc>(
          create: (context) => InformationBloc(),
        ),
        BlocProvider<FavoriteListBloc>(
          create: (context) => FavoriteListBloc(favoriteListRepository: favoriteListRepository),
        ),
      ],
      child: 
       MyApp(userRepository: userRepository)
    ),
    );

    // Swipe the item to dismiss it.
  await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));
  // Build the widget until the dismiss animation ends.
  await tester.pumpAndSettle();

  // Ensure that the item is no longer on screen.
  expect(find.text('Notice'), findsOneWidget);

    // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
