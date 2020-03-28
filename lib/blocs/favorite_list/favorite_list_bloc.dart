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
    return userList == null ? 0 : userList.length;
  }

  List<User> getUserList() {
    return userList;
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
    if(event is ClearFavoriteList) {
      yield* _mapClearFavoriteListToState(event);
    }
  }

  Stream<FavoriteListState> _mapLoadFavoriteListToState(LoadFavoriteList event) async* {
    yield FavoriteListLoading();
    try {
      userList = await favoriteListRepository.loadFavoriteList();
      if(userList.length == 0) {
        yield FavoriteListEmpty();
      } else {
        yield FavoriteListLoaded(userList: userList);
      }
    } catch (_) {
      yield FavoriteListError(errorType: ErrorType.Common, userList: userList);
    }
  }
  Stream<FavoriteListState> _mapSaveFavoriteListToState(SaveFavoriteList event) async* {
    yield FavoriteListLoading();
    try {
      if(!userList.contains(event.user)){
        userList.add(event.user);
        await favoriteListRepository.saveFavoriteList(userList);
        yield FavoriteListSaveSuccess(userList: userList);
        yield FavoriteListLoaded(userList: userList);
      }
      else {
        yield FavoriteListSaveError(errorType: ErrorType.Duplicate, userList:userList);
        yield FavoriteListLoaded(userList: userList);
      }
    } catch (_) {
      yield FavoriteListError(errorType: ErrorType.Common, userList: userList);
    }
    yield FavoriteListLoaded(userList: userList);
  }
  Stream<FavoriteListState> _mapClearFavoriteListToState(ClearFavoriteList event) async* {
    yield FavoriteListLoading();
    try {
      userList = new List();
      await favoriteListRepository.clearFavoriteList();
      yield FavoriteListEmpty();
    } catch (_) {
      yield FavoriteListError(errorType: ErrorType.Common, userList : userList);
    }
  }
}
