import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tinder_carousel/models/models.dart';

abstract class FavoriteListEvent extends Equatable {
  const FavoriteListEvent();
  @override
  List<Object> get props => [];
}

class LoadFavoriteList extends FavoriteListEvent {
}

class SaveFavoriteList extends FavoriteListEvent {
  final User user;
  const SaveFavoriteList({@required this.user});
  @override
  List<Object> get props => [user];
}

class ClearFavoriteList extends FavoriteListEvent {
}

class RemoveUserFavoriteList extends FavoriteListEvent {
  final User user;
  const RemoveUserFavoriteList({@required this.user});
  @override
  List<Object> get props => [user];
}