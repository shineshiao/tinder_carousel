import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_event.dart';
import 'package:tinder_carousel/blocs/favorite_list/favorite_list_state.dart';
import 'package:tinder_carousel/models/models.dart';
import 'package:tinder_carousel/repositories/favorite_list.dart';
import 'package:tinder_carousel/repositories/user.dart';


class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  final FavoriteListRepository favoriteListRepository;
  List<User> userList = new List();

  FavoriteListBloc({@required this.favoriteListRepository})
      : assert(favoriteListRepository != null);

  int getListLenght() {
    print("List Length : " + userList.length.toString());
    return userList == null ? 0 : userList.length;
  }

  @override
  FavoriteListState get initialState => FavoriteListInitial();

  @override
  Stream<FavoriteListState> mapEventToState(
    FavoriteListEvent event,
  ) async* {
    if (event is LoadFavoriteList) {
      yield* _mapLoadFavoriteListToState(event);
    }
    if(event is SaveFavoriteList) {
      yield* _mapSaveFavoriteListToState(event);
    }
  }

  Stream<FavoriteListState> _mapLoadFavoriteListToState(LoadFavoriteList event) async* {
    yield FavoriteListLoading();
    try {
      userList = favoriteListRepository.loadFavoriteList();
      yield FavoriteListLoaded(userList: userList);
    } catch (_) {
      yield FavoriteListError();
    }
  }
  Stream<FavoriteListState> _mapSaveFavoriteListToState(SaveFavoriteList event) async* {
    yield FavoriteListLoading();
    try {
      userList.add(event.user);
      favoriteListRepository.saveFavoriteList(userList);
      yield FavoriteListLoaded(userList: userList);
    } catch (_) {
      yield FavoriteListError();
    }
  }
}
