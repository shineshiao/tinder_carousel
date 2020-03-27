

import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_bloc.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_event.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_state.dart';
import 'package:tinder_carousel/models/models.dart';
import 'package:tinder_carousel/repositories/favorite_list.dart';

class MockFavoriteListRepository extends Mock implements FavoriteListRepository {}

main() {
  const jsonstr = "{\"results\":[{\"gender\":\"female\",\"name\":{\"title\":\"miss\",\"first\":\"ramona\",\"last\":\"carter\"},\"location\":{\"street\":\"2286 frances ct\",\"city\":\"townsville\",\"state\":\"queensland\",\"postcode\":6699},\"email\":\"ramona.carter@example.com\",\"login\":{\"username\":\"bigrabbit281\",\"password\":\"salvador\",\"salt\":\"NgEKDglD\",\"md5\":\"8946b15e0a5411bfdb52df5ac1b90520\",\"sha1\":\"f460f12a714919499d413a69a76ca2f262e9c198\",\"sha256\":\"fbb37b276b0900fcfdcfc47f0584f9859726c3791b9b0e453dbac8178be26412\"},\"dob\":\"1977-05-01 13:29:43\",\"registered\":\"2009-05-12 00:46:03\",\"phone\":\"08-4889-2804\",\"cell\":\"0479-076-830\",\"id\":{\"name\":\"TFN\",\"value\":\"212902602\"},\"picture\":{\"large\":\"https:\/\/randomuser.me\/api\/portraits\/women\/90.jpg\",\"medium\":\"https:\/\/randomuser.me\/api\/portraits\/med\/women\/90.jpg\",\"thumbnail\":\"https:\/\/randomuser.me\/api\/portraits\/thumb\/women\/90.jpg\"},\"nat\":\"AU\"}],\"info\":{\"seed\":\"7d4db9727474515a\",\"results\":1,\"page\":1,\"version\":\"1.1\"}}";
  dynamic json = jsonDecode(jsonstr);
  final User sampleUser = User.fromJson(json["results"][0]);
  final List<User> sampleUserList = new List();
  sampleUserList.add(sampleUser);

  group('FavoriteListMock', () {
    MockFavoriteListRepository favoriteListRepository;
    FavoriteListBloc favoriteListBloc;

    setUp(() {
      favoriteListRepository = MockFavoriteListRepository();
      favoriteListBloc = FavoriteListBloc(favoriteListRepository: favoriteListRepository);
    });

    tearDown(() {
      favoriteListBloc?.close();
    });

    test('throws AssertionError when favoriteListRepository is null', () {
      expect(() => FavoriteListBloc(favoriteListRepository: null), throwsAssertionError);
    });

    test('has a correct initialState', () {
      expect(favoriteListBloc.initialState, FavoriteListInitial());
    });

    group('LoadFavoriteList', () {
      blocTest(
        'emits [FavoriteListLoading, FavoriteListLoaded] when favorite list repository returns list user',
        build: () async {
          when(favoriteListRepository.loadFavoriteList()).thenAnswer(
            (_) => Future.value(sampleUserList),
          );
          return favoriteListBloc;
        },
        act: (bloc) => bloc.add(LoadFavoriteList()),
        expect: [
          FavoriteListLoading(),
          FavoriteListLoaded(userList: sampleUserList),
        ],
      );

      blocTest(
        'emits [FavoriteListLoading, FavoriteListError] when favorite list repository returns error',
        build: () async {
          when(favoriteListRepository.loadFavoriteList()).thenThrow("Error");
          return favoriteListBloc;
        },
        act: (bloc) => bloc.add(LoadFavoriteList()),
        expect: [
          FavoriteListLoading(),
          FavoriteListError(errorType: ErrorType.Common,userList: sampleUserList),
        ],
      );
    });

    group('SaveFavoriteList', () {
      blocTest(
        'emits [FavoriteListLoading, FavoriteListSaveSuccess, FavoriteListLoaded] when user add new user to list',
        build: () async {
          when(favoriteListRepository.saveFavoriteList(sampleUserList)).thenAnswer(
            (_) => Future.value(sampleUserList),
          );
          return favoriteListBloc;
        },
        act: (bloc) => bloc.add(SaveFavoriteList(user: sampleUser)),
        expect: [
          FavoriteListLoading(),
          FavoriteListSaveSuccess(userList: sampleUserList),
          FavoriteListLoaded(userList: sampleUserList),
        ],
      );

      blocTest(
        'emits [FavoriteListLoading, FavoriteListError, FavoriteListLoaded] when user add new user to list fail',
        build: () async {
          when(favoriteListRepository.saveFavoriteList(sampleUserList)).thenThrow("Duplicate");
          return favoriteListBloc;
        },
        act: (bloc) => bloc.add(SaveFavoriteList(user: sampleUser)),
        expect: [
          FavoriteListLoading(),
          FavoriteListError(errorType: ErrorType.Common, userList: sampleUserList),
        ],
      );
    });
  });
}