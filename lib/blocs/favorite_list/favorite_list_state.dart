import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tinder_carousel/models/models.dart';

abstract class FavoriteListState extends Equatable {
  const FavoriteListState();
  @override
  List<Object> get props => [];
}

class FavoriteListInitial extends FavoriteListState {
}

class FavoriteListEmpty extends FavoriteListState {}

class FavoriteListLoading extends FavoriteListState {}

class FavoriteListLoaded extends FavoriteListState {
  final List<User> userList;

  const FavoriteListLoaded({@required this.userList}) : assert(userList != null);

  @override
  List<Object> get props => [userList];
}

class FavoriteListError extends FavoriteListState {}